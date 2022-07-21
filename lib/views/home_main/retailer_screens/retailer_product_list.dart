import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jiffy_fuels_consumer/const/screen_size.dart';
import 'package:jiffy_fuels_consumer/controllers/product_controller.dart';
import 'package:jiffy_fuels_consumer/models/retailer.dart';
import 'package:jiffy_fuels_consumer/widgets/app_bar.dart';
import 'package:jiffy_fuels_consumer/widgets/app_buttons.dart';
import 'package:jiffy_fuels_consumer/widgets/dialogs.dart';
import 'package:jiffy_fuels_consumer/widgets/loading_widget.dart';

import '../../../const/app_images.dart';

class RetailerProductList extends StatefulWidget {
  const RetailerProductList({Key? key, required this.retailer}) : super(key: key);
  final Retailer retailer;
  @override
  State<RetailerProductList> createState() => _RetailerProductListState();
}

class _RetailerProductListState extends State<RetailerProductList> {

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      //userController.retailerProfile();
      //retailerController.getRetailers();
      productController.getProducts(widget.retailer.email);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Spinner(
      child: SafeArea(
        child: Scaffold(
          appBar: appBarLogo(),
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: GetBuilder(
                init: ProductController(),
                builder: (_) => Column(
                  children: [
                    productController.products.isEmpty
                        ? Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            AppImages.fuelTank,
                            height: ScreenSize.height(context) * 0.12,
                            fit: BoxFit.fitHeight,
                          ),
                          const Text(
                            'No Products Found',
                            style: TextStyle(),
                          ),
                        ],
                      ),
                    )
                        : Expanded(
                      child: ListView.builder(
                        itemCount: productController.products.length,
                        shrinkWrap: true,
                        itemBuilder: (ctx, i) => GestureDetector(
                          onTap: () {
                            productController.assignProductData(
                              product: productController.products[i],
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CachedNetworkImage(
                                  imageUrl: productController
                                      .products[i].productImage,
                                  width: ScreenSize.width(context) * 0.24,
                                  height: ScreenSize.height(context) * 0.1,
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
                                        productController
                                            .products[i].productName,
                                        style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        productController
                                            .products[i].productDescription,
                                        maxLines: 2,
                                        style: const TextStyle(
                                          fontSize: 13,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    yesNoDialog(
                                      context,
                                      text:
                                      'Do you want to delete the product?',
                                      onTap: () {
                                        Get.back();
                                        // productController.deleteProduct(
                                        //   productName: productController
                                        //       .products[i].productName,
                                        //   productUrl: productController
                                        //       .products[i].productImage,
                                        //   featuredUrl: productController
                                        //       .products[i].featuredImage,
                                        // );
                                      },
                                    );
                                  },
                                  child: const CircleAvatar(
                                    backgroundColor: Colors.red,
                                    radius: 10,
                                    child: Center(
                                      child: Icon(
                                        Icons.close,
                                        size: 16,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        )
      ),
    );
  }

}
