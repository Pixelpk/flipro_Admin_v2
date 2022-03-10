import 'package:fliproadmin/core/model/user_model/user_model.dart';
import 'package:fliproadmin/core/services/db_service/db_service.dart';
import 'package:fliproadmin/core/utilities/app_constant.dart';
import 'package:flutter/cupertino.dart';

class UserProvider with ChangeNotifier{
  User? _user ;
  String? _authToken ;
  DbService? _dbService ;
  String get getAuthToken =>_authToken! ;
  User get getCurrentUser => _user!;

  UserProvider(){
    _dbService = DbService();
    var userjson = _dbService!.readJson(AppConstant.getCurrentUser);
   String token = _dbService!.readString(AppConstant.getToken) ??'null';
    print(" TOKEN $token");
    print("INITIALING USER");
    print(userjson);
   if(userjson!=null )
     { _authToken = token;
     _user = User.fromJson(userjson);
       notifyListeners();
     }

  }
}