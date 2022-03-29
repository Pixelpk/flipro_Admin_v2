import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:fliproadmin/core/model/exception_model/exception_model.dart';
import 'package:fliproadmin/core/model/generic_model/generic_model.dart';
import 'package:fliproadmin/core/model/payment_response/payment_response.dart';
import 'package:fliproadmin/core/utilities/app_constant.dart';
import 'package:fliproadmin/core/utilities/env.dart';
import 'package:fliproadmin/core/utilities/logic_helper.dart';
import 'package:http/http.dart' as http;

class PaymentService {
  static Future<GenericModel> getAllPayments(
      {required String accessToken,
      required int page,
      required bool fetchPending,
      required bool fetchapproved,
      required bool fetchRejected}) async {
    try {
      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $accessToken'
      };
      String url = '${ENV.baseURL}/api/payment-requests?page=$page';
      if (fetchPending) {
        url = "$url&filters[status]=pending";
      }
      if (fetchapproved) {
        url = "$url&filters[status]=approved";
      }
      if (fetchRejected) {
        url = "$url&filters[status]=rejected";
      }
      print("REQ URL $url");
      var request = http.Request('GET', Uri.parse(url));
      request.headers.addAll(headers);

      http.StreamedResponse response =
          await request.send().timeout(const Duration(seconds: 30));
      var res = await response.stream.bytesToString();
      print(res);
      if (response.statusCode == 200) {
        return GenericModel(
            returnedModel: PaymentResponse.fromJson(jsonDecode(res)),
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

  static Future<GenericModel> approveRejectPaymentReq(
      {required String accessToken,
      required int paymentReqId,
      required String? rejectionReason,
      required bool isRejected}) async {
    try {
      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $accessToken'
      };
      String url = '${ENV.baseURL}/api/payment-requests?id=$paymentReqId';
      if (isRejected) {
        url = "$url&status=rejected";
      }
      if (!isRejected) {
        url = "$url&status=approved";
      }
      print("REQ URL $url");
      var request = http.Request('PATCH', Uri.parse(url));
      request.headers.addAll(headers);

      http.StreamedResponse response =
          await request.send().timeout(const Duration(seconds: 30));
      var res = await response.stream.bytesToString();
      print(res);
      if (response.statusCode == 200) {
        return GenericModel(
            returnedModel: null,
            title: isRejected ? "Payment Rejected" : "Payment Approved",
            message: isRejected
                ? "Payment Request Rejected"
                : "Payment Request has been approved",
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
}
