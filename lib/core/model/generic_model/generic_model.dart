class GenericModel {
  bool success;
  var returnedModel;
  String? message;
  String? title;
  int? statusCode;

  GenericModel({required this.success, required this.returnedModel, this.message, this.statusCode, this.title});
}
