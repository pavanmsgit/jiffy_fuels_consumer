import 'package:fade_shimmer/fade_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../const/app_colors.dart';
import '../const/screen_size.dart';

class ShimmerForAddressBar extends StatelessWidget {
  const ShimmerForAddressBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Shimmer.fromColors(
          baseColor: AppColor.greyShimmer,
          highlightColor: AppColor.white,
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
            margin: const EdgeInsets.only(top: 20),
            //padding: const EdgeInsets.only(left: 20,right: 20,top: 20),
            height: ScreenSize.height(context)* 0.09,
            width: ScreenSize.width(context)* 0.80,
          ),
        ),
      ],
    );
  }
}

class ShimmerForPoster extends StatelessWidget {
  const ShimmerForPoster({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Shimmer.fromColors(
          baseColor: AppColor.greyShimmer,
          highlightColor: AppColor.white,
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
            margin: const EdgeInsets.only(top: 10),
            //padding: const EdgeInsets.only(left: 20,right: 20,top: 20),
            height: ScreenSize.height(context)* 0.2,
            width: ScreenSize.width(context)* 0.9,
          ),
        ),
      ],
    );
  }
}





