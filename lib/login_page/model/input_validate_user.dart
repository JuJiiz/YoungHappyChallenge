class InputValidateUser {
  final String phoneNumber;
  final String callingCode;

  const InputValidateUser(this.phoneNumber, this.callingCode);

  Map<String, String> toMap() => {
        "phone_number": phoneNumber,
        "country_code": callingCode,
      };
}
