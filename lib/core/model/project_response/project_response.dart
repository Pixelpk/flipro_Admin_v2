import 'dart:convert';

import 'package:fliproadmin/core/model/media_compression_model/media_compression_model.dart';
import 'package:fliproadmin/core/model/note_model/note_model.dart';
import 'package:fliproadmin/core/model/payment_response/draw_down_payment.dart';
import 'package:fliproadmin/core/model/project_roles/project_roles.dart';
import 'package:fliproadmin/core/utilities/logic_helper.dart';
import 'package:fliproadmin/core/view_model/project_provider/project_provider.dart';

class ProjectResponse {
  int? currentPage;
  List<ProjectProvider>? projectsList;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  String? path;
  var perPage;
  int? to;
  int? total;

  ProjectResponse(
      {this.currentPage,
      this.projectsList,
      this.firstPageUrl,
      this.from,
      this.lastPage,
      this.lastPageUrl,
      this.path,
      this.perPage,
      this.to,
      this.total});

  ProjectResponse.fromJson(Map<String, dynamic> json) {
    currentPage = json['data']['current_page'];
    print(json['data']['data']);
    if (json['data'] != null) {
      projectsList = <ProjectProvider>[];
      json['data']['data'].forEach((v) {
        projectsList!.add(ProjectProvider(Project.fromJson(v)));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['data']['last_page'];
    lastPageUrl = json['last_page_url'];

    path = json['path'];
    perPage = json['per_page'];
    to = json['to'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['current_page'] = currentPage;
    if (projectsList != null) {
      data['data'] = projectsList!.map((v) => v.getProject.toJson()).toList();
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

class Project {
  int? id;
  String? title;
  num? anticipatedBudget;
  String? projectAddress;
  String? projectState;
  String? contractorSupplierDetails;
  String? applicantName;
  String? email;
  String? phone;
  String? applicantAddress;
  String? registeredOwners;
  num? currentPropertyValue;
  String? projectLatestMarkedValue;

  num? propertyDebt;
  num? crossCollaterized;
  String? status;
  String? createdAt;
  String? updatedAt;
  String? area;
  String? description;
  bool? progressSatisfied;
  bool? valuationSatisfied;
  bool? valuationReviewed;
  bool? progressReviewed;
  String? userId;
  String? leadUserId;
  bool? assigned;
  List<String>? photoGallery;
  UserRoleModel? franchisee;
  UserRoleModel? lead;
  List<UserRoleModel>? builder;
  List<UserRoleModel>? valuers;
  String? coverPhoto;
  List<String>? actionRequired;
  ProjectRoles? projectRoles;
  List<MediaCompressionModel>? videos;
  ProgressModel? latestProgress;
  Note? latestNote;
  DrawDownPayment? latestPaymentReq;
  MediaObject? projectMedia;
  String? final_progress_reviews;
  String? valuationReviews;

  Project(
      {this.id,
      this.title,
      this.anticipatedBudget,
      this.projectAddress,
      this.latestPaymentReq,
      this.projectState,
      this.latestNote,
      this.latestProgress,
      this.final_progress_reviews,
      this.valuationReviews,
      this.valuationSatisfied,
      this.contractorSupplierDetails,
      this.applicantName,
      this.area,
      this.description,
      this.progressSatisfied,
      this.progressReviewed,
      this.valuationReviewed,
      this.email,
      this.phone,
      this.projectLatestMarkedValue,
      this.applicantAddress,
      this.registeredOwners,
      this.currentPropertyValue,
      this.valuers,
      this.propertyDebt,
      this.crossCollaterized,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.userId,
      this.leadUserId,
      this.assigned,
      this.photoGallery,
      this.videos,
      this.franchisee,
      this.lead,
      this.coverPhoto,
      this.actionRequired,
      this.projectRoles});

  Project.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'] ?? '';
    anticipatedBudget = json['anticipated_budget'];
    projectAddress = json['project_address'] ?? '';
    projectState = json['project_state'];
    contractorSupplierDetails = json['contractor_supplier_details'];
    applicantName = json['applicant_name'];
    email = json['email'];
    phone = json['phone'];
    // latestProgress = json['latest_progress'];
    if (json['latest_note'] != null) {
      latestNote = Note.fromJson(json["latest_note"]);
    }
    projectLatestMarkedValue = json['latest_value'].toString();

    area = json['area'] ?? '';
    progressSatisfied = json['progress_satisfied'] ?? false;
    description = json['description'];
    final_progress_reviews = json['final_progress_reviews'];
    applicantAddress = json['applicant_address'];
    registeredOwners = json['registered_owners'];
    currentPropertyValue = json['current_property_value'];
    propertyDebt = json['property_debt'];
    crossCollaterized = json['cross_collaterized'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    userId = json['user_id'];
    leadUserId = json['lead_user_id'];
    assigned = json['assigned'] ?? false;
    if (json['photos'] != null) {
      photoGallery = json['photos'].cast<String>();
    }
    if (json['latest_payment_request'] != null) {
      latestPaymentReq = DrawDownPayment.fromJson(json["latest_payment_request"]);
    }
    if (json['evaluators'] != null) {
      valuers = <UserRoleModel>[];
      json['evaluators'].forEach((v) {
        valuers!.add(UserRoleModel.fromJson(v));
      });
    }

    if (json['videos'] != null) {
      videos = <MediaCompressionModel>[];
      json['videos'].forEach((v) {
        videos!.add(MediaCompressionModel.fromJson(v));
      });
    }
    if (json['latest_progress'] != null) {
      latestProgress = ProgressModel.fromJson(json['latest_progress']);
    }
    franchisee = json['franchisee'] != null ? UserRoleModel.fromJson(json['franchisee']) : null;
    lead = json['lead'] != null && json['lead'].isNotEmpty ? UserRoleModel.fromJson(json['lead'][0]) : null;
    coverPhoto = json['cover_photo'];

    valuationSatisfied = json['evaluation_satisfied'];
    valuationReviews = json['evaluation_reviews'];
    valuationReviewed = json['evaluation_reviewed'];
    progressReviewed = json['progress_reviewed'];

    ///TODO:
    if (json['builders'] != null) {
      builder = <UserRoleModel>[];
      json['builders'].forEach((v) {
        builder!.add(UserRoleModel.fromJson(v));
      });
    }
    if (json['evaluators'] != null) {
      valuers = <UserRoleModel>[];
      json['evaluators'].forEach((v) {
        valuers!.add(UserRoleModel.fromJson(v));
      });
    }
    projectMedia = MediaObject(images: photoGallery, videos: videos);
    projectRoles = json['project_roles'] != null ? ProjectRoles.fromJson(json['project_roles']) : null;
  }

  Map<String, String> toJson() {
    final Map<String, String> data = <String, String>{};

    if (id != null) {
      data['id'] = id.toString();
    }
    data['title'] = title!;
    data['anticipated_budget'] = anticipatedBudget.toString();
    data['project_address'] = projectAddress!;
    data['project_state'] = projectState!;
    data['contractor_supplier_details'] = contractorSupplierDetails!;
    data['applicant_name'] = applicantName!;
    data['email'] = email!;
    data['phone'] = phone!;
    data['applicant_address'] = applicantAddress!;
    data['registered_owners'] = registeredOwners!;
    data['current_property_value'] = currentPropertyValue.toString();
    data['property_debt'] = propertyDebt.toString();
    data['cross_collaterized'] = crossCollaterized.toString();
    if (status != null) {
      data['status'] = status!;
    }
    data['latest_value'] = projectLatestMarkedValue ?? '0';
    if (createdAt != null) {
      data['created_at'] = createdAt!;
    }
    if (updatedAt != null) {
      data['updated_at'] = updatedAt!;
    }
    // data['photos'] = photoGallery!;
    data['area'] = area!;
    data['description'] = description!;

    ///TODO:
    // if (videoGallery != null) {
    //   data['video_gallery'] =
    //       videoGallery!.map((v) => v.toJson()).toList();
    // }
    // if (franchisee != null) {
    //   data['franchisee'] = franchisee!.toJson();
    // }
    // if (lead != null) {
    //   data['lead'] = lead!.toJson();
    // }
    if (coverPhoto != null) {
      data['cover_photo'] = coverPhoto!;
    }

    ///TODO:
    // if (actionRequired != null) {
    //   data['action_required'] =
    //       actionRequired!.map((v) => v.toJson()).toList();
    // }
    // if (projectRoles != null) {
    //   data['project_roles'] = projectRoles!.toJson();
    // }
    return data;
  }
}

class UserRoleModel {
  int? id;
  String? name;
  String? email;
  String? avatar;
  String? phoneCode;
  String? phone;
  String? address;
  String? companyName;
  String? emailVerifiedAt;
  String? createdAt;
  String? updatedAt;
  String? userType;
  String? createdBy;

  ProjectRoles? userRole;

  UserRoleModel({
    this.id,
    this.name,
    this.email,
    this.phoneCode,
    this.phone,
    this.address,
    this.avatar,
    this.companyName,
    this.emailVerifiedAt,
    this.createdAt,
    this.updatedAt,
    this.userType,
    this.userRole,
    this.createdBy,
  });

  UserRoleModel.fromJson(Map<String, dynamic> json) {
    print("JSON $json");
    id = json['id'];
    name = json['name'];
    avatar = json['avatar'] ?? '';
    email = json['email'];
    phoneCode = json['phone_code'];
    phone = json['phone'];
    address = json['address'];
    emailVerifiedAt = json['email_verified_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    userType = json['user_type'];
    createdBy = json['created_by'];
    companyName = json['company_name'];

    try {
      if (json.containsKey("roles")) {
        userRole = json['roles'] != null && json['roles'] != ''
            ? ProjectRoles.fromJson(jsonDecode(json['roles']))
            : ProjectRoles();
      } else {
        userRole = ProjectRoles();
      }
    } catch (e) {
      return;
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['avatar'] = avatar;
    data['phone_code'] = phoneCode;
    data['phone'] = phone;
    data['address'] = address;
    data['email_verified_at'] = emailVerifiedAt;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['user_type'] = userType;
    data['user_type'] = userType;
    data['company_name'] = companyName;
    data['roles'] = userRole;
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

class ProgressModel {
  int? id;
  String? title;
  String? description;
  int? finalProgress;
  String? createdAt;
  String? updatedAt;
  int? projectId;
  List<String>? photos;
  List<MediaCompressionModel>? videos;
  int? userId;
  UserRoleModel? user;
  String? formattedDate;

  ProgressModel(
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
      this.user});

  ProgressModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    finalProgress = json['final_progress'];
    createdAt = json['created_at'];
    if (createdAt != null) {
      formattedDate = LogicHelper.getFormattedDate(createdAt!);
    }
    updatedAt = json['updated_at'];
    projectId = json['project_id'];
    photos = json['photos'].cast<String>();
    if (json['videos'] != null) {
      videos = <MediaCompressionModel>[];
      json['videos'].forEach((v) {
        videos!.add(MediaCompressionModel.fromJson(v));
      });
    }
    userId = json['user_id'];
    user = json['user'] != null ? UserRoleModel.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['final_progress'] = finalProgress;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['project_id'] = projectId;
    data['photos'] = photos;
    if (videos != null) {
      data['videos'] = videos!.map((v) => v.toJson()).toList();
    }
    data['user_id'] = userId;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}
