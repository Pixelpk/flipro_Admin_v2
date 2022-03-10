import 'dart:async';
import 'dart:convert';
import 'dart:ffi';
import 'dart:io';

import 'package:fliproadmin/core/model/exception_model/exception_model.dart';
import 'package:fliproadmin/core/model/generic_model/generic_model.dart';
import 'package:fliproadmin/core/model/registration_model/registration_model.dart';
import 'package:fliproadmin/core/model/users_model/users_model.dart';
import 'package:fliproadmin/core/utilities/app_colors.dart';
import 'package:fliproadmin/core/utilities/app_constant.dart';
import 'package:fliproadmin/core/utilities/logic_helper.dart';
import 'package:http/http.dart' as http;

class UsersService {
  static Future<List<Member>> getUsers(
      {required String token, required int page, required String type}) async {
    print("AUTH TOKEN $token $type");
    var headers = {
      'Accept': 'application/json',
      'Authorization':
          "Bearer $token" //'Bearer 17|eOHvmIaVstztJRPkBLM1xsw5XURqnx2Z6ctWxtz1'
    };
    var request = http.Request(
        'GET',
        Uri.parse(
            'http://flipro.anasw.com/api/users?filters[type]=$type&page=$page'));
print("flipro.anasw.com/api/users?filters[type]=$type&page=$page");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    var res = await response.stream.bytesToString();
    print(res);
    if (response.statusCode == 200) {
      UsersModel usersModel = UsersModel.fromJson(jsonDecode(res));
      return usersModel.data!.users;
    } else {
      ///TODO
      print(response.reasonPhrase);
      return [];
    }
  }

  static Future<GenericModel> addUser(
      {required String token,
      required RegistratingData registratingData}) async {
    try {
      var headers = {
        'Accept': 'application/json',
        'Authorization':
            "Bearer $token" //'Bearer 17|eOHvmIaVstztJRPkBLM1xsw5XURqnx2Z6ctWxtz1'
      };

      var request = http.MultipartRequest(
          'POST', Uri.parse('${AppConstant.baseUrl}api/users'));
      request.fields.addAll(registratingData.toJson());
      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();
      var res = await response.stream.bytesToString();
      print(res);
      if (response.statusCode == 200) {
        UsersModel usersModel = UsersModel.fromJson(jsonDecode(res));
        return GenericModel(
            success: true,
            returnedModel: usersModel,
            message:
                "${registratingData.userType!.toUpperCase()} has been successfully added",
            title: 'Success');
      } else if (response.statusCode == 422) {
        ExceptionModel exceptionModel =
            ExceptionModel.fromJson(jsonDecode(res));
        return GenericModel(
            success: false,
            returnedModel: null,
            message: exceptionModel.errors!.errorList![0].message,
            title: exceptionModel.message);
      } else {
        ///TODO
        print(response.reasonPhrase);
        return GenericModel(
            success: false,
            title: AppConstant.genericError,
            message: AppConstant.genericErrorDescription,
            returnedModel: null);
      }
    } on SocketException {
      return GenericModel(
          returnedModel: null,
          success: false,
          message: AppConstant.networkError,
          title: AppConstant.networkErrorDescritpion);
    } on TimeoutException catch (_) {
      return GenericModel(
          returnedModel: null,
          success: false,
          message: AppConstant.timeoutError,
          title: AppConstant.timeoutErrorDescription);
    } catch (e) {
      print("$e LOGIN AUTH");
      return GenericModel(
          returnedModel: null,
          success: false,
          message: AppConstant.genericError,
          title: AppConstant.genericErrorDescription);
    }
  }
}
