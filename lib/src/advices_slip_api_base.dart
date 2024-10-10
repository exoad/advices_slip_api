import 'dart:convert';

import 'package:advices_slip_api/src/shared.dart';
import 'package:http_requests/http_requests.dart';
import 'package:result_dart/result_dart.dart';

/// Represents a single advice from the API wrapped in a standard Dart object.
final class AdviceSlip {
  final int id;
  final String advice;

  /// Constructor for the [AdviceSlip] object.
  ///
  /// [id] The ID of the advice slip.
  ///
  /// [advice] The advice itself.
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
    HttpResponse res = await HttpRequests.get(uri);
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

  static Future<Result<Map<String, dynamic>, Exception>>
      searchAdviceRawFormat(String query) async =>
          fetch(getApiSearchEndpoint(query));

  /// Fetches advice slips from the API with a specific keyword in the advice.
  /// [query] is the keyword to search for.
  ///
  /// [failOnNothingFound] is a boolean that determines if the function should fail if nothing is found.
  ///
  /// [return] A [Result] object with a list of [AdviceSlip] objects if successful, or an [Exception] if failed.
  ///
  /// Example:
  /// ```dart
  /// final advice = await AdviceSlipsApi.findAdvice("love");
  /// if (advice.isSuccess()) {
  ///   print(advice.getOrNull());
  /// } else {
  ///   print(advice.exceptionOrNull());
  /// }
  /// ```
  static Future<Result<List<AdviceSlip>, Exception>> findAdvice(
      String query,
      {bool failOnNothingFound = true}) async {
    HttpResponse res =
        await HttpRequests.get(getApiSearchEndpoint(query));
    if (res.success && res.statusCode == 200) {
      Result<Map<String, dynamic>, Exception> v =
          Result<Map<String, dynamic>, Exception>.success(
              jsonDecode(res.content));
      if (v.isSuccess()) {
        Map<String, dynamic> body = v.getOrNull()!;
        if (body["message"] != null &&
            body["message"]["text"] ==
                kDefaultNothingFoundErrorMessage) {
          return failOnNothingFound
              ? Result<List<AdviceSlip>, Exception>.failure(Exception(
                  "[2] Failed to find an advice slip with a query of $query"))
              : Result<List<AdviceSlip>, Exception>.success(
                  List<AdviceSlip>.empty());
        }
        if (!body.containsKey("slips") ||
            int.parse(body["total_results"]) == 0) {
          return failOnNothingFound
              ? Result<List<AdviceSlip>, Exception>.failure(Exception(
                  "[1] Failed to find anything (internal error)"))
              : Result<List<AdviceSlip>, Exception>.success(
                  List<AdviceSlip>.empty());
        }
        List<AdviceSlip> resultSlips = <AdviceSlip>[];
        for (dynamic slips in body["slips"]) {
          resultSlips.add(
              AdviceSlip(id: slips["id"], advice: slips["advice"]));
        }
        return Result<List<AdviceSlip>, Exception>.success(
            resultSlips);
      }
      return Result<List<AdviceSlip>, Exception>.failure(
          v.exceptionOrNull()!);
    }
    return Result<List<AdviceSlip>, Exception>.failure(Exception(
        "Failed to retrieve AdviceSlip(query=$query) with result: ${res.response}"));
  }

  /// Fetches an advice by its ID from the API.
  ///
  /// [id] The ID of the advice slip.
  ///
  /// [return] A [Result] object with the [AdviceSlip] object if successful, or an [Exception] if failed.
  ///
  /// Example:
  /// ```dart
  /// final advice = await AdviceSlipsApi.getAdviceById(42);
  /// if (advice.isSuccess()) {
  ///   print(advice.getOrNull());
  /// } else {
  ///   print(advice.exceptionOrNull());
  /// }
  /// ```
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
        if (body["message"] != null) {
          return Result<AdviceSlip, Exception>.failure(Exception(
              "[2] Failed to find AdviceSlip(id=$id) because\"${body["message"]["text"]}\""));
        }
        if (body["slip"] == null) {
          return Result<AdviceSlip, Exception>.failure(Exception(
              "[1] Failed to find AdviceSlip(id=$id) with result: ${res.response}"));
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

  /// Fetches a random advice slip from the API.
  ///
  /// [return] A [Result] object with the [AdviceSlip] object if successful, or an [Exception] if failed.
  ///
  /// Example:
  /// ```dart
  /// final advice = await AdviceSlipsApi.randomAdvice();
  /// if (advice.isSuccess()) {
  ///   print(advice.getOrNull());
  /// } else {
  ///   print(advice.exceptionOrNull());
  /// }
  /// ```
  static Future<Result<AdviceSlip, Exception>> randomAdvice() async {
    HttpResponse res = await HttpRequests.get(getApiRandomEndpoint());
    if (res.success && res.statusCode == 200) {
      Result<Map<String, dynamic>, Exception> v =
          Result<Map<String, dynamic>, Exception>.success(
              jsonDecode(res.content));
      if (v.isSuccess()) {
        Map<String, dynamic> body = v.getOrNull()!;
        if (body["message"] != null) {
          return Result<AdviceSlip, Exception>.failure(Exception(
              "[2] Failed to retrieve AdviceSlip with result: ${body["message"]}"));
        }
        if (body["slip"] == null) {
          return Result<AdviceSlip, Exception>.failure(Exception(
              "[1] Failed to retrieve AdviceSlip with result: ${res.response}"));
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
