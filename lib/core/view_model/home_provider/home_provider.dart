import 'package:fliproadmin/ui/widget/ui_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class HomeProvider with ChangeNotifier {
  int _selectedHomeIndex =3;
  int _activityPageViewCurrentPage = 0;
  int _projectViewCurrentPage = 0;
  int get getSelectedHomeIndex => _selectedHomeIndex;
  int get getActivityPageViewCurrentPage => _activityPageViewCurrentPage;
  int get getProjectViewCurrentPage => _projectViewCurrentPage;
  void onItemTapped(int index) {
    if (index == 5) {
      UIHelper.deleteDialog(
          "Are you sure you want to Logout?", () {}, Get.context!,
          title: "Logout");
    } else {
      _selectedHomeIndex = index;
      notifyListeners();
    }
  }

  void onActivityProjectsPageChange(int index) {
    _activityPageViewCurrentPage = index;
    notifyListeners();
  }

  void onProjectViewPageChange(int index) {
    _projectViewCurrentPage = index;
    notifyListeners();
  }
}
