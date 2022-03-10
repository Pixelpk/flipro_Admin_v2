import 'package:fliproadmin/core/model/exception_model/exception_model.dart';
import 'package:fliproadmin/core/model/generic_model/generic_model.dart';
import 'package:fliproadmin/core/model/registration_model/registration_model.dart';
import 'package:fliproadmin/core/model/users_model/users_model.dart';
import 'package:fliproadmin/core/services/users_service/user_service.dart';
import 'package:fliproadmin/core/view_model/auth_provider/auth_provider.dart';
import 'package:fliproadmin/ui/widget/getx_dialogs.dart';
import 'package:flutter/cupertino.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class UsersProvider with ChangeNotifier {
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

  Future addMember(
      {required RegistratingData registratingData,
      required String token}) async {
    print("CALLING");
    GenericModel genericModel = await UsersService.addUser(
        token: token, registratingData: registratingData);
    if (genericModel.success) {
      GetXDialog().showDialog(
        message: genericModel.message,
        title: genericModel.title,
      );
    } else {
      GetXDialog()
          .showDialog(title: genericModel.title, message: genericModel.message);
    }
  }
}
