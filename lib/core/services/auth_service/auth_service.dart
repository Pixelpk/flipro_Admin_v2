import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:fliproadmin/core/model/exception_model/exception_model.dart';
import 'package:fliproadmin/core/model/generic_model/generic_model.dart';
import 'package:fliproadmin/core/model/login_model/login_model.dart';
import 'package:fliproadmin/core/utilities/app_constant.dart';
import 'package:http/http.dart' as http;

class AuthService {
  static Future<GenericModel> login(String email, String password) async {
    try {
      var headers = {'Accept': 'application/json'};

      var request = http.MultipartRequest(
          'POST', Uri.parse('${AppConstant.baseUrl}api/authenticate'));
      request.fields.addAll({"email": email, "password": password});
      request.headers.addAll(headers);

      http.StreamedResponse response =
          await request.send().timeout(const Duration(seconds: 30));
      var res = await response.stream.bytesToString();
      print(res);
      if (response.statusCode == 200) {
        LoginModel loginModel = LoginModel.fromJson(jsonDecode(res));
        return GenericModel(
            returnedModel: loginModel, success: true, statusCode: 200);
      } else if (response.statusCode == 422) {
        ExceptionModel exceptionModel =
            ExceptionModel.fromJson(jsonDecode(res));
        return GenericModel(
            returnedModel: exceptionModel,
            success: false,
            statusCode: 422,
            message: AppConstant.genericErrorDescription);
      } else if (response.statusCode == 401) {
        return GenericModel(
            returnedModel: null,
            success: false,
            statusCode: 401,
            message: AppConstant.invalidCreds,
            title: "Invalid Credentials");
      } else {
        return GenericModel(
            returnedModel: null,
            success: false,
            message: AppConstant.genericError,
            title: AppConstant.genericErrorDescription);
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
