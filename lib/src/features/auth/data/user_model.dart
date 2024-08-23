import 'package:hive/hive.dart';

part 'user_model.g.dart';

@HiveType(typeId: 1)
class UserModel extends HiveObject {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final String phoneNumber;
  @HiveField(2)
  final String designation;
  @HiveField(3)
  final String photoUrl;
  @HiveField(4)
  final bool isLoggedIn;
  @HiveField(5)
  final String? rightPhotoUrl;

  UserModel({
    required this.name,
    required this.phoneNumber,
    required this.designation,
    required this.photoUrl,
    required this.isLoggedIn,
    this.rightPhotoUrl,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'],
      phoneNumber: json['phoneNumber'],
      designation: json['designation'],
      photoUrl: json['photoUrl'],
      isLoggedIn: json['isLoggedIn'],
      rightPhotoUrl: json['rightPhotoUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'phoneNumber': phoneNumber,
      'designation': designation,
      'photoUrl': photoUrl,
      'isLoggedIn': isLoggedIn,
      'rightPhotoUrl': rightPhotoUrl,
    };
  }
}
