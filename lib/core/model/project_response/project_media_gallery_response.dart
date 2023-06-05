class ProjectMediaGalleryResModel {
  String? message;
  Data? data;

  ProjectMediaGalleryResModel({this.message, this.data});

  ProjectMediaGalleryResModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<String>? projectImages;
  List<ProjectVideos>? projectVideos;
  List<PaymentRequest>? paymentRequest;
  List<Progress>? progress;

  Data(
      {this.projectImages,
        this.projectVideos,
        this.paymentRequest,
        this.progress});

  Data.fromJson(Map<String, dynamic> json) {
    projectImages = json['projectImages'].cast<String>();
    if (json['projectVideos'] != null) {
      projectVideos = <ProjectVideos>[];
      json['projectVideos'].forEach((v) {
        projectVideos!.add(new ProjectVideos.fromJson(v));
      });
    }
    if (json['paymentRequest'] != null) {
      paymentRequest = <PaymentRequest>[];
      json['paymentRequest'].forEach((v) {
        paymentRequest!.add(new PaymentRequest.fromJson(v));
      });
    }
    if (json['progress'] != null) {
      progress = <Progress>[];
      json['progress'].forEach((v) {
        progress!.add(new Progress.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['projectImages'] = this.projectImages;
    if (this.projectVideos != null) {
      data['projectVideos'] =
          this.projectVideos!.map((v) => v.toJson()).toList();
    }
    if (this.paymentRequest != null) {
      data['paymentRequest'] =
          this.paymentRequest!.map((v) => v.toJson()).toList();
    }
    if (this.progress != null) {
      data['progress'] = this.progress!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProjectVideos {
  String? file;
  String? thumbnail;

  ProjectVideos({this.file, this.thumbnail});

  ProjectVideos.fromJson(Map<String, dynamic> json) {
    file = json['file'];
    thumbnail = json['thumbnail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['file'] = this.file;
    data['thumbnail'] = this.thumbnail;
    return data;
  }
}

class PaymentRequest {
  int? id;
  int? projectId;
  int? userId;
  int? amount;
  String? description;
  List<String>? images;
  List<ProjectVideos>? videos;
  String? status;
  String? createdAt;
  String? updatedAt;
  ProjectDetail? project;

  PaymentRequest(
      {this.id,
        this.projectId,
        this.userId,
        this.amount,
        this.description,
        this.images,
        this.videos,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.project});

  PaymentRequest.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    projectId = json['project_id'];
    userId = json['user_id'];
    amount = json['amount'];
    description = json['description'];
    images = json['images'].cast<String>();
    if (json['videos'] != null) {
      videos = <ProjectVideos>[];
      json['videos'].forEach((v) {
        videos!.add(new ProjectVideos.fromJson(v));
      });
    }
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    project =
    json['project'] != null ? new ProjectDetail.fromJson(json['project']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['project_id'] = this.projectId;
    data['user_id'] = this.userId;
    data['amount'] = this.amount;
    data['description'] = this.description;
    data['images'] = this.images;
    if (this.videos != null) {
      data['videos'] = this.videos!.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.project != null) {
      data['project'] = this.project!.toJson();
    }
    return data;
  }
}

class ProjectDetail {
  int? id;
  String? title;
  String? description;
  String? coverPhoto;
  String? projectAddress;

  ProjectDetail(
      {this.id,
        this.title,
        this.description,
        this.coverPhoto,
        this.projectAddress});

  ProjectDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    coverPhoto = json['cover_photo'];
    projectAddress = json['project_address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['cover_photo'] = this.coverPhoto;
    data['project_address'] = this.projectAddress;
    return data;
  }
}

class Progress {
  int? id;
  String? title;
  String? description;
  int? finalProgress;
  String? createdAt;
  String? updatedAt;
  int? projectId;
  List<String>? photos;
  List<ProjectVideos>? videos;
  int? userId;


  Progress(
      {this.id,
        this.title,
        this.description,
        this.finalProgress,
        this.createdAt,
        this.updatedAt,
        this.projectId,
        this.photos,
        this.videos,
        this.userId,
});

  Progress.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    finalProgress = json['final_progress'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    projectId = json['project_id'];
    photos = json['photos'].cast<String>();
    if (json['videos'] != null) {
      videos = <ProjectVideos>[];
      json['videos'].forEach((v) {
        videos!.add(new ProjectVideos.fromJson(v));
      });
    }
    userId = json['user_id'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['final_progress'] = this.finalProgress;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['project_id'] = this.projectId;
    data['photos'] = this.photos;
    if (this.videos != null) {
      data['videos'] = this.videos!.map((v) => v.toJson()).toList();
    }
    data['user_id'] = this.userId;
    return data;
  }
}