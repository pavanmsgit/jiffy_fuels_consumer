import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../const/screen_size.dart';

class SpinWidget extends StatelessWidget {
  const SpinWidget({Key? key, required this.text}) : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Material(
      elevation: 5,
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        width: ScreenSize.width(context) * .8,
        height: ScreenSize.height(context) * .1,
        padding:
            EdgeInsets.symmetric(horizontal: ScreenSize.width(context) * .1),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(
              strokeWidth: 2,
              // valueColor: AlwaysStoppedAnimation(blue),
            ),
            Expanded(
              child: Center(
                child: Text(
                  text,
                  style: const TextStyle(color: Colors.black),
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }
}

// ignore: must_be_immutable
class Spinner extends StatelessWidget {
  Spinner({Key? key, required this.child}) : super(key: key);
  final Widget child;

  SpinController controller = Get.put(SpinController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ModalProgressHUD(
        inAsyncCall: controller.spin.value,
        color: Colors.black87,
        progressIndicator: SpinWidget(
          text: controller.text.value,
        ),
        child: child,
      ),
    );
  }
}

class SpinController extends GetxController {
  var spin = false.obs;
  var text = 'Please wait...'.obs;

  show(msg) {
    spin.value = true;
    if (msg != null) {
      text.value = msg;
    }
  }

  hide() {
    spin.value = false;
    text.value = 'Please wait...';
  }
}

showSpinner({String? message}) {
  SpinController controller = Get.find<SpinController>();
  controller.show(message);
}

hideSpinner() {
  SpinController controller = Get.find<SpinController>();
  controller.hide();
}
