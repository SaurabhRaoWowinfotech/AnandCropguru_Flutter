class OTPResponse {
  String staticOTP;
  String uniqueOTP;
  String? data1;
  String responseCode;
  String responseMessage;

  OTPResponse({
    required this.staticOTP,
    required this.uniqueOTP,
    this.data1,
    required this.responseCode,
    required this.responseMessage,
  });
}
