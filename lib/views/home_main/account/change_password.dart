import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jiffy_fuels_consumer/widgets/app_buttons.dart';
import 'package:jiffy_fuels_consumer/widgets/loading_widget.dart';
import '../../../controllers/user_controller_old.dart';
import '../../../widgets/text_field.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Spinner(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Change Password'),
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: GetBuilder(
              init: UserControllerOld(),
              builder: (_) => Form(
                key: userController.changePasswordFormKey,
                child: Column(
                  children: [
                    Obx(
                      () => TitleTextField(
                        title: 'Current Password',
                        controller: userController.currentPassword,
                        obscure: userController.currentPasswordObscure.value,
                        iconData: userController.currentPasswordObscure.value
                            ? Icons.visibility
                            : Icons.visibility_off,
                        iconTap: () =>
                            userController.currentPasswordObscure.value =
                                !userController.currentPasswordObscure.value,
                        validator: (val) => val!.length >= 6
                            ? null
                            : 'Should have minumum 6 characters',
                      ),
                    ),
                    Obx(
                      () => TitleTextField(
                        title: 'Password',
                        controller: userController.newPassword,
                        obscure: userController.passwordObscure.value,
                        iconData: userController.passwordObscure.value
                            ? Icons.visibility
                            : Icons.visibility_off,
                        iconTap: () => userController.passwordObscure.value =
                            !userController.passwordObscure.value,
                        validator: (val) => val!.length >= 6
                            ? null
                            : 'Should have minumum 6 characters',
                      ),
                    ),
                    Obx(
                      () => TitleTextField(
                        title: 'Confirm Password',
                        controller: userController.confirmNewPassword,
                        obscure: userController.confirmPasswordObscure.value,
                        iconData: userController.confirmPasswordObscure.value
                            ? Icons.visibility
                            : Icons.visibility_off,
                        iconTap: () =>
                            userController.confirmPasswordObscure.value =
                                !userController.confirmPasswordObscure.value,
                        validator: (val) => val!.length >= 6
                            ? null
                            : 'Should have minumum 6 characters',
                      ),
                    ),
                    Spacer(),
                    JiffyButton(
                      buttonText: 'SAVE',
                      onTap: userController.changePassword,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
