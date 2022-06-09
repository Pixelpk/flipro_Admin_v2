class ProjectInfoShareModel {
  bool? areaSelectecd = false;
  bool? descripton = false;
  bool? title = false;
  bool? anticipatedBudget = false;
  bool? debt = false;
  bool? email = false;
  bool? currentValue = false;
  String? area;
  String? descriptonText;
  String? titleText;
  String? anticipatedBudgetText;
  String? debtText;
  String? emailText;
  String? currentValueText;
  ProjectInfoShareModel(
      {this.descripton = false,
      this.title = false,
      this.email = false,
      this.debt = false,
      this.anticipatedBudget = false,
      this.currentValue = false,
      this.areaSelectecd = false,
      this.area,
      this.anticipatedBudgetText,
      this.currentValueText,
      this.debtText,
      this.descriptonText,
      this.emailText,
      this.titleText});
}
