///NEW FILE
///
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jiffy_fuels_consumer/models/shop_time.dart';

Retailer profileFromJson(str) => Retailer.fromJson((str));

String profileToJson(Retailer data) => json.encode(data.toJson());

List<Retailer> retailersFromJson(str) => List<Retailer>.from((str).map((x) => Retailer.fromJson(x.data())));

String retailersToJson(List<Retailer> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Retailer {
  Retailer({
    required this.offerPercent,
    required this.address,
    required this.minAmount,
    required this.createdAt,
    required this.lon,
    required this.password,
    required this.phone,
    required this.name,
    required this.maxDelTime,
    required this.oilMarketing,
    required this.landmark,
    required this.lat,
    required this.email,
    required this.status,
    required this.description,
    required this.bannerImage,
    required this.image,
    required this.everyDay,
    required this.closeTime,
    required this.openTime,
    required this.timings,
  });

  String offerPercent;
  String address;
  String minAmount;
  Timestamp createdAt;
  double lon;
  String password;
  String phone;
  String name;
  String maxDelTime;
  List<String> oilMarketing;
  String landmark;
  double lat;
  String email;
  String status;
  String description;
  String image;
  String bannerImage;
  bool everyDay;
  String openTime;
  String closeTime;
  List<ShopTimings> timings;

  factory Retailer.fromJson(Map<String, dynamic> json) => Retailer(
      offerPercent: json["offer_percent"],
      address: json["address"],
      minAmount: json["min_amount"],
      createdAt: json["created_at"],
      lon: json["lon"],
      password: json["password"],
      phone: json["phone"],
      name: json["name"],
      maxDelTime: json["max_del_time"],
      oilMarketing: List<String>.from(json["oil_marketing"].map((x) => x)),
      landmark: json["landmark"],
      lat: json["lat"],
      email: json["email"],
      status: json["status"],
      description: json['description'],
      image: json['image'],
      bannerImage: json['banner_image'],
      everyDay: json['every_day'],
      openTime: json['open_time'] ?? '00:00',
      closeTime: json['close_time'] ?? '00:00',
      timings: List<ShopTimings>.from(
        json['selected_times'].map((x) => ShopTimings.fromJson(x)),
      ));

  Map<String, dynamic> toJson() => {
    "offer_percent": offerPercent,
    "address": address,
    "min_amount": minAmount,
    "created_at": createdAt,
    "lon": lon,
    "password": password,
    "phone": phone,
    "name": name,
    "max_del_time": maxDelTime,
    "oil_marketing": List<dynamic>.from(oilMarketing.map((x) => x)),
    "landmark": landmark,
    "lat": lat,
    "email": email,
    "status": status,
  };
}
