import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/core/ui.dart';
import 'package:frontend/data/models/user/user_model.dart';
import 'package:frontend/logic/cubits/user_cubit/user_cubit.dart';
import 'package:frontend/logic/cubits/user_cubit/user_state.dart';
import 'package:frontend/presentation/screens/order/my_order_screen.dart';
import 'package:frontend/presentation/user/edit_profile_screen.dart';
import 'package:frontend/presentation/widgets/link_button.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(builder: (context, state) {
      if (state is UserLoadingState) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
      if (state is UserErrorState) {
        return Center(
          child: Text(state.message),
        );
      }
      if (state is UserLoggedInState) {
        return userProfile(state.userModel);
      }
      return const Center(
        child: Text("an error occured."),
      );
    });
  }

  Widget userProfile(UserModel userModel) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${userModel.fullname}",
              style: TextStyles.heading3,
            ),
            Text(
              "${userModel.email}",
              style: TextStyles.body2,
            ),
            LinkButton(
              text: "Edit Profile",
              onPressed: () {
                Navigator.pushNamed(context, EditProfileScreen.routeName);
              },
            ),
          ],
        ),
        const Divider(),
        ListTile(
          onTap: () {
            Navigator.pushNamed(context, MyOrderScreen.routeName);
          },
          contentPadding: EdgeInsets.zero,
          leading: const Icon(CupertinoIcons.cube_box_fill),
          title: Text(
            "My Orders",
            style: TextStyles.body1,
          ),
        ),
        ListTile(
          onTap: () {
            BlocProvider.of<UserCubit>(context).signOut();
          },
          contentPadding: EdgeInsets.zero,
          leading: const Icon(
            Icons.exit_to_app,
            color: Colors.red,
          ),
          title: Text(
            "Sign Out",
            style: TextStyles.body1.copyWith(color: Colors.red),
          ),
        ),
      ],
    );
  }
}
