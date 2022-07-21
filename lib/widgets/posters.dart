import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fade_shimmer/fade_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:jiffy_fuels_consumer/const/app_colors.dart';
import 'package:jiffy_fuels_consumer/const/screen_size.dart';
import 'package:jiffy_fuels_consumer/controllers/home_controller.dart';
import 'package:jiffy_fuels_consumer/widgets/shimmer_widgets.dart';

class PosterCarouselWidget extends StatelessWidget {
  const PosterCarouselWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  FutureBuilder(
      future: homeController.getPosterList(),
      builder: (ctx, snapshot){
        if (!snapshot.hasData){
          return const ShimmerForPoster();
        }else {
          var list = snapshot.data;
          return posterObjects(list!,context);
        }
      },
    );
  }
}




posterObjects(list , context) {
  List<dynamic> posterList = list;

  final List<Widget> imageSliders = posterList
      .map((item) => ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(5.0)),
      child: Stack(
        children: <Widget>[
          Image.network(
            item,
            width: ScreenSize.width(context),
            fit: BoxFit.fill,
          ),
        ],
      )))
      .toList();

  return Container(
    padding: const EdgeInsets.only(top: 20),
    child: CarouselSlider(
      options: CarouselOptions(
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 3),
        autoPlayAnimationDuration: const Duration(milliseconds: 1000),
        aspectRatio: 2.0,
        enlargeCenterPage: true,
        disableCenter: true,
        scrollPhysics: const BouncingScrollPhysics(),
        enlargeStrategy: CenterPageEnlargeStrategy.scale,
      ),
      items: imageSliders,
    ),
  );
}




