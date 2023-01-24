class ProjectInfoShareModel {
  bool? areaSelectecd = false;
  bool? descripton = false;
  bool? title = false;
  bool? anticipatedBudget = false;
  bool? debt = false;
  bool? email = false;
  bool? currentValue = false;
  bool? projectAddress = false;
  bool? applicantName = false;
  bool? applicantAddress = false;
  bool? applicantPhone = false;
  bool? registeredOwner = false;
  bool? propertyDept = false;
  bool? crossColl = false;
  bool? existingQ = false;
  bool? postCode = false;

  String? area;
  String? descriptonText;
  String? titleText;
  String? anticipatedBudgetText;
  String? debtText;
  String? emailText;
  String? currentValueText;
  String? projectAddressText;
  String? applicantNameText;
  String? applicantAddressText;
  String? applicantPhoneText;
  String? registeredOwnerText;
  String? propertyDeptText;
  String? crossCollText;
  String? existingQText;
  String? PostCodeText;

  ProjectInfoShareModel(
      {this.descripton = false,
      this.title = false,
      this.email = false,
      this.debt = false,
      this.anticipatedBudget = false,
      this.currentValue = false,
      this.areaSelectecd = false,
      this.projectAddress = false,
      this.applicantAddress = false,
      this.applicantName = false,
      this.applicantPhone = false,
      this.registeredOwner = false,
      this.propertyDept = false,
      this.crossColl = false,
      this.existingQ = false,
      this.postCode = false,
      this.area,
      this.anticipatedBudgetText,
      this.currentValueText,
      this.debtText,
      this.descriptonText,
      this.emailText,
      this.titleText,
      this.projectAddressText,
      this.applicantNameText,
      this.applicantAddressText,
      this.applicantPhoneText,
      this.registeredOwnerText,
      this.propertyDeptText,
      this.crossCollText,
      this.existingQText,
      this.PostCodeText});
}
