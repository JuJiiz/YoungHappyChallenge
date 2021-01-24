import 'package:younghappychallenge/user/model/user_entity.dart';

class ResponseMyProfile {
  ResponseMyProfile({
    this.refCode,
    this.sumPoint,
    this.sumTime,
    this.user,
  });

  String refCode;
  double sumPoint;
  double sumTime;
  UserEntity user;

  factory ResponseMyProfile.fromJson(Map<String, dynamic> json) =>
      ResponseMyProfile(
        refCode: json["ref_code"],
        sumPoint: json["sum_point"],
        sumTime: json["sum_time"],
        user: UserEntity.fromJson(json["user"]),
      );

  ResponseMyProfile getDefault() {
    return ResponseMyProfile(
      refCode: null,
      sumPoint: 0.0,
      sumTime: 0.0,
      user: null,
    );
  }
}
