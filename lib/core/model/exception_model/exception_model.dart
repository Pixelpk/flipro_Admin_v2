class ExceptionModel {
  String? message;
  Errors? errors;

  ExceptionModel({this.message, this.errors});

  ExceptionModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    errors = json['errors'] != null ? Errors.fromJson(json['errors']) : null;
  }
}

class Errors {
  List<Error>? errorList = [];

  Errors({this.errorList});

  Errors.fromJson(Map<String, dynamic> json) {
    json.forEach((key, value) {
      errorList!.add(Error(error: key, message: value[0]));
    });
  }
}

class Error {
  String? error;
  String? message;

  Error({this.message, this.error});

  Error.fromJson(Map<String, dynamic> json) {
    error = json['error'].cast<String>();
    message = json['message'].cast<String>();
  }
}
