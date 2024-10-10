import 'package:advices_slip_api/advices_slip_api.dart';
import 'package:result_dart/result_dart.dart';
import 'package:test/test.dart';

void main() {
  group("Generic Sanity", () {
    test("AdviceSlipsApi::isApiUp sanity", () async {
      bool isApiUp = await AdviceSlipsApi.isApiUp;
      expect(isApiUp, equals(true));
    });
  });
  group("RandomAdvice", () {
    test("AdviceSlipsApi::randomAdviceRawFormat sanity", () async {
      Result<Map<String, dynamic>, Exception> rawFormat =
          await AdviceSlipsApi.randomAdviceRawFormat();
      expect(rawFormat.isSuccess(), equals(true));
    });
    test("AdviceSlipsApi::randomAdviceRawFormat hasValidFormat",
        () async {
      Result<Map<String, dynamic>, Exception> rawFormat =
          await AdviceSlipsApi.randomAdviceRawFormat();
      expect(rawFormat.isSuccess(), equals(true));
      expect(rawFormat.getOrNull()?.keys, <String>["slip"]);
    });
    test("AdviceSlipsApi::randomAdviceRawFormat hasSlips attribute",
        () async {
      Result<Map<String, dynamic>, Exception> rawFormat =
          await AdviceSlipsApi.randomAdviceRawFormat();
      expect(rawFormat.isSuccess(), equals(true));
      expect(rawFormat.getOrNull()?["slip"], isNotNull);
    });
    test("AdviceSlipsApi::randomAdviceRawFormat hasSlipsId attribute",
        () async {
      Result<Map<String, dynamic>, Exception> rawFormat =
          await AdviceSlipsApi.randomAdviceRawFormat();
      expect(rawFormat.isSuccess(), equals(true));
      expect(rawFormat.getOrNull()?["slip"]["id"], isNotNull);
    });
    test(
        "AdviceSlipsApi::randomAdviceRawFormat hasValidIntSlipsId attribute",
        () async {
      Result<Map<String, dynamic>, Exception> rawFormat =
          await AdviceSlipsApi.randomAdviceRawFormat();
      expect(rawFormat.isSuccess(), equals(true));
      expect(rawFormat.getOrNull()?["slip"]["id"], isA<int>());
    });
    test(
        "AdviceSlipsApi::randomAdviceRawFormat hasSlipsAdvice attribute",
        () async {
      Result<Map<String, dynamic>, Exception> rawFormat =
          await AdviceSlipsApi.randomAdviceRawFormat();
      expect(rawFormat.isSuccess(), equals(true));
      expect(rawFormat.getOrNull()?["slip"]["advice"], isNotNull);
    });
    test(
        "AdviceSlipsApi::randomAdviceRawFormat hasValidSlipsAdvice attribute",
        () async {
      Result<Map<String, dynamic>, Exception> rawFormat =
          await AdviceSlipsApi.randomAdviceRawFormat();
      expect(rawFormat.isSuccess(), equals(true));
      expect(rawFormat.getOrNull()?["slip"]["advice"], isNotNull);
      expect(rawFormat.getOrNull()?["slip"]["advice"], isA<String>());
      expect(rawFormat.getOrNull()?["slip"]["advice"].length,
          greaterThan(0));
    });
    test("AdviceSlipsApi::randomAdvice sanity", () async {
      Result<AdviceSlip, Exception> advice =
          await AdviceSlipsApi.randomAdvice();
      expect(advice.isSuccess(), equals(true));
    });
  });
}
