import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jiffy_fuels_consumer/const/screen_size.dart';
import 'package:jiffy_fuels_consumer/controllers/retailer_controller.dart';
import 'package:jiffy_fuels_consumer/views/home_main/retailer_screens/retailer_product_list.dart';
import 'package:jiffy_fuels_consumer/widgets/loading_widget.dart';

import '../../../../../const/app_images.dart';

class RetailerList extends StatelessWidget {
  const RetailerList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: RetailerController(),
        builder: (_) => retailerController.retailer.isEmpty
            ? Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              AppImages.fuelTank,
              height: ScreenSize.height(context) * 0.12,
              fit: BoxFit.fitHeight,
            ),
            const Text(
              'There are no service providers in your area.',
              style: TextStyle(),
            ),
          ],
        )
            : Column(
          children: [
            //NUMBER OF PARTNERS
            Row(
              children: [
                Padding(
                    padding:const EdgeInsets.all(8.0),
                    child: Text('${retailerController.retailer.length} Partners')
                ),
              ],
            ),

            ListView.builder(
              itemCount: retailerController.retailer.length,
              shrinkWrap: true,
              itemBuilder: (ctx, i) => GestureDetector(
                onTap: () {
                  retailerController.assignRetailerData(
                    retailer: retailerController.retailer[i],
                  );
                  Get.to(
                        () => RetailerProductList(retailer: retailerController.retailer[i]),
                  );
                },
                child: Container(
                  height: ScreenSize.height(context) * 0.12,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                  child: Row(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [
                      CachedNetworkImage(
                        imageUrl: retailerController
                            .retailer[i].bannerImage,
                        width: ScreenSize.width(context) * 0.24,
                        height:
                        ScreenSize.height(context) * 0.1,
                      ),
                      const SizedBox(width: 5),
                      Expanded(
                        child: Column(
                          mainAxisAlignment:
                          MainAxisAlignment.center,
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            Text(
                              retailerController
                                  .retailer[i].name,
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              retailerController
                                  .retailer[i].description,
                              maxLines: 2,
                              style: const TextStyle(
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
    );
  }
}
