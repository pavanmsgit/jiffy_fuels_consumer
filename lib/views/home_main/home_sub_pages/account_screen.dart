import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:jiffy_fuels_consumer/const/app_colors.dart';
import 'package:jiffy_fuels_consumer/const/app_images.dart';
import 'package:jiffy_fuels_consumer/const/screen_size.dart';
import 'package:jiffy_fuels_consumer/controllers/user_controller_old.dart';
import 'package:jiffy_fuels_consumer/views/auth/login_screen.dart';
import 'package:jiffy_fuels_consumer/views/home_main/account/change_password.dart';
import 'package:jiffy_fuels_consumer/views/home_main/account/edit_timing.dart';
import 'package:jiffy_fuels_consumer/views/home_main/account/history_screen.dart';
import 'package:jiffy_fuels_consumer/views/home_main/account/profile_screen.dart';
import 'package:jiffy_fuels_consumer/widgets/app_bar.dart';
import 'package:jiffy_fuels_consumer/widgets/dialogs.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      body: Column(
        children: [
          const AppBarLogo(),
          Container(
            height: ScreenSize.height(context) * 0.1,
            margin: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 10,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.5),
                  blurRadius: 4,
                ),
              ],
            ),
            child:
                GetBuilder(
                  init: UserControllerOld(),
                  builder: (_) => ListTile(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.0),
                          topRight: Radius.circular(20.0)),
                    ),
                    //tileColor: AppColor.primaryColor,
                    horizontalTitleGap: 20,

                    leading: Container(
                      color: AppColor.white,
                      width: ScreenSize.width(context) * 0.15,
                      height: ScreenSize.height(context) * 0.15,
                      child: ClipRRect(
                        borderRadius:
                        BorderRadius.circular(30),
                        child: Image.asset(
                          AppImages.appLogo,
                          //width: size.width * 0.95,
                          height: 60,
                          fit: BoxFit.cover,
                          //cancelToken: cancellationToken,
                        ),
                      ),
                    ),

                    title: Row(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Padding(
                          padding: EdgeInsets.only(
                              top: 0.0, bottom: 0.0),
                          child: Text(
                            'Name',
                            style: TextStyle(
                                fontSize: 18.0,
                                fontWeight:
                                FontWeight.w600,
                                color: Colors.black),
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ],
                    ),

                    subtitle: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Padding(
                            padding: EdgeInsets.only(
                                left: 0.0,
                                right: 0.0,
                                top: 5),
                            child: Text(
                              'Phone  Email',
                              style: TextStyle(
                                  fontSize: 11,
                                  fontWeight:
                                  FontWeight.w400,
                                  color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                    ),

                    trailing: IconButton(icon: const Icon(Icons.edit),onPressed: (){},),
                  ),
                ),
          ),

          AccountTile(
            iconData: Icons.email,
            title: 'MANAGE ADDRESS',
            onTap: () {
              Get.to(
                () => const HistoryScreen(),
              );
            },
          ),

          AccountTile(
            iconData: Icons.favorite,
            title: 'FAVORITES',
            onTap: () {
              Get.to(
                () => const ProfileScreen(),
              );
            },
          ),

          AccountTile(
            iconData: Icons.credit_card_rounded,
            title: 'PAYMENT',
            onTap: () {
              Get.to(
                () => const EditTimingScreen(),
              );
            },
          ),
          AccountTile(
            iconData: Icons.history,
            title: 'MY ORDERS',
            onTap: () {},
          ),

          AccountTile(
            iconData: Icons.language_outlined,
            title: 'Change Language',
            onTap: () {

            },
          ),

          AccountTile(
            iconData: Icons.lock,
            title: 'Change Password',
            onTap: () => Get.to(
              () => const ChangePasswordScreen(),
            ),
          ),

          AccountTile(
            iconData: Icons.logout,
            title: 'Logout',
            onTap: () {
              yesNoDialog(
                context,
                text: 'Do you want to logout?',
                onTap: () {
                  Get.back();
                  GetStorage().erase();
                  Get.offAll(() => const LoginScreen());
                },
              );
            },
          ),

          // AccountTile(
          //   iconData: Icons.delete,
          //   title: 'Delete Account',
          //   onTap: () {
          //     yesNoDialog(
          //       context,
          //       text: 'Do you want to delete the account?',
          //       onTap: userController.deleteUserAccount,
          //     );
          //   },
          // ),
        ],
      ),
    );
  }
}

class AccountTile extends StatelessWidget {
  const AccountTile({
    Key? key,
    required this.iconData,
    required this.onTap,
    required this.title,
  }) : super(key: key);

  final IconData iconData;
  final String title;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: ScreenSize.height(context) * 0.05,
        margin: const EdgeInsets.symmetric(
          horizontal: 7,
          vertical: 6,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.0),
              blurRadius: 4,
            )
          ],
        ),
        child: Row(
          children: [
            const SizedBox(width: 5),
            Icon(
              iconData,
              color: AppColor.black,
              size: 18,
            ),
            const SizedBox(width: 15),
            Text(
              title,
              style: const TextStyle(
                fontSize: 13,
                color: AppColor.black,
              ),
            ),
            const Spacer(),
            const Icon(
              Icons.arrow_forward_ios,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }
}
