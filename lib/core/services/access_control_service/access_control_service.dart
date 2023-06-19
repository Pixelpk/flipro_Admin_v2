import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:fliproadmin/core/model/exception_model/exception_model.dart';
import 'package:fliproadmin/core/model/generic_model/generic_model.dart';
import 'package:fliproadmin/core/model/project_response/project_response.dart';
import 'package:fliproadmin/core/model/project_roles/project_roles.dart';
import 'package:fliproadmin/core/utilities/app_constant.dart';
import 'package:fliproadmin/core/utilities/env.dart';
import 'package:fliproadmin/core/utilities/logic_helper.dart';
import 'package:http/http.dart' as http;

class AccessControlService {
  Future<GenericModel> updateAccess(
      {required int projectId, required ProjectRoles projectRoles, required String token, required int userId}) async {
    try {
      var headers = {
        'Accept': 'application/json',
        'Authorization': "Bearer $token",
      };

      print('THIS IS THE URL::: ${ENV.baseURL}/api/accesses?project_id=$projectId&user_id=$userId&roles=${projectRoles.toJson()}');

      var response = await http.post(
            Uri.parse('${ENV.baseURL}/api/accesses?project_id=$projectId&user_id=$userId&roles=${projectRoles.toJson()}'),
            headers: headers,
          )
          .timeout(const Duration(seconds: 30));
      print(response.statusCode);

      if (response.statusCode == 200) {
        return GenericModel(
            returnedModel: Project.fromJson(jsonDecode(response.body)['data']),
            success: true,
            statusCode: response.statusCode,
            message: "Project will be available in new Projects",
            title: "Project Assigned");
      } else if (response.statusCode == 422) {
        ExceptionModel exceptionModel = ExceptionModel.fromJson(jsonDecode(response.body));
        return GenericModel(
            returnedModel: exceptionModel,
            success: false,
            statusCode: 422,
            title: exceptionModel.errors!.errorList![0].error,
            message: exceptionModel.errors!.errorList![0].message);
      } else if (response.statusCode == 401) {
        LogicHelper.unauthorizedHandler();
        return GenericModel(
            success: false,
            statusCode: response.statusCode,
            title: "Session Expired",
            message: "Please login again",
            returnedModel: null);
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
          statusCode: 400,
          message: AppConstant.networkError,
          title: AppConstant.networkErrorDescritpion);
    } on TimeoutException catch (_) {
      return GenericModel(
          returnedModel: null,
          success: false,
          statusCode: 400,
          message: AppConstant.timeoutError,
          title: AppConstant.timeoutErrorDescription);
    } catch (e) {
      print("$e LOGIN AUTH");
      return GenericModel(
          returnedModel: null,
          success: false,
          statusCode: 400,
          message: AppConstant.genericError,
          title: AppConstant.genericErrorDescription);
    }
  }
}
