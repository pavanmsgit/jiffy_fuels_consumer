import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jiffy_fuels_consumer/models/products.dart';
import 'package:jiffy_fuels_consumer/services/product_service.dart';
import 'package:jiffy_fuels_consumer/widgets/loading_widget.dart';
import '../views/home_main/home_screen_main.dart';
import '../views/home_main/home_sub_pages/home_screen.dart';


final ProductController productController = Get.find<ProductController>();

class ProductController extends GetxController {

  RxString isFeatured = 'no'.obs, productStatus = ''.obs, discountType = ''.obs;

  TextEditingController productName = TextEditingController(),
      description = TextEditingController(),
      productOrder = TextEditingController(),
      pricePerLitre = TextEditingController(),
      discount = TextEditingController();

  List<Products> products = [];

  GlobalKey<FormState> productFormKey = GlobalKey<FormState>(),
      priceFormKey = GlobalKey<FormState>();

  File? image, featuredImage;
  String productUrl = '', featuredUrl = '';

  ProductService productService = ProductService();

  getProducts(email) async {
    products = await productService.allProducts(email);
    update();
  }

  assignProductData({required Products product}) {
    productName.text = product.productName;
    description.text = product.productDescription;
    productOrder.text = product.productOrder;
    pricePerLitre.text = product.pricePerLitre;
    productStatus.value = product.status;
    isFeatured.value = product.isFeatured ? 'yes' : 'no';
    productUrl = product.productImage;
    featuredUrl = product.featuredImage;
    discount.text = product.discount;
    discountType.value = product.discountType;
    image = null;
    featuredImage = null;
    update();
  }

  resetProductData() {
    productName.text = '';
    description.text = '';
    productOrder.text = '';
    pricePerLitre.text = '';
    productStatus.value = '';
    isFeatured.value = 'yes';
    productUrl = '';
    featuredUrl = '';
    discount.text = '';
    discountType.value = '';
    image = null;
    featuredImage = null;

    update();
  }

  selectImage() async {
    var img = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (img != null) {
      image = File(img.path);
      update();
    }
  }

  selectFeaturedImage() async {
    var img = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (img != null) {
      featuredImage = File(img.path);
      update();
    }
  }

}
