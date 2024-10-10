import 'dart:convert';

import 'package:advices_slip_api/src/shared.dart';
import 'package:http_requests/http_requests.dart';
import 'package:result_dart/result_dart.dart';

/// Represents a single advice from the API wrapped in a standard Dart object.
final class AdviceSlip {
  final int id;
  final String advice;

  AdviceSlip({required this.id, required this.advice});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    return other is AdviceSlip &&
        other.id == id &&
        other.advice == advice;
  }

  @override
  String toString() => "AdviceSlip[id: $id, advice: $advice]";
}

final class AdviceSlipsApi {
  AdviceSlipsApi._();

  static Future<Result<Map<String, dynamic>, Exception>> fetch(
      String uri) async {
    HttpResponse res = await HttpRequests.get(getApiRandomEndpoint());
    if (res.success && res.statusCode == 200) {
      return Result<Map<String, dynamic>, Exception>.success(
          jsonDecode(res.content));
    }
    return Result<Map<String, dynamic>, Exception>.failure(Exception(
        "Failed to retrieve JSON body with result: ${res.response}"));
  }

  static Future<Result<Map<String, dynamic>, Exception>>
      randomAdviceRawFormat() async => fetch(getApiRandomEndpoint());

  static Future<Result<Map<String, dynamic>, Exception>>
      getAdviceByIDRawFormat(int id) async =>
          fetch(getApiSearchIDEndpoint(id));

  static Future<Result<AdviceSlip, Exception>> getAdviceById(
      int id) async {
    HttpResponse res =
        await HttpRequests.get(getApiSearchIDEndpoint(id));
    if (res.success && res.statusCode == 200) {
      Result<Map<String, dynamic>, Exception> v =
          Result<Map<String, dynamic>, Exception>.success(
              jsonDecode(res.content));
      if (v.isSuccess()) {
        Map<String, dynamic> body = v.getOrNull()!;
        if (body["slip"] == null) {
          return Result<AdviceSlip, Exception>.failure(Exception(
              "[1] Failed to retrieve AdviceSlip(id=$id) with result: ${res.response}"));
        } else if (body["message"] != null) {
          return Result<AdviceSlip, Exception>.failure(Exception(
              "[2] Failed to find AdviceSlip(id=$id) because\"${body["message"].text}\""));
        }
        return Result<AdviceSlip, Exception>.success(AdviceSlip(
            id: body["slip"]["id"], advice: body["slip"]["advice"]));
      }
      return Result<AdviceSlip, Exception>.failure(
          v.exceptionOrNull()!);
    }
    return Result<AdviceSlip, Exception>.failure(Exception(
        "Failed to retrieve AdviceSlip(id=$id) with result: ${res.response}"));
  }

  static Future<Result<AdviceSlip, Exception>> randomAdvice() async {
    HttpResponse res = await HttpRequests.get(getApiRandomEndpoint());
    if (res.success && res.statusCode == 200) {
      Result<Map<String, dynamic>, Exception> v =
          Result<Map<String, dynamic>, Exception>.success(
              jsonDecode(res.content));
      if (v.isSuccess()) {
        Map<String, dynamic> body = v.getOrNull()!;
        if (body["slip"] == null) {
          return Result<AdviceSlip, Exception>.failure(Exception(
              "[1] Failed to retrieve AdviceSlip with result: ${res.response}"));
        } else if (body["message"] != null) {
          return Result<AdviceSlip, Exception>.failure(Exception(
              "[2] Failed to retrieve AdviceSlip with result: ${body["message"]}"));
        }
        return Result<AdviceSlip, Exception>.success(AdviceSlip(
            id: body["slip"]["id"], advice: body["slip"]["advice"]));
      }
      return Result<AdviceSlip, Exception>.failure(
          v.exceptionOrNull()!);
    }
    return Result<AdviceSlip, Exception>.failure(Exception(
        "Failed to retrieve AdviceSlip with result: ${res.response}"));
  }

  static Future<bool> get isApiUp async =>
      (await HttpRequests.get(getApiRandomEndpoint())).success;
}
