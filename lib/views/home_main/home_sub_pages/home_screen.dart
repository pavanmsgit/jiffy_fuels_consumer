import 'package:flutter/material.dart';
import 'package:jiffy_fuels_consumer/const/app_colors.dart';
import 'package:jiffy_fuels_consumer/const/screen_size.dart';
import 'package:jiffy_fuels_consumer/views/home_main/retailer_screens/retailer_product_list.dart';
import 'package:jiffy_fuels_consumer/widgets/address_bar.dart';
import 'package:jiffy_fuels_consumer/widgets/loading_widget.dart';
import 'package:jiffy_fuels_consumer/widgets/posters.dart';
import 'package:jiffy_fuels_consumer/views/home_main/retailer_screens/retailer_list.dart';

import '../../../widgets/app_bar.dart';

//todo - implement auto size text

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    // return Spinner(child: SafeArea(
    //   child: Scaffold(
    //     appBar: appBarLogo(),
    //     body: SingleChildScrollView(
    //       child: Column(
    //         children: [
    //           AddressBar(),
    //           PosterCarouselWidget(),
    //           RetailerList(),
    //         ],
    //       ),
    //     ),
    //   ),
    // ));

    return const CustomScrollView(
      physics: BouncingScrollPhysics(),
      slivers: [
        SliverAppBar(
          backgroundColor: AppColor.white,
          pinned: true,
          flexibleSpace: AppBarLogo(),
        ),
        SliverToBoxAdapter(
          child: AddressBar(),
        ),
        SliverToBoxAdapter(
          child: PosterCarouselWidget(),
        ),

        SliverToBoxAdapter(
          child: RetailerList()
        )
      ],
    );
  }
}
