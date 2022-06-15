import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:fliproadmin/core/model/exception_model/exception_model.dart';
import 'package:fliproadmin/core/model/generic_model/generic_model.dart';
import 'package:fliproadmin/core/model/note_model/note_model.dart';
import 'package:fliproadmin/core/model/payment_response/payment_response.dart';
import 'package:fliproadmin/core/utilities/app_constant.dart';
import 'package:fliproadmin/core/utilities/env.dart';
import 'package:fliproadmin/core/utilities/logic_helper.dart';
import 'package:http/http.dart' as http;

class NotesService {
  static Future<GenericModel> getAllPrjectNotes({
    required String accessToken,
    required int page,
    required int? projectId,
  }) async {
    try {
      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $accessToken'
      };
      String url = '${ENV.baseURL}/api/notes?project_id=$projectId&page=$page';
      var request = http.Request('GET', Uri.parse(url));
      request.headers.addAll(headers);

      http.StreamedResponse response =
          await request.send().timeout(const Duration(seconds: 30));
      var res = await response.stream.bytesToString();
      print(res);
      if (response.statusCode == 200) {
        return GenericModel(
            returnedModel: NotesResponse.fromJson(jsonDecode(res)),
            success: true,
            statusCode: 200);
      } else if (response.statusCode == 422) {
        ExceptionModel exceptionModel =
            ExceptionModel.fromJson(jsonDecode(res));
        return GenericModel(
            returnedModel: exceptionModel,
            success: false,
            statusCode: 422,
            title: exceptionModel.errors!.errorList![0].error,
            message: exceptionModel.message);
      } else if (response.statusCode == 401) {
        LogicHelper.unauthorizedHandler();
        return GenericModel(
            returnedModel: null,
            success: false,
            statusCode: 401,
            message: AppConstant.sessionDescription,
            title: AppConstant.sessionTitle);
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

  static Future<GenericModel> createNote(
      {required String accessToken, required Note? note}) async {
    try {
      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $accessToken'
      };
      String url =
          '${ENV.baseURL}/api/notes?project_id=${note!.projectId}&notes=${note.notes}&private=${note.private == true ? 1 : 0}';
      print(url);
      var request = http.Request('POST', Uri.parse(url));
      request.headers.addAll(headers);

      http.StreamedResponse response =
          await request.send().timeout(const Duration(seconds: 30));
      var res = await response.stream.bytesToString();
      print(res);
      if (response.statusCode == 200) {
        return GenericModel(title: "Note Created",
            message: "Note Created Successfully",
            returnedModel: null, success: true, statusCode: 200);
      } else if (response.statusCode == 422) {
        ExceptionModel exceptionModel =
            ExceptionModel.fromJson(jsonDecode(res));
        return GenericModel(
            returnedModel: exceptionModel,
            success: false,
            statusCode: 422,
            title: exceptionModel.errors!.errorList![0].error,
            message: exceptionModel.message);
      } else if (response.statusCode == 401) {
        LogicHelper.unauthorizedHandler();
        return GenericModel(
            returnedModel: null,
            success: false,
            statusCode: 401,
            message: AppConstant.sessionDescription,
            title: AppConstant.sessionTitle);
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
  static Future<GenericModel> updateNote(
      {required String accessToken, required Note? note}) async {
    try {
      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $accessToken'
      };
      String url =
          '${ENV.baseURL}/api/notes?id=${note!.id}&notes=${note.notes}&private=${note.private == true ? 1 : 0}';
      print(url);
      var request = http.Request('PATCH', Uri.parse(url));
      request.headers.addAll(headers);
      http.StreamedResponse response =
      await request.send().timeout(const Duration(seconds: 30));
      var res = await response.stream.bytesToString();
      print(res);
      if (response.statusCode == 200) {
        return GenericModel(
          title: "Note Edited",
            message: "Note Edited Successfully",
            returnedModel: null, success: true, statusCode: 200);
      } else if (response.statusCode == 422) {
        ExceptionModel exceptionModel =
        ExceptionModel.fromJson(jsonDecode(res));
        return GenericModel(
            returnedModel: exceptionModel,
            success: false,
            statusCode: 422,
            title: exceptionModel.errors!.errorList![0].error,
            message: exceptionModel.message);
      } else if (response.statusCode == 401) {
        LogicHelper.unauthorizedHandler();
        return GenericModel(
            returnedModel: null,
            success: false,
            statusCode: 401,
            message: AppConstant.sessionDescription,
            title: AppConstant.sessionTitle);
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
  static Future<GenericModel> deleteNote(
      {required String accessToken, required int? nodeId}) async {
    try {
      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $accessToken'
      };
      String url =
          '${ENV.baseURL}/api/notes?id=$nodeId';
      print(url);
      var request = http.Request('DELETE', Uri.parse(url));
      request.headers.addAll(headers);

      http.StreamedResponse response =
      await request.send().timeout(const Duration(seconds: 30));
      var res = await response.stream.bytesToString();
      print(res);
      if (response.statusCode == 200) {
        return GenericModel( title: "Note Deleted",
            message: "Note Deleted Successfully",
            returnedModel: null, success: true, statusCode: 200);
      } else if (response.statusCode == 422) {
        ExceptionModel exceptionModel =
        ExceptionModel.fromJson(jsonDecode(res));
        return GenericModel(
            returnedModel: exceptionModel,
            success: false,
            statusCode: 422,
            title: exceptionModel.errors!.errorList![0].error,
            message: exceptionModel.message);
      } else if (response.statusCode == 401) {
        LogicHelper.unauthorizedHandler();
        return GenericModel(
            returnedModel: null,
            success: false,
            statusCode: 401,
            message: AppConstant.sessionDescription,
            title: AppConstant.sessionTitle);
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
