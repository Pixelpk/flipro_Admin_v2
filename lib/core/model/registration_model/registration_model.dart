class RegistratingData {
  String? name;
  String? email;
  String? phoneCode;
  String? phone;
  String? address;
  String? userType;
  String? password;
  String? companyName;

  RegistratingData(
      {this.name,
      this.email,
      this.phoneCode,
      this.phone,
      this.address,
      this.userType,
      this.password,
      this.companyName});

  Map<String, String> toJson() {
    final Map<String, String> data = <String, String>{};
    data['name'] = name!;
    data['email'] = email!;
    data['phone_code'] = phoneCode!;
    data['phone'] = phone!;
    data['address'] = address!;
    data['user_type'] = userType!;
    data['password'] = password!;
    data['company_name'] = companyName!;

    return data;
  }
}
