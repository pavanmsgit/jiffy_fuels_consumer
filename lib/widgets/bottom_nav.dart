import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jiffy_fuels_consumer/controllers/home_controller.dart';

import '../const/app_colors.dart';
import '../const/app_images.dart';


class AppBottomNav extends StatefulWidget {
  const AppBottomNav({Key? key}) : super(key: key);

  @override
  State<AppBottomNav> createState() => _AppBottomNavState();
}

class _AppBottomNavState extends State<AppBottomNav> {
  final HomeController hc = Get.find<HomeController>();

  //ICON LIST FOR BOTTOM NAVIGATION BAR
  final iconList = <IconData>[
    Icons.home,
    Icons.search_rounded,
    Icons.receipt_long_rounded,
    Icons.account_circle_rounded,
  ];

  @override
  Widget build(BuildContext context) {
    return AnimatedBottomNavigationBar(
      icons: iconList,
      backgroundColor: Colors.white,
      activeColor: AppColor.primaryColor,
      notchMargin: 15,
      inactiveColor: AppColor.grey,
      activeIndex: hc.selectedTab.value,
      gapLocation: GapLocation.none,
      notchSmoothness: NotchSmoothness.defaultEdge,
      leftCornerRadius: 0,
      rightCornerRadius: 0,
      onTap: (index) {
        setState(() {
          hc.selectedTab.value = index;
        });
      },
    );
  }
}





//return BottomNavigationBar(
//       type: BottomNavigationBarType.fixed,
//       onTap: (index) => hc.selectedTab.value = index,
//       ///fixedColor: AppColor.primaryColor,
//       selectedItemColor: AppColor.primaryColor,
//       unselectedItemColor: AppColor.grey,
//       backgroundColor: AppColor.white,
//       items: const [
//         BottomNavigationBarItem(
//           icon: Icon(Icons.home_main),
//           label: '',
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(Icons.search_rounded),
//           label: '',
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(Icons.receipt_long_rounded),
//           label: '',
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(Icons.account_circle_rounded),
//           label: '',
//         ),
//       ],
//     );