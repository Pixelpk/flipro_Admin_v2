import 'dart:async';
import 'dart:convert';
import 'dart:ffi';
import 'dart:io';

import 'package:fliproadmin/core/model/exception_model/exception_model.dart';
import 'package:fliproadmin/core/model/generic_model/generic_model.dart';
import 'package:fliproadmin/core/model/project_response/project_response.dart';
import 'package:fliproadmin/core/model/registration_model/registration_model.dart';
import 'package:fliproadmin/core/model/user_model/user_model.dart';
import 'package:fliproadmin/core/model/user_role_response/user_role_response.dart';
import 'package:fliproadmin/core/model/users_model/users_model.dart';
import 'package:fliproadmin/core/utilities/app_colors.dart';
import 'package:fliproadmin/core/utilities/app_constant.dart';
import 'package:fliproadmin/core/utilities/env.dart';
import 'package:fliproadmin/core/utilities/logic_helper.dart';
import 'package:http/http.dart' as http;

class UsersService {
  static Future<GenericModel> updateProfile({
    required String token,
    required User user,
    File? pickedAvatar,
  }) async {
    try {
      var headers = {
        'Accept': 'application/json',
        'Authorization': "Bearer $token"
      };
      var request = http.MultipartRequest(
          'POST', Uri.parse('${ENV.baseURL}/api/profile?_method=patch'));
      request.fields.addAll({
        'name': user.name!,
        'phone_code': user.phoneCode!,
        'phone': user.phone!,
        'address': user.address!,
      });
      if (pickedAvatar != null) {
        request.files.add(
            await http.MultipartFile.fromPath('avatar', pickedAvatar.path));
      }
      request.headers.addAll(headers);
      print(request.files.length);
      http.StreamedResponse response = await request.send();
      var res = await response.stream.bytesToString();
      print(res);
      if (response.statusCode == 200) {
        return GenericModel(
          success: true,
          statusCode: response.statusCode,
          title: "Profile updated",
          message: "",
          returnedModel: User.fromJson(jsonDecode(res)['data']),
        );
      } else if (response.statusCode == 422) {
        ExceptionModel exceptionModel =
            ExceptionModel.fromJson(jsonDecode(res));
        return GenericModel(
            success: false,
            returnedModel: null,
            message: exceptionModel.errors!.errorList![0].message,
            title: exceptionModel.message);
      } else if (response.statusCode == 401) {
        LogicHelper.unauthorizedHandler();
        return GenericModel(
            success: false,
            returnedModel: null,
            message: "Session Expired",
            title: "Please Login again");
      } else {
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

  static Future<GenericModel> updatePassword(
      {required String currentPass,
      required String newPass,
      required String token}) async {
    try {
      var headers = {
        'Accept': 'application/json',
        'Authorization': "Bearer $token"
      };

      var request = http.Request('PATCH', Uri.parse('${ENV.baseURL}/api/password?password=$newPass&current_password=$currentPass'));

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      var res = await response.stream.bytesToString();
      print(res);
      if (response.statusCode == 200) {
        return GenericModel(
            success: true,
            returnedModel: null,
            title: "Password Updated",
            message: "Password Updated Successfully");
      } else if (response.statusCode == 422) {
        ExceptionModel exceptionModel =
            ExceptionModel.fromJson(jsonDecode(res));
        return GenericModel(
            success: false,
            returnedModel: null,
            message: exceptionModel.errors!.errorList![0].message,
            title: exceptionModel.message);
      } else if (response.statusCode == 401) {
        LogicHelper.unauthorizedHandler();
        return GenericModel(
            success: false,
            returnedModel: null,
            message: "Session Expired",
            title: "Please Login again");
      } else {
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

  static Future<GenericModel> logout({
    required String token,
  }) async {
    try {
      var headers = {
        'Accept': 'application/json',
        'Authorization': "Bearer $token"
      };

      var request = http.MultipartRequest(
          'POST', Uri.parse('${ENV.baseURL}/api/logout'));
      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();
      var res = await response.stream.bytesToString();
      print(res);
      if (response.statusCode == 200) {
        return GenericModel(
          success: true,
          returnedModel: null,
        );
      } else if (response.statusCode == 422) {
        ExceptionModel exceptionModel =
            ExceptionModel.fromJson(jsonDecode(res));
        return GenericModel(
            success: false,
            returnedModel: null,
            message: exceptionModel.errors!.errorList![0].message,
            title: exceptionModel.message);
      } else if (response.statusCode == 401) {
        LogicHelper.unauthorizedHandler();
        return GenericModel(
            success: false,
            returnedModel: null,
            message: "Session Expired",
            title: "Please Login again");
      } else {
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

  static Future<GenericModel> getUsers(
      {required String token, required int page, required String type}) async {
    try {
      print("AUTH TOKEN $token $type");
      var headers = {
        'Accept': 'application/json',
        'Authorization': "Bearer $token"
      };
      var request = http.Request('GET',
          Uri.parse('${ENV.baseURL}/api/users?filters[type]=$type&page=$page'));
      print("flipro.anasw.com/api/users?filters[type]=$type&page=$page");
      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();
      var res = await response.stream.bytesToString();
      print(res);
      if (response.statusCode == 200) {
        UsersModel usersModel = UsersModel.fromJson(jsonDecode(res));
        return GenericModel(
            returnedModel: usersModel,
            success: true,
            statusCode: response.statusCode);
      } else if (response.statusCode == 401) {
        LogicHelper.unauthorizedHandler(showMessage: true);
        return GenericModel(
            returnedModel: null,
            success: false,
            statusCode: response.statusCode);
      } else {
        ///TODO
        print(response.reasonPhrase);
        return GenericModel(
            returnedModel: null,
            success: false,
            statusCode: response.statusCode);
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
          'POST', Uri.parse('${ENV.baseURL}/api/users'));
      request.fields.addAll(registratingData.toJson());
      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();
      var res = await response.stream.bytesToString();
      print(res);
      if (response.statusCode == 200) {
        UserRoleModel usersModel =
            UserRoleModel.fromJson(jsonDecode(res)['data']);
        print("sdsddsdsd${usersModel.toJson()}");
        return GenericModel(
          success: true,
          returnedModel: usersModel,
          message:
              "${registratingData.name} will received e-mail containing login credentials",
          title: "${registratingData.name!.toUpperCase()}'s account Created",
        );
      } else if (response.statusCode == 422) {
        ExceptionModel exceptionModel =
            ExceptionModel.fromJson(jsonDecode(res));
        return GenericModel(
            success: false,
            returnedModel: null,
            message: exceptionModel.errors!.errorList![0].message,
            title: exceptionModel.message);
      } else if (response.statusCode == 401) {
        LogicHelper.unauthorizedHandler();
        return GenericModel(
            success: false,
            returnedModel: null,
            message: "Session Expired",
            title: "Please Login again");
      } else {
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

  Future<GenericModel> getUserRoles(
      {required String accessToken,
      required int page,
      required role,
      int? projectId,
      String? searchQuery}) async {
    try {
      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $accessToken'
      };
      String url = "${ENV.baseURL}/api/users?filters[type]=$role&page=$page";

      ///ROLES
      ///builder
      ///homeowner
      ///
      if (projectId != null) {
        url = "$url&filters[assignable]=$projectId";
      }
      if (searchQuery != null) {
        url = "$url&filters[search]=$searchQuery";
      }
      var request = http.Request('GET', Uri.parse(url));
      request.headers.addAll(headers);

      http.StreamedResponse response =
          await request.send().timeout(const Duration(seconds: 30));
      var res = await response.stream.bytesToString();
      print("REQUEST URL $url");
      print(res);
      if (response.statusCode == 200) {
        return GenericModel(
            returnedModel: UserRoleResponse.fromJson(jsonDecode(res)),
            success: true,
            statusCode: 200);
      } else if (response.statusCode == 422) {
        ExceptionModel exceptionModel =
            ExceptionModel.fromJson(jsonDecode(res));
        return GenericModel(
            returnedModel: exceptionModel,
            success: false,
            statusCode: 422,
            message: AppConstant.genericErrorDescription);
      } else if (response.statusCode == 401) {
        LogicHelper.unauthorizedHandler();
        return GenericModel(
            returnedModel: null,
            success: false,
            statusCode: 401,
            message: AppConstant.sessionDescription,
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
    }
  }
}
