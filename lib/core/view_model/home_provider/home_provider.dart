import 'package:fliproadmin/core/view_model/user_provider/user_provider.dart';
import 'package:fliproadmin/ui/widget/ui_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class HomeProvider with ChangeNotifier {
  int _selectedHomeIndex = 0;
  int _activityPageViewCurrentPage = 0;
  int _projectViewCurrentPage = 0;
  int get getSelectedHomeIndex => _selectedHomeIndex;
  int get getActivityPageViewCurrentPage => _activityPageViewCurrentPage;
  int get getProjectViewCurrentPage => _projectViewCurrentPage;
  void onItemTapped(int index) {
    if (index == 5) {
      UIHelper.deleteDialog("Are you sure you want to Logout?", () {
        Provider.of<UserProvider>(Get.context!, listen: false).logout();
      }, Get.context!, title: "Logout");
    } else {
      if(index == 1)
      {
        _activityPageViewCurrentPage = 0 ;
      }
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
