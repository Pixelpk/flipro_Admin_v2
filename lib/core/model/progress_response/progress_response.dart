import 'package:fliproadmin/core/model/project_response/project_response.dart';

class ProgressResponse {
  String? message;
  Data? data;

  ProgressResponse({this.message, this.data});

  ProgressResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
}

class Data {
  List<ProgressModel>? progressess;

  Data({
    this.progressess,
  });

  Data.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      progressess = <ProgressModel>[];
      json['data'].forEach((v) {
        progressess!.add(ProgressModel.fromJson(v));
      });
    }
  }
}
