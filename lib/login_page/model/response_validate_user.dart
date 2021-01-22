class ResponseValidateUser {
  final String customToken;
  final bool isRegister;

  const ResponseValidateUser(this.customToken, this.isRegister);

  factory ResponseValidateUser.fromJson(Map<String, dynamic> json) =>
      ResponseValidateUser(
        json["custom_token"],
        json["is_register"],
      );
}
