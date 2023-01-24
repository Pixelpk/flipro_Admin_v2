import 'package:fliproadmin/core/model/media_compression_model/media_compression_model.dart';
import 'package:fliproadmin/core/model/project_response/project_response.dart';

class DrawDownPayment {
  int? id;
  int? projectId;
  int? userId;
  num? amount;

  String? description;
  String? reason;
  List<String>? images;
  List<MediaCompressionModel>? videos;
  String? status;
  String? createdAt;
  String? updatedAt;
  Project? project;
  UserRoleModel? user;
  MediaObject? paymentReqMedia;

  DrawDownPayment(
      {this.id,
      this.projectId,
      this.userId,
      this.user,
      this.amount,
      this.description,
      this.images,
      this.videos,
      this.reason,
      this.project,
      this.status,
      this.createdAt,
      this.updatedAt});

  DrawDownPayment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    projectId = json['project_id'];
    userId = json['user_id'];
    amount = json['amount'];
    project = json['project'] != null ? Project.fromJson(json['project']) : null;
    description = json['description'];
    if (json['images'] != null) {
      images = json['images'].cast<String>();
    }

    if (json['videos'] != null) {
      videos = <MediaCompressionModel>[];
      json['videos'].forEach((v) {
        videos!.add(MediaCompressionModel.fromJson(v));
      });
    }
    if (json.containsKey("user")) {
      user = json['user'] != null ? UserRoleModel.fromJson(json['user']) : null;
    }
    status = json['status'];
    createdAt = json['created_at'] ?? '';
    updatedAt = json['updated_at'] ?? '';
    reason = json['reason'];
    paymentReqMedia = MediaObject(videos: videos, images: images);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['project_id'] = projectId;
    data['user_id'] = userId;
    data['amount'] = amount;
    data['description'] = description;
    data['images'] = images;
    data['images'] = images;
    if (videos != null) {
      data['videos'] = videos!.map((v) => v.toJson()).toList();
    }
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class Project {
  int? id;
  String? title;
  String? description;
  String? coverPhoto;
  String? projectAddress;

  Project({this.id, this.title, this.description, this.coverPhoto, this.projectAddress});

  Project.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    coverPhoto = json['cover_photo'];
    projectAddress = json['project_address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['cover_photo'] = coverPhoto;
    data['project_address'] = projectAddress;
    return data;
  }
}
