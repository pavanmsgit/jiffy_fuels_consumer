List<ShopTimings> shopTimingsFromJson(str) =>
    List<ShopTimings>.from((str).map((x) => ShopTimings.fromJson(x)));

List shopTimingsToJson(List<ShopTimings> data) =>
    (List.from(data.map((x) => x.toJson())));

class ShopTimings {
  ShopTimings({
    this.openTime,
    this.closeTime,
  });

  String? openTime;
  String? closeTime;

  factory ShopTimings.fromJson(Map<String, dynamic> json) => ShopTimings(
        openTime: json["open_time"] ?? '00:00',
        closeTime: json["close_time"] ?? '00:00',
      );

  Map<String, dynamic> toJson() => {
        "open_time": openTime,
        "close_time": closeTime,
      };
}
