
class User {
  int? id;
  String? name;
  String? email;
  String? phoneCode;
  String? phone;
  String? address;
  String? emailVerifiedAt;
  String? createdAt;
  String? updatedAt;
  String? userType;
  String? createdBy;
  String? roles;
  String? avatar;
  User(
      {this.id,
        this.name,
        this.email,
        this.phoneCode,
        this.phone,
        this.avatar,
        this.address,
        this.emailVerifiedAt,
        this.createdAt,
        this.updatedAt,
        this.userType,

        this.createdBy,
        this.roles});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phoneCode = json['phone_code'];
    avatar = json['avatar'];
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
    data['avatar']=avatar;
    data['created_by'] = createdBy;
    data['roles'] = roles;
    return data;
  }
}