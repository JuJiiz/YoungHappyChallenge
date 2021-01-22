class InputVerifyOTP {
  final String otpRef;
  final String otpCode;

  const InputVerifyOTP(this.otpRef, this.otpCode);

  Map<String, String> toMap() => {
        "otp_ref": otpRef,
        "otp": otpCode,
      };
}
