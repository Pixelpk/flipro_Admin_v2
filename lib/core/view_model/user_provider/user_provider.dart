// import 'package:fliproadmin/core/model/user_model/user_model.dart';
// import 'package:fliproadmin/core/services/db_service/db_service.dart';
// import 'package:fliproadmin/core/utilities/app_constant.dart';
// import 'package:flutter/cupertino.dart';
//
// class UserProvider with ChangeNotifier{
//   User? _user ;
//   String? _authToken ;
//   DbService? _dbService ;
//   String get getAuthToken =>_authToken! ;
//   User get getCurrentUser => _user!;
//
//   UserProvider(){
//     _dbService = DbService();
//     var userjson = _dbService!.readJson(AppConstant.getCurrentUser);
//    String token = _dbService!.readString(AppConstant.getToken) ??'null';
//     print(" TOKEN $token");
//     print("INITIALING USER");
//     print(userjson);
//    if(userjson!=null )
//      { _authToken = token;
//      _user = User.fromJson(userjson);
//        notifyListeners();
//      }
//
//   }
// }

import 'dart:io';

import 'package:fliproadmin/core/model/generic_model/generic_model.dart';
import 'package:fliproadmin/core/model/user_model/user_model.dart';
import 'package:fliproadmin/core/services/db_service/db_service.dart';
import 'package:fliproadmin/core/services/users_service/user_service.dart';
import 'package:fliproadmin/core/utilities/app_constant.dart';
import 'package:fliproadmin/core/utilities/logic_helper.dart';
import 'package:fliproadmin/core/view_model/auth_provider/auth_provider.dart';
import 'package:fliproadmin/ui/view/login_screen/login_screen.dart';
import 'package:fliproadmin/ui/widget/getx_dialogs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:get/get.dart';

class UserProvider with ChangeNotifier {
  User? _user;
  String? _authToken;
  String? _userId;
  DbService? _dbService;
  loadingState _isLoading = loadingState.loaded;

  loadingState get getLoadingState => _isLoading;

  String get getAuthToken => _authToken ?? '';

  User get getCurrentUser => _user!;

  UserProvider() {
    _dbService = DbService();
    // loadCurrentUser();
  }

  Future loadCurrentUser() {
    String token = _dbService!.readString(AppConstant.getToken) ?? 'null';
    _authToken = token;
    var userjson = _dbService!.readJson(AppConstant.getCurrentUser);
    print("USER OBEJC $userjson");
    if (userjson != null) {
      _user = User.fromJson(userjson);
    }
    notifyListeners();
    return Future.value(_user);
  }

  setStateLoading() {
    _isLoading = loadingState.loading;
    notifyListeners();
  }

  setStateLoaded() {
    _isLoading = loadingState.loaded;
    notifyListeners();
  }

  logout() {
    UsersService.logout(token: _authToken!).then((value) {
      _dbService!.truncateDb();
      DefaultCacheManager().emptyCache();
      _user = null;
      _authToken = null;
      _userId = null;
      Navigator.of(Get.context!)
          .pushNamedAndRemoveUntil(LoginScreen.routeName, (route) => false);
    });
  }

  updateUserProfile(User user, {File? pickedImage}) async {
    try {
      if (_authToken != null) {
        setStateLoading();
        GenericModel genericModel = await UsersService.updateProfile(
            token: _authToken!, user: user, pickedAvatar: pickedImage);
        GetXDialog.showDialog(
            title: genericModel.title, message: genericModel.message);
        if (genericModel.statusCode == 200) {
          final user = genericModel.returnedModel as User;
          if (user != null) {
            _dbService!.writeAsJson(
                key: AppConstant.getCurrentUser, data: user.toJson());
            _user = user;
          }
        }
      } else {
        LogicHelper.unauthorizedHandler(showMessage: true);
      }
    } finally {
      setStateLoaded();
    }
  }

  updatePassword(
      {required String newPassword, required String currentPassword}) async {
    try {
      if (_authToken != null) {
        setStateLoading();
        GenericModel genericModel = await UsersService.updatePassword(
          token: _authToken!,
          currentPass: currentPassword,
          newPass: newPassword,
        );
        if(genericModel.success)
          {
            Navigator.pop(Get.context!);
          }
        GetXDialog.showDialog(
            title: genericModel.title, message: genericModel.message);
      } else {
        LogicHelper.unauthorizedHandler(showMessage: true);
      }
    } finally {
      setStateLoaded();
    }
  }

  //
  // userInit({bool navigateToHome = true}) async {
  //   String token = _dbService!.readString(AppConstant.accessToken) ?? 'null';
  //   String Id = _dbService!.readString(AppConstant.currentUserId) ?? 'null';
  //   setStateLoading();
  //   GenericModel genericModel =
  //   await UserService.getUser(userId: Id, token: token);
  //
  //   if (genericModel.statusCode == 200) {
  //     LoadedUserModel loadedUserModel =
  //     genericModel.returnModel as LoadedUserModel;
  //     await _dbService!.writeAsJson(
  //         key: AppConstant.currentUser, data: loadedUserModel.data!.user);
  //     loadCurrentUser();
  //
  //     if(navigateToHome) {
  //       Navigator.of(Get.context!).pushNamedAndRemoveUntil(
  //           HomeMapScreen.routeName, (Route<dynamic> route) => false);
  //     }
  //
  //   } else if (genericModel.statusCode == 400 ||
  //       genericModel.statusCode == 422 ||
  //       genericModel.statusCode == 401) {
  //     GetXDialog.showDialog(
  //       title: genericModel.title,
  //       message: genericModel.message,
  //     );
  //   } else {
  //
  //   }
  //   setStateLoaded();
  // }
}
