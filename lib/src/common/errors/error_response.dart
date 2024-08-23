class ErrorResponse {
  final String message;
  final int statusCode;

  ErrorResponse({required this.message, required this.statusCode});

  factory ErrorResponse.fromJson(Map<String, dynamic> json) =>
      ErrorResponse(statusCode: json["status_code"], message: json["message"]);

  Map<String, dynamic> toJson() =>
      {"message": message, "status_code": statusCode};
}
