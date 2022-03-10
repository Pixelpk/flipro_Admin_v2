import 'package:fliproadmin/core/model/exception_model/exception_model.dart';
import 'package:fliproadmin/core/model/generic_model/generic_model.dart';
import 'package:fliproadmin/core/model/login_model/login_model.dart';
import 'package:fliproadmin/core/services/auth_service/auth_service.dart';
import 'package:fliproadmin/core/services/db_service/db_service.dart';
import 'package:fliproadmin/core/utilities/app_constant.dart';
import 'package:fliproadmin/ui/view/home_screen/home_screen.dart';
import 'package:fliproadmin/ui/widget/getx_dialogs.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

enum loadingState { loaded, loading }

class AuthProvider with ChangeNotifier {
  DbService? dbService ;
  AuthProvider(){
    dbService = DbService();
  }
  loadingState _isLoading = loadingState.loaded;
  loadingState get getLoadingState => _isLoading;
  setStateLoading() {
    _isLoading = loadingState.loading;
    notifyListeners();
  }

  setStateLoaded() {
    _isLoading = loadingState.loaded;
    notifyListeners();
  }

  Future emailLogin(String email, String password) async {
    setStateLoading();
    GenericModel genericModel = await AuthService.login(email, password);
    setStateLoaded();

    if (genericModel.statusCode == 200) {
      LoginModel loginModel = genericModel.returnedModel as LoginModel ;
      dbService!.writeString(AppConstant.getToken, loginModel.data!.token);
      dbService!.writeAsJson(key: AppConstant.getCurrentUser,data: loginModel.data!.user!.toJson());
      Navigator.of(Get.context!).pushNamed(HomeScreen.routeName);
    } else if (genericModel.statusCode == 422) {

    } else {
       ExceptionModel exceptionModel =
      genericModel.returnedModel as ExceptionModel;
      GetXDialog().showDialog(
          title: exceptionModel.message,
          message: exceptionModel.errors!.errorList != null &&
              exceptionModel.errors!.errorList!.isNotEmpty
              ? exceptionModel.errors!.errorList![0].message
              : genericModel.message);
          // .showDialog(title: genericModel.title, message: genericModel.message);
    }
  }
}
