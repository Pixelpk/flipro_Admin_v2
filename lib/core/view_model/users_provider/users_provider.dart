import 'package:fliproadmin/core/model/generic_model/generic_model.dart';
import 'package:fliproadmin/core/model/project_response/project_response.dart';
import 'package:fliproadmin/core/model/registration_model/registration_model.dart';
import 'package:fliproadmin/core/services/users_service/user_service.dart';
import 'package:fliproadmin/core/utilities/logic_helper.dart';
import 'package:fliproadmin/core/view_model/auth_provider/auth_provider.dart';
import 'package:fliproadmin/ui/widget/getx_dialogs.dart';
import 'package:fliproadmin/ui/widget/helper_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class UsersProvider extends ChangeNotifier {
  String? _authToken;

  UsersProvider(String? authToken) {
    _authToken = authToken;
  }

  LoadingState _isLoading = LoadingState.loaded;

  LoadingState get getLoadingState => _isLoading;

  setStateLoading() {
    _isLoading = LoadingState.loading;
    notifyListeners();
  }

  setStateLoaded() {
    _isLoading = LoadingState.loaded;
    notifyListeners();
  }

  Future<bool> addMember({
    required RegistratingData registratingData,
    required bool createAssign,
    required appUsers appuser,
    required String? currentRoute,
  }) async {
    try {
      ///Create user & if createAssign is true then also handle project assignment
      if (_authToken != null) {
        setStateLoading();
        GenericModel genericModel = await UsersService.addUser(
          token: _authToken!,
          registratingData: registratingData,
        );

        if (genericModel.success) {
          GetXDialog.showDialog(
            message: genericModel.message,
            title: genericModel.title,
          );

          ///IF CREATEASSIGN IS TRUE THEN WE"LL HAVE TO ASSIGN THIS CREATED USER TO PARTICULAR PROJECT ;
          if (createAssign) {
            UserRoleModel userRoleModel = genericModel.returnedModel;
            HelperWidget.handleTrademanNavigation(
                user: appuser,
                context: Get.context!,
                userRoleModel: genericModel.returnedModel,
                currentRoute: currentRoute);
          }
          if (!createAssign) {
            Navigator.pop(Get.context!);
          }
          return genericModel.success;
        } else {
          GetXDialog.showDialog(title: genericModel.title, message: genericModel.message);
          return genericModel.success;
        }
      } else {
        LogicHelper.unauthorizedHandler();
        return false;
      }
    } finally {
      setStateLoaded();
    }
  }
}
