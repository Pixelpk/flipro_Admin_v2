import 'package:fliproadmin/core/model/project_response/project_response.dart';
import 'package:fliproadmin/core/utilities/logic_helper.dart';

class NotesResponse {
  String? message;
  Data? data;

  NotesResponse({this.message, this.data});

  NotesResponse.fromJson(Map<String, dynamic> json) {
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
  List<Note>? notes;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  String? path;
  String? perPage;
  int? to;
  int? total;

  Data(
      {this.currentPage,
      this.notes,
      this.firstPageUrl,
      this.from,
      this.lastPage,
      this.lastPageUrl,
      this.path,
      this.perPage,
      this.to,
      this.total});

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      notes = <Note>[];
      json['data'].forEach((v) {
        notes!.add(Note.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    to = json['to'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['current_page'] = currentPage;
    if (this.notes != null) {
      data['data'] = this.notes!.map((v) => v.toJson()).toList();
    }
    data['first_page_url'] = firstPageUrl;
    data['from'] = from;
    data['last_page'] = lastPage;
    data['last_page_url'] = lastPageUrl;
    data['path'] = path;
    data['per_page'] = perPage;
    data['to'] = to;
    data['total'] = total;
    return data;
  }
}

class Note {
  int? id;
  int? projectId;
  int? userId;
  bool? private;
  String? createdAt;
  String? updatedAt;
  String? notes;
  UserRoleModel? user;
  String? timeago;

  bool? isEditAble;

  Note(
      {this.id,
      this.projectId,
      this.userId,
      this.isEditAble = false,
      this.private = false,
      this.createdAt,
      this.updatedAt,
      this.notes,
      this.user});

  Note.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    projectId = json['project_id'];
    userId = json['user_id'];
    private = json['private'] == 1 || json['private'] == "true" || json['private'] ? true : false;
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    notes = json['notes'];
    user = json['user'] != null ? UserRoleModel.fromJson(json['user']) : null;
    timeago = LogicHelper.getTimeAgo(updatedAt!);
    isEditAble = true;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['project_id'] = projectId;
    data['private'] = private == true ? 1 : 0;
    data['notes'] = notes;
    return data;
  }
}

class User {
  int? id;
  String? name;

  User({this.id, this.name});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}
