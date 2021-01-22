class UserEntity {
  UserEntity({
    this.id,
    this.phoneNumber,
    this.displayName,
    this.imageUrl,
    this.firstName,
    this.lastName,
    this.dateOfBirth,
    this.gender,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String phoneNumber;
  String displayName;
  String imageUrl;
  String firstName;
  String lastName;
  DateTime dateOfBirth;
  String gender;
  DateTime createdAt;
  DateTime updatedAt;

  factory UserEntity.fromJson(Map<String, dynamic> json) =>
      UserEntity(
        id: json["id"],
        phoneNumber: json["phone_number"],
        displayName: json["display_name"],
        imageUrl: json["image_url"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        dateOfBirth: DateTime.parse(json["date_of_birth"]),
        gender: json["gender"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );
}