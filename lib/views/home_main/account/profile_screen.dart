import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jiffy_fuels_consumer/const/app_const.dart';
import 'package:jiffy_fuels_consumer/controllers/auth_controller.dart';
import 'package:jiffy_fuels_consumer/widgets/loading_widget.dart';
// ignore: import_of_legacy_library_into_null_safe
//import 'package:place_picker/widgets/place_picker.dart';
import '../../../const/screen_size.dart';
import '../../../controllers/user_controller_old.dart';
import '../../../widgets/app_buttons.dart';
import '../../../widgets/app_dropdown.dart';
import '../../../widgets/dialogs.dart';
import '../../../widgets/text_field.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      userController.image = null;
      userController.shopBanner = null;
      setState(() {});
      authController.oilCompanies();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Spinner(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text('Edit Partner'),
        ),
        body: SafeArea(
          child: GetBuilder(
            init: UserControllerOld(),
            builder: (_) => Padding(
              padding: EdgeInsets.all(20),
              child: Form(
                key: userController.profileFormKey,
                child: Column(
                  children: [
                    Expanded(
                      child: ListView(
                        children: [
                          TitleTextField(
                            title: 'Name',
                            controller: userController.name,
                            validator: (val) =>
                                val!.isEmpty ? 'Enter your name' : null,
                          ),
                          TitleTextField(
                            title: 'Email Address',
                            enabled: false,
                            controller: userController.email,
                            keyboardType: TextInputType.emailAddress,
                            validator: (val) => val!.isEmail
                                ? null
                                : 'Enter valid email address',
                            // onChanged: (val) =>
                            //     userController.isEmailAvailable(val: val),
                          ),
                          // if (userController.email.text.isEmail)
                          //   Obx(
                          //     () => Text(
                          //       userController.emailAvailable.value
                          //           ? 'Email Available'
                          //           : 'Email already exists',
                          //       textAlign: TextAlign.end,
                          //       style: TextStyle(
                          //         color: userController.emailAvailable.value
                          //             ? Colors.green
                          //             : Colors.red,
                          //       ),
                          //     ),
                          //   ),
                          GestureDetector(
                            onTap: () => selectOilCompany(context),
                            child: TitleTextField(
                              title: 'Oil Marketing Company',
                              enabled: false,
                              controller: userController.oilCompany,
                            ),
                          ),
                          TitleTextField(
                            title: 'Phone Number',
                            controller: userController.phone,
                            keyboardType: TextInputType.number,
                            validator: (val) =>
                                val!.length == 10 ? null : 'Enter valid number',
                          ),
                          Obx(
                            () => TitleTextField(
                              title: 'Password',
                              controller: userController.password,
                              obscure: userController.passwordObscure.value,
                              iconData: userController.passwordObscure.value
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              iconTap: () =>
                                  userController.passwordObscure.value =
                                      !userController.passwordObscure.value,
                              validator: (val) => val!.length >= 6
                                  ? null
                                  : 'Should have minumum 6 characters',
                            ),
                          ),
                          Obx(
                            () => TitleTextField(
                              title: 'Confirm Password',
                              obscure:
                                  userController.confirmPasswordObscure.value,
                              controller: userController.confirmPassword,
                              iconData:
                                  userController.confirmPasswordObscure.value
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                              iconTap: () => userController
                                      .confirmPasswordObscure.value =
                                  !userController.confirmPasswordObscure.value,
                              validator: (val) => val!.length >= 6
                                  ? null
                                  : 'Should have minumum 6 characters',
                            ),
                          ),
                          // GestureDetector(
                          //   onTap: () {},
                          //   child: TitleTextField(
                          //     title: 'Status',
                          //     iconData: Icons.arrow_drop_down_sharp,
                          //     enabled: false,
                          //   ),
                          // ),
                          Text(
                            'Status',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 5),
                          Obx(
                            () => AppDropdown(
                              text: userController.status.value,
                              items: [
                                'Active',
                                'OnBoarding',
                                'Banned',
                              ],
                              onChanged: (val) =>
                                  userController.status.value = '$val',
                            ),
                          ),
                          SelectImageButton(
                            title: 'Image Upload',
                            image: userController.image,
                            onTap: userController.selectImage,
                            imageUrl: userController.imageUrl,
                          ),
                          SelectImageButton(
                            title: 'Shop Banner Image',
                            image: userController.shopBanner,
                            onTap: userController.selectShopBanner,
                            imageUrl: userController.bannerUrl,
                          ),
                          TitleTextField(
                            title: 'Min Amount',
                            keyboardType: TextInputType.number,
                            controller: userController.minAmount,
                            validator: (val) =>
                                val!.length > 1 ? null : 'Add Min Amount',
                          ),
                          TitleTextField(
                            title: 'Offer in Percentage',
                            hint: '%',
                            controller: userController.offerPercentage,
                            keyboardType: TextInputType.number,
                            validator: (val) =>
                                val!.isNotEmpty ? null : 'Add offer percentage',
                          ),
                          TitleTextField(
                            title: 'Maximum Delivery Time',
                            controller: userController.maxDelTime,
                            hint: 'Min',
                            keyboardType: TextInputType.number,
                            validator: (val) =>
                                val!.isEmpty ? 'Add Delivery Time' : null,
                          ),
                          TitleTextField(
                            title: 'Description',
                            controller: userController.description,
                            customHeight: ScreenSize.height(context) * 0.08,
                            validator: (val) =>
                                val!.isEmpty ? 'Add Description' : null,
                          ),

                          //todo
                          // GestureDetector(
                          //   onTap: () => Get.to(
                          //     () => //PlacePicker(AppConst.mapApiKey),
                          //   )!
                          //       .then((location) {
                          //     // print(location);
                          //     if (location != null) {
                          //       userController.lat = location[0];
                          //       userController.lon = location[1];
                          //     }
                          //   }),
                          //   child: TitleTextField(
                          //     title: 'Address',
                          //     controller: userController.address,
                          //     iconData: Icons.location_on,
                          //     enabled: false,
                          //     // validator: (val) =>
                          //     //     val!.isEmpty ? 'Add Address' : null,
                          //   ),
                          // ),
                          TitleTextField(
                            title: 'Landmark',
                            controller: userController.landmark,
                            validator: (val) =>
                                val!.isEmpty ? 'Add Landmark' : null,
                          ),
                        ],
                      ),
                    ),
                    JiffyButton(
                      buttonText: 'SAVE',
                      onTap: userController.updateProfile,
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
