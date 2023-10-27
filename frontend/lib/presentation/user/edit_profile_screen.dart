import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/core/ui.dart';
import 'package:frontend/data/models/user/user_model.dart';
import 'package:frontend/logic/cubits/user_cubit/user_cubit.dart';
import 'package:frontend/logic/cubits/user_cubit/user_state.dart';
import 'package:frontend/presentation/widgets/gap_widget.dart';
import 'package:frontend/presentation/widgets/primary_button.dart';
import 'package:frontend/presentation/widgets/primary_textfield.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});
  static const String routeName = "edit_profile";
  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit your profile"),
      ),
      body: SafeArea(
        child: BlocBuilder<UserCubit, UserState>(builder: (context, state) {
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
            return editProfile(state.userModel);
          }
          return const Center(
            child: Text("an error occured."),
          );
        }),
      ),
    );
  }

  Widget editProfile(UserModel userModel) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(
          "Personal Details",
          style: TextStyles.body2.copyWith(fontWeight: FontWeight.bold),
        ),
        const Gap(
          size: -10,
        ),
        PrimaryTextField(
          labelText: "Full Name",
          onChanged: (value) {
            userModel.fullname = value;
          },
          initialValue: userModel.fullname,
        ),
        const Gap(),
        PrimaryTextField(
          onChanged: (value) {
            userModel.phoneNumber = value;
          },
          labelText: "Phone Number",
          initialValue: userModel.phoneNumber,
        ),
        const Gap(
          size: 20,
        ),
        Text(
          "Address",
          style: TextStyles.body2.copyWith(fontWeight: FontWeight.bold),
        ),
        const Gap(
          size: -10,
        ),
        PrimaryTextField(
          labelText: "Address",
          initialValue: userModel.address,
          onChanged: (value) {
            userModel.address = value;
          },
        ),
        const Gap(),
        PrimaryTextField(
          labelText: "City",
          onChanged: (value) {
            userModel.city = value;
          },
          initialValue: userModel.city,
        ),
        const Gap(),
        PrimaryTextField(
          labelText: "State",
          onChanged: (value) {
            userModel.state = value;
          },
          initialValue: userModel.state,
        ),
        const Gap(),
        PrimaryButton(
          text: "Save",
          onPressed: () async {
            bool success =
                await BlocProvider.of<UserCubit>(context).updateUser(userModel);
            if (success) {
              Navigator.pop(context);
            }
          },
        )
      ],
    );
  }
}
