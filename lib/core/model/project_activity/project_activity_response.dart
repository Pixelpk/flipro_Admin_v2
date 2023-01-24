import '../../utilities/logic_helper.dart';

class ActivityTimeLineResponse {
  String? message;
  Data? data;

  ActivityTimeLineResponse({this.message, this.data});

  ActivityTimeLineResponse.fromJson(Map<String, dynamic> json) {
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
  List<ProjectActivityModel>? activities;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? path;
  String? perPage;
  int? to;
  int? total;

  Data(
      {this.currentPage,
      this.activities,
      this.firstPageUrl,
      this.from,
      this.lastPage,
      this.path,
      this.perPage,
      this.to,
      this.total});

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      activities = <ProjectActivityModel>[];
      json['data'].forEach((v) {
        activities!.add(ProjectActivityModel.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    path = json['path'];
    perPage = json['per_page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['current_page'] = currentPage;
    if (this.activities != null) {
      data['data'] = this.activities!.map((v) => v.toJson()).toList();
    }
    data['first_page_url'] = firstPageUrl;
    data['from'] = from;
    data['last_page'] = lastPage;
    data['path'] = path;
    data['per_page'] = perPage;

    data['to'] = to;
    data['total'] = total;
    return data;
  }
}

class ProjectActivityModel {
  int? id;
  int? projectId;
  int? userId;
  int? status;
  String? description;
  String? createdAt;
  String? updatedAt;
  String? dateTime;

  ProjectActivityModel(
      {this.id, this.projectId, this.userId, this.status, this.description, this.createdAt, this.updatedAt});

  ProjectActivityModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    projectId = json['project_id'];
    userId = json['user_id'];
    status = json['status'];
    description = json['description'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    dateTime = LogicHelper.getFormattedDate(createdAt!);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['project_id'] = projectId;
    data['user_id'] = userId;
    data['status'] = status;
    data['description'] = description;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
