import 'dart:convert';

List<Products> productsFromJson(str) => List<Products>.from((str).map((x) => Products.fromJson(x.data())));

String productsToJson(List<Products> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Products {
  Products({
    required this.productImage,
    required this.productOrder,
    required this.retailerEmail,
    required this.productDescription,
    required this.productName,
    required this.featuredImage,
    required this.isFeatured,
    required this.status,
    required this.discount,
    required this.discountType,
    required this.pricePerLitre,
  });

  String productImage;
  String productOrder;
  String retailerEmail;
  String productDescription;
  String productName;
  String featuredImage;
  String pricePerLitre;
  String discount;
  String discountType;
  bool isFeatured;
  String status;

  factory Products.fromJson(Map<String, dynamic> json) => Products(
        productImage: json["product_image"],
        productOrder: json["product_order"],
        retailerEmail: json["retailer_email"],
        productDescription: json["product_description"],
        productName: json["product_name"],
        featuredImage: json["featured_image"],
        isFeatured: json["is_featured"],
        status: json["status"],
        pricePerLitre: json['price_per_litre'],
        discount: json['discount'],
        discountType: json['discount_type'],
      );

  Map<String, dynamic> toJson() => {
        "product_image": productImage,
        "product_order": productOrder,
        "retailer_email": retailerEmail,
        "product_description": productDescription,
        "product_name": productName,
        "featured_image": featuredImage,
        "is_featured": isFeatured,
        "status": status,
      };
}
