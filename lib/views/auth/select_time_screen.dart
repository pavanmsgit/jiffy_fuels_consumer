import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:jiffy_fuels_consumer/const/app_const.dart';
import 'package:jiffy_fuels_consumer/controllers/auth_controller.dart';
import 'package:jiffy_fuels_consumer/models/shop_time.dart';
import 'package:jiffy_fuels_consumer/views/auth/login_screen.dart';
import 'package:jiffy_fuels_consumer/widgets/loading_widget.dart';
import '../../const/app_colors.dart';
import '../../widgets/app_buttons.dart';

class SelectTimeScreen extends StatefulWidget {
  const SelectTimeScreen({Key? key}) : super(key: key);

  @override
  State<SelectTimeScreen> createState() => _SelectTimeScreenState();
}

class _SelectTimeScreenState extends State<SelectTimeScreen> {
  final AuthController ac = Get.find<AuthController>();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      authController.selectedTimes.clear();
      List.generate(7, (index) {
        authController.selectedTimes.add(ShopTimings());
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Spinner(
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: GetBuilder(
              init: AuthController(),
              builder: (_) => Column(
                children: [
                  Expanded(
                    child: ListView(
                      children: [
                        AppLogo(),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'EveryDay',
                              style: TextStyle(
                                color: AppColor.primaryColor,
                              ),
                            ),
                            Obx(
                              () => FlutterSwitch(
                                height: 20,
                                toggleSize: 15,
                                width: 45,
                                activeColor: AppColor.primaryColor,
                                value: ac.everyday.value,
                                onToggle: (val) => ac.everyday.value = val,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Obx(
                          () => ac.everyday.value
                              ? OpenCloseTime(
                                  onOpen: () => authController.selectOpenTime(
                                    context,
                                    index: -1,
                                  ),
                                  onClose: () => authController.selectCloseTime(
                                    context,
                                    index: -1,
                                  ),
                                  openTime: authController.openTime,
                                  closeTime: authController.closeTime,
                                )
                              : Container(),
                        ),
                        Obx(
                          () => ac.everyday.value
                              ? Container()
                              : ListView.builder(
                                  itemCount: AppConst.weekDays.length,
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemBuilder: (ctx, i) => Obx(
                                    () => Column(
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsets.symmetric(vertical: 5),
                                          child: Row(
                                            children: [
                                              Obx(
                                                () => Checkbox(
                                                  activeColor:
                                                      AppColor.primaryColor,
                                                  value:
                                                      ac.selectedDays[i].value,
                                                  onChanged: (v) => ac
                                                          .selectedDays[i]
                                                          .value =
                                                      !ac.selectedDays[i].value,
                                                ),
                                              ),
                                              Text(
                                                AppConst.weekDays[i],
                                              ),
                                            ],
                                          ),
                                        ),
                                        if (ac.selectedDays[i].value)
                                          OpenCloseTime(
                                            onOpen: () =>
                                                authController.selectOpenTime(
                                              context,
                                              index: i,
                                            ),
                                            onClose: () =>
                                                authController.selectCloseTime(
                                              context,
                                              index: i,
                                            ),
                                            openTime: authController
                                                    .selectedTimes[i]
                                                    .openTime ??
                                                '00:00',
                                            closeTime: authController
                                                    .selectedTimes[i]
                                                    .closeTime ??
                                                '00:00',
                                          ),
                                      ],
                                    ),
                                  ),
                                ),
                        ),
                      ],
                    ),
                  ),
                  JiffyButton(
                    buttonText: 'REGISTER',
                    onTap: authController.updateTime,
                  ),
                  TextButton(
                    onPressed: () => Get.to(
                      () => LoginScreen(),
                      transition: Transition.rightToLeft,
                      duration: .5.seconds,
                    ),
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Do have an account? ",
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.black,
                            ),
                          ),
                          TextSpan(
                            text: "LOGIN",
                            style: TextStyle(
                              fontSize: 13,
                              color: AppColor.primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
