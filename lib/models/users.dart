///NEW FILE
///
import 'dart:convert';


User userProfileFromJson(str) => User.fromJson((str));

String userProfileToJson(User data) => json.encode(data.toJson());

List<User> usersFromJson(str) =>
    List<User>.from((str).map((x) => User.fromJson(x.data())));

String usersToJson(List<User> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class User {
  User({
    required this.name,
    required this.phone,
    required this.email,
    required this.profileImage,
    required this.password,
    required this.deviceId,
    required this.createdAt,
    required this.status,
  });

  String name;
  String phone;
  String email;
  String profileImage;
  String password;
  String deviceId;
  String createdAt;
  bool status;

  factory User.fromJson(Map<String, dynamic> json) => User(
        name: json["name"],
        phone: json["phone"],
        email: json["email"],
        profileImage: json["profile_image"],
        password: json["password"],
        deviceId: json["device_id"],
        createdAt: json["created_at"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "phone": phone,
        "email": email,
        "profile_image": profileImage,
        "password": password,
        "device_id": deviceId,
        "created_at": createdAt,
        "status": status,
      };
}
