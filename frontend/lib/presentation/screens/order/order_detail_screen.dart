import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/core/ui.dart';
import 'package:frontend/data/models/order/order_model.dart';
import 'package:frontend/data/models/user/user_model.dart';
import 'package:frontend/logic/cubits/cart_cubit/cart_cubit.dart';
import 'package:frontend/logic/cubits/cart_cubit/cart_state.dart';
import 'package:frontend/logic/cubits/order_cubit/order_cubit.dart';
import 'package:frontend/logic/cubits/user_cubit/user_cubit.dart';
import 'package:frontend/logic/cubits/user_cubit/user_state.dart';
import 'package:frontend/logic/services/razorpay.dart';
import 'package:frontend/presentation/screens/order/order_placed_screen.dart';
import 'package:frontend/presentation/screens/order/providers/order_detail_provider.dart';
import 'package:frontend/presentation/user/edit_profile_screen.dart';
import 'package:frontend/presentation/widgets/cart_list_view.dart';
import 'package:frontend/presentation/widgets/gap_widget.dart';
import 'package:frontend/presentation/widgets/link_button.dart';
import 'package:frontend/presentation/widgets/primary_button.dart';
import 'package:provider/provider.dart';

class OrderDetailScreen extends StatefulWidget {
  const OrderDetailScreen({super.key});
  static const routeName = "order_detail";
  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("New Order"),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            BlocBuilder<UserCubit, UserState>(
              builder: (context, state) {
                if (state is UserLoadingState) {
                  return const CircularProgressIndicator();
                }

                if (state is UserLoggedInState) {
                  UserModel user = state.userModel;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "User Details",
                        style: TextStyles.body2
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      const Gap(),
                      Text("${user.fullname}", style: TextStyles.heading3),
                      Text(
                        "Email: ${user.email}",
                        style: TextStyles.body2,
                      ),
                      Text(
                        "Phone: ${user.phoneNumber}",
                        style: TextStyles.body2,
                      ),
                      Text(
                        "Address: ${user.address}, ${user.city}, ${user.state}",
                        style: TextStyles.body2,
                      ),
                      LinkButton(
                          onPressed: () {
                            Navigator.pushNamed(
                                context, EditProfileScreen.routeName);
                          },
                          text: "Edit Profile"),
                    ],
                  );
                }

                if (state is UserErrorState) {
                  return Text(state.message);
                }

                return const SizedBox();
              },
            ),
            const Gap(size: 10),
            Text(
              "Items",
              style: TextStyles.body2.copyWith(fontWeight: FontWeight.bold),
            ),
            const Gap(),
            BlocBuilder<CartCubit, CartState>(
              builder: (context, state) {
                if (state is CartLoadingState && state.items.isEmpty) {
                  return const CircularProgressIndicator();
                }

                if (state is CartErrorState && state.items.isEmpty) {
                  return Text(state.message);
                }

                return CartListView(
                  items: state.items,
                  shrinkWrap: true,
                  noScroll: true,
                );
              },
            ),
            const Gap(size: 10),
            Text(
              "Payment",
              style: TextStyles.body2.copyWith(fontWeight: FontWeight.bold),
            ),
            const Gap(),
            Consumer<OrderDetailProvider>(builder: (context, provider, child) {
              return Column(
                children: [
                  RadioListTile(
                    value: "pay-on-delivery",
                    groupValue: provider.paymentMethod,
                    onChanged: provider.changePaymentMethod,
                    contentPadding: EdgeInsets.zero,
                    title: const Text("Pay on delivery"),
                  ),
                  RadioListTile(
                    value: "pay-now",
                    groupValue: provider.paymentMethod,
                    onChanged: provider.changePaymentMethod,
                    contentPadding: EdgeInsets.zero,
                    title: const Text("Pay Now"),
                  ),
                ],
              );
            }),
            const Gap(),
            PrimaryButton(
              onPressed: () async {
                OrderModel? newOrder =
                    await BlocProvider.of<OrderCubit>(context).createOrder(
                  items: BlocProvider.of<CartCubit>(context).state.items,
                  paymentMethod:
                      Provider.of<OrderDetailProvider>(context, listen: false)
                          .paymentMethod
                          .toString(),
                );
                if (newOrder == null) return;
                if (newOrder.status == "payment-pending") {
                  await RazorPayServices.checkOutOrder(newOrder,
                      onSuccess: (response) async {
                    newOrder.status = "order-placed";
                    bool success = await BlocProvider.of<OrderCubit>(context)
                        .updateOrder(newOrder,
                            paymentId: response.paymentId,
                            signature: response.signature);
                    if (!success) {
                      log("Can't Update the order");
                      return;
                    }
                    Navigator.popUntil(context, (route) => route.isFirst);
                    Navigator.pushNamed(context, OrderPlacedScreen.routeName);
                  }, onFailure: (response) {
                    log("Payment failed!");
                  });
                }

                if (newOrder.status == "order-placed") {
                  // ignore: use_build_context_synchronously
                  Navigator.popUntil(context, (route) => route.isFirst);
                  // ignore: use_build_context_synchronously
                  Navigator.pushNamed(context, OrderPlacedScreen.routeName);
                }
              },
              text: "Place Order",
            )
          ],
        ),
      ),
    );
  }
}
