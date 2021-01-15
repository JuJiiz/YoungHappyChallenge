class BaseRemoteResponse {
  final bool success;
  final dynamic data;
  final String message;

  BaseRemoteResponse({this.success: false, this.data, this.message});

  factory BaseRemoteResponse.fromJson(Map<String, dynamic> json) =>
      BaseRemoteResponse(
        success: json['success'] as bool,
        data: json['data'] as dynamic,
        message: json['message'] as String,
      );
}
