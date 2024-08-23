class Failure {
  final String message;
  Failure({required this.message});
}

const kInternetFailureMessage =
    "Internet not available, App is running offline.";

class InternetFailure extends Failure {
  InternetFailure() : super(message: kInternetFailureMessage);
}

class GeneralTryAgainFailure extends Failure {
  GeneralTryAgainFailure()
      : super(message: "Something went wrong, please try again!");
}

class UnidentifiedFailure extends Failure {
  final String? errorMessage;
  UnidentifiedFailure({this.errorMessage})
      : super(
            message:
                errorMessage ?? "An error occured, please try again later.");
}

class UnexpectedError extends Failure {
  UnexpectedError()
      : super(message: "unexpected error occurred while fetching the posts");
}

class HTTP203NonAuthoritativeInformationFailure extends Failure {
  HTTP203NonAuthoritativeInformationFailure()
      : super(message: "Non-Authoritative Information");
}

class HTTP204NoContentFailure extends Failure {
  HTTP204NoContentFailure() : super(message: "No Content");
}

class HTTP400BadRequestFailure extends Failure {
  HTTP400BadRequestFailure() : super(message: "Bad Request");
}

class HTTP401UnauthorizedFailure extends Failure {
  HTTP401UnauthorizedFailure()
      : super(message: "Could not be authenticated. Please log in again.");
}

class HTTP403ForbiddenFailure extends Failure {
  HTTP403ForbiddenFailure() : super(message: "Forbidden");
}

class HTTP404NotFoundFailure extends Failure {
  HTTP404NotFoundFailure() : super(message: "Not Found");
}

class HTTP405MethodNotAllowedFailure extends Failure {
  HTTP405MethodNotAllowedFailure() : super(message: "Method Not Allowed");
}

class HTTP406NotAcceptableFailure extends Failure {
  HTTP406NotAcceptableFailure() : super(message: "Not Acceptable");
}

class HTTP407ProxyAuthenticationRequiredFailure extends Failure {
  HTTP407ProxyAuthenticationRequiredFailure()
      : super(message: "Proxy Authentication Required");
}

class HTTP408RequestTimeoutFailure extends Failure {
  HTTP408RequestTimeoutFailure() : super(message: "Request Timeout");
}

class HTTP415UnsupportedMediaTypeFailure extends Failure {
  HTTP415UnsupportedMediaTypeFailure()
      : super(message: "Unsupported Media Type");
}

class HTTP429TooManyRequestsFailure extends Failure {
  HTTP429TooManyRequestsFailure() : super(message: "Too Many Requests");
}

class HTTP502BadGatewayFailure extends Failure {
  HTTP502BadGatewayFailure() : super(message: "Bad Gateway");
}

class HTTP503ServiceUnavailableFailure extends Failure {
  HTTP503ServiceUnavailableFailure()
      : super(
            message:
                "Our servers aren't responding at the moment. Please try again soon");
}

class HTTP504GatewayTimeoutFailure extends Failure {
  HTTP504GatewayTimeoutFailure() : super(message: "Gateway Timeout");
}
