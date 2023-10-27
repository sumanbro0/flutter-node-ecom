import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/core/routes.dart';
import 'package:frontend/core/ui.dart';
import 'package:frontend/logic/cubits/cart_cubit/cart_cubit.dart';
import 'package:frontend/logic/cubits/category_cubit/category_cubit.dart';
import 'package:frontend/logic/cubits/order_cubit/order_cubit.dart';
import 'package:frontend/logic/cubits/product_cubit/product_cubit.dart';
import 'package:frontend/logic/cubits/user_cubit/user_cubit.dart';
import 'package:frontend/presentation/screens/splash/splash_screen.dart';
// import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // SharedPreferences instance = await SharedPreferences.getInstance();
  // instance.clear();
  Bloc.observer = MyBlockObserver();
  runApp(const EcommerceApp());
}

class EcommerceApp extends StatelessWidget {
  const EcommerceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => UserCubit()),
        BlocProvider(create: (context) => CategoryCubit()),
        BlocProvider(create: (context) => ProductCubit()),
        BlocProvider(
            create: (context) => CartCubit(BlocProvider.of<UserCubit>(
                    context) //provided above usercubit instance to cart
                )),
        BlocProvider(
            create: (context) => OrderCubit(
                  BlocProvider.of<UserCubit>(context),
                  BlocProvider.of<CartCubit>(context),
                )),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: Routes.onGenerateRoute,
        initialRoute: SplashScreen.routeName,
        theme: Themes.defaultTheme,
      ),
    );
  }
}

class MyBlockObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    log("Created:$bloc");
    super.onCreate(bloc);
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    log("changed $bloc:$change");
    super.onChange(bloc, change);
  }

  @override
  void onClose(BlocBase bloc) {
    log("closed $bloc");
    super.onClose(bloc);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    log("transition $bloc:$transition");
    super.onTransition(bloc, transition);
  }
}
