import 'package:fliproadmin/core/model/project_response/project_response.dart';

class UserRoleResponse {
  String? message;
  Data? data;

  UserRoleResponse({this.message, this.data});

  UserRoleResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? currentPage;
  List<UserRoleModel>? users;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Links>? links;
  String? path;
  var perPage;
  int? to;
  int? total;

  Data(
      {this.currentPage,
        this.users,
        this.firstPageUrl,
        this.from,
        this.lastPage,
        this.lastPageUrl,
        this.links,
        this.path,
        this.perPage,
        this.to,
        this.total});

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      users = <UserRoleModel>[];
      json['data'].forEach((v) {
        users!.add(UserRoleModel.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    if (json['links'] != null) {
      links = <Links>[];
      json['links'].forEach((v) {
        links!.add(Links.fromJson(v));
      });
    }
    path = json['path'];
    perPage = json['per_page'];

    to = json['to'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['current_page'] = currentPage;
    if (users != null) {
      data['data'] = users!.map((v) => v.toJson()).toList();
    }
    data['first_page_url'] = firstPageUrl;
    data['from'] = from;
    data['last_page'] = lastPage;
    data['last_page_url'] = lastPageUrl;
    if (links != null) {
      data['links'] = links!.map((v) => v.toJson()).toList();
    }
    data['path'] = path;
    data['per_page'] = perPage;
    data['to'] = to;
    data['total'] = total;
    return data;
  }
}
