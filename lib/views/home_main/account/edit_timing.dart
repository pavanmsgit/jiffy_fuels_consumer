import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:jiffy_fuels_consumer/controllers/user_controller_old.dart';
import 'package:jiffy_fuels_consumer/widgets/loading_widget.dart';

import '../../../const/app_colors.dart';
import '../../../const/app_const.dart';
import '../../../controllers/auth_controller.dart';
import '../../../widgets/app_buttons.dart';

class EditTimingScreen extends StatefulWidget {
  const EditTimingScreen({Key? key}) : super(key: key);

  @override
  State<EditTimingScreen> createState() => _EditTimingScreenState();
}

class _EditTimingScreenState extends State<EditTimingScreen> {
  final AuthController ac = Get.find<AuthController>();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      //userController.retailerProfile();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Spinner(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Edit Timing'),
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: GetBuilder(
              init: UserControllerOld(),
              builder: (_) => Column(
                children: [
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
                          value: userController.everyday.value,
                          onToggle: (val) =>
                              userController.everyday.value = val,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Obx(
                    () => userController.everyday.value
                        ? OpenCloseTime(
                            onOpen: () => userController.selectOpenTime(
                              context,
                              index: -1,
                            ),
                            onClose: () => userController.selectCloseTime(
                              context,
                              index: -1,
                            ),
                            openTime: userController.openTime,
                            closeTime: userController.closeTime,
                          )
                        : Container(),
                  ),
                  Obx(
                    () => userController.everyday.value
                        ? Container()
                        : ListView.builder(
                            itemCount: AppConst.weekDays.length,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (ctx, i) => Obx(
                              () => Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(vertical: 5),
                                    child: Row(
                                      children: [
                                        Obx(
                                          () => Checkbox(
                                            activeColor: AppColor.primaryColor,
                                            value: userController
                                                .selectedDays[i].value,
                                            onChanged: (v) => userController
                                                    .selectedDays[i].value =
                                                !userController
                                                    .selectedDays[i].value,
                                          ),
                                        ),
                                        Text(
                                          AppConst.weekDays[i],
                                        ),
                                      ],
                                    ),
                                  ),
                                  if (userController.selectedDays[i].value)
                                    OpenCloseTime(
                                      onOpen: () =>
                                          userController.selectOpenTime(
                                        context,
                                        index: i,
                                      ),
                                      onClose: () =>
                                          userController.selectCloseTime(
                                        context,
                                        index: i,
                                      ),
                                      openTime: userController
                                              .selectedTimes[i].openTime ??
                                          '00:00',
                                      closeTime: userController
                                              .selectedTimes[i].closeTime ??
                                          '00:00',
                                    ),
                                ],
                              ),
                            ),
                          ),
                  ),
                  Spacer(),
                  JiffyButton(
                    buttonText: 'SAVE',
                    onTap: userController.updateTime,
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
