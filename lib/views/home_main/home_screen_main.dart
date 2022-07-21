import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jiffy_fuels_consumer/const/app_colors.dart';
import 'package:jiffy_fuels_consumer/const/screen_size.dart';
import 'package:jiffy_fuels_consumer/controllers/home_controller.dart';
import 'package:jiffy_fuels_consumer/controllers/product_controller.dart';
import 'package:jiffy_fuels_consumer/controllers/retailer_controller.dart';
import 'package:jiffy_fuels_consumer/controllers/user_controller_old.dart';
import 'package:jiffy_fuels_consumer/widgets/address_bar.dart';
import 'package:jiffy_fuels_consumer/widgets/bottom_nav.dart';
import 'package:jiffy_fuels_consumer/widgets/loading_widget.dart';

import '../../../widgets/app_bar.dart';

class HomeScreenMain extends StatefulWidget {
  const HomeScreenMain({Key? key}) : super(key: key);

  @override
  State<HomeScreenMain> createState() => _HomeScreenMainState();
}

class _HomeScreenMainState extends State<HomeScreenMain> {
  final HomeController hc = Get.put(HomeController());

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      //userController.retailerProfile();
      retailerController.getRetailers();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Spinner(
      child: Scaffold(
        bottomNavigationBar: const AppBottomNav(),
        body: Obx(
              () => SafeArea(
            child: hc.screens.elementAt(hc.selectedTab.value),
          ),
        ),
      ),
    );
  }
}