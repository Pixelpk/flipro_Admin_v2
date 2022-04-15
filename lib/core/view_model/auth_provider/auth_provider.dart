import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fliproadmin/core/model/exception_model/exception_model.dart';
import 'package:fliproadmin/core/model/generic_model/generic_model.dart';
import 'package:fliproadmin/core/model/login_model/login_model.dart';
import 'package:fliproadmin/core/services/auth_service/auth_service.dart';
import 'package:fliproadmin/core/services/db_service/db_service.dart';
import 'package:fliproadmin/core/utilities/app_constant.dart';
import 'package:fliproadmin/ui/view/forgot_password_screen/forgot_password_otp_screen.dart';
import 'package:fliproadmin/ui/view/forgot_password_screen/update_password_screen.dart';
import 'package:fliproadmin/ui/view/home_screen/home_screen.dart';
import 'package:fliproadmin/ui/view/login_screen/login_screen.dart';
import 'package:fliproadmin/ui/view/middleware_loading/middleware_loading.dart';
import 'package:fliproadmin/ui/widget/getx_dialogs.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

enum loadingState { loaded, loading }

class AuthProvider with ChangeNotifier {
  DbService? dbService;
  AuthProvider() {
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
    final String? fcm = await FirebaseMessaging.instance.getToken();
    GenericModel genericModel = await AuthService.login(email, password,fcm?? '');
    setStateLoaded();

    if (genericModel.statusCode == 200) {
      LoginModel loginModel = genericModel.returnedModel as LoginModel;
      dbService!.writeString(AppConstant.getToken, loginModel.data!.token);
      dbService!.writeAsJson(
          key: AppConstant.getCurrentUser,
          data: loginModel.data!.user!.toJson());
      Navigator.of(Get.context!).pushNamedAndRemoveUntil(
          MiddleWareLoading.routeName, (route) => false);
    } else if (genericModel.statusCode == 401 ||
        genericModel.statusCode == 400) {
      GetXDialog.showDialog(
          title: genericModel.title, message: genericModel.message);
    } else if (genericModel.statusCode == 422) {
      ExceptionModel exceptionModel =
          genericModel.returnedModel as ExceptionModel;
      GetXDialog.showDialog(
          title: exceptionModel.message,
          message: exceptionModel.errors!.errorList != null &&
                  exceptionModel.errors!.errorList!.isNotEmpty
              ? exceptionModel.errors!.errorList![0].message
              : genericModel.message);
      // .showDialog(title: genericModel.title, message: genericModel.message);
    }
  }

  Future forgotPassword(String email) async {
    try {
      setStateLoading();
      GenericModel genericModel = await AuthService.forgotPassword(email);
      if (genericModel.statusCode == 200) {
        Navigator.of(Get.context!).pushNamed(ForgotPasswordOtpScreen.routeName,
            arguments: {"email": email});
      } else if (genericModel.statusCode == 401 ||
          genericModel.statusCode == 400) {
        GetXDialog.showDialog(
            title: genericModel.title, message: genericModel.message);
      } else if (genericModel.statusCode == 422) {
        ExceptionModel exceptionModel =
            genericModel.returnedModel as ExceptionModel;
        GetXDialog.showDialog(
            title: exceptionModel.message,
            message: exceptionModel.errors!.errorList != null &&
                    exceptionModel.errors!.errorList!.isNotEmpty
                ? exceptionModel.errors!.errorList![0].message
                : genericModel.message);
      }
    } finally {
      setStateLoaded();
    }
  }

  Future<bool> forgotPasswordOtpConfirmation(
      {required String email,
      required String otp,
      bool doNavigation = true}) async {
    try {
      setStateLoading();
      GenericModel authSuccessHandler =
          await AuthService.otpConfirmation(email, otp);
      if (authSuccessHandler.statusCode == 200) {
        if (doNavigation) {
          Navigator.of(Get.context!).pushNamed(UpdatePasswordScreen.routeName,
              arguments: {"otp": otp, "email": email});
        }
        return true;
      } else {
        GetXDialog.showDialog(
            title: authSuccessHandler.title,
            message: authSuccessHandler.message);

        return false;
      }
    } finally {
      setStateLoaded();
    }
  }

  Future updatePassword(
      {required String password,
      required String otp,
      required String email}) async {
    try {
      setStateLoading();
      GenericModel authSuccessHandler = await AuthService.updatePassword(
          otp: otp, password: password, email: email);

      GetXDialog.showDialog(
        title: authSuccessHandler.title,
        message: authSuccessHandler.message,
      );
      Future.delayed(const Duration(seconds: 3), () {
        Navigator.of(Get.context!)
            .pushNamedAndRemoveUntil(LoginScreen.routeName, (route) => false);
      });
    } finally {
      setStateLoaded();
    }
  }
}
