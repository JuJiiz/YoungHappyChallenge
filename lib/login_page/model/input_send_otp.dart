class InputSendOTP {
  final String phoneNumber;
  final String callingCode;

  const InputSendOTP(this.phoneNumber, this.callingCode);

  Map<String, String> toMap() => {
        "phone_number": phoneNumber,
        "country_code": callingCode,
      };
}
