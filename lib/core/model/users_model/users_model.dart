import 'package:fliproadmin/core/model/project_response/project_response.dart';

class UsersModel {
  String? message;
  PaginationData? data;

  UsersModel({this.message, this.data});

  UsersModel.fromJson(Map<String, dynamic> json) {

    message = json['message'];
    data = json['data'] != null ? PaginationData.fromJson(json['data']) : null;
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

class PaginationData {
  int? currentPage;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Links>? links;
  String? nextPageUrl;
  String? path;
  List<UserRoleModel>users = [];
  var perPage;
  String? prevPageUrl;
  int? to;
  int? total;

  PaginationData(
      {this.currentPage,
        this.firstPageUrl,
        this.from,
        this.lastPage,
        this.lastPageUrl,
        this.links,
        this.nextPageUrl,
        this.path,
        this.perPage,
        this.prevPageUrl,
        this.to,
        this.total});

  PaginationData.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    if (json['data'] != null) {
      users = <UserRoleModel>[];
      json['data'].forEach((v) {
        users.add(UserRoleModel.fromJson(v));
      });
      print("usef $users");
    }
    lastPageUrl = json['last_page_url'];
    if (json['links'] != null) {
      links = <Links>[];
      json['links'].forEach((v) {
        links!.add(Links.fromJson(v));
      });
    }
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['current_page'] = currentPage;
    data['first_page_url'] = firstPageUrl;
    data['from'] = from;
    data['last_page'] = lastPage;
    data['last_page_url'] = lastPageUrl;
    if (links != null) {
      data['links'] = links!.map((v) => v.toJson()).toList();
    }
    data['next_page_url'] = nextPageUrl;
    data['path'] = path;
    data['per_page'] = perPage;
    data['prev_page_url'] = prevPageUrl;
    data['to'] = to;
    data['total'] = total;
    return data;
  }
}

class Links {
  String? url;
  String? label;
  bool? active;

  Links({this.url, this.label, this.active});

  Links.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    label = json['label'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['url'] = url;
    data['label'] = label;
    data['active'] = active;
    return data;
  }
}

class Member {
  int? id;
  String? name;
  String? email;
  String? phoneCode;
  String? phone;
  String? address;
  Null? emailVerifiedAt;
  String? createdAt;
  String? updatedAt;
  String? userType;
  int? createdBy;
  String? roles;

  Member(
      {this.id,
        this.name,
        this.email,
        this.phoneCode,
        this.phone,
        this.address,
        this.emailVerifiedAt,
        this.createdAt,
        this.updatedAt,
        this.userType,
        this.createdBy,
        this.roles});

  Member.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phoneCode = json['phone_code'];
    phone = json['phone'];
    address = json['address'];
    emailVerifiedAt = json['email_verified_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    userType = json['user_type'];
    createdBy = json['created_by'];
    roles = json['roles'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['phone_code'] = phoneCode;
    data['phone'] = phone;
    data['address'] = address;
    data['email_verified_at'] = emailVerifiedAt;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['user_type'] = userType;
    data['created_by'] = createdBy;
    data['roles'] = roles;
    return data;
  }
}

