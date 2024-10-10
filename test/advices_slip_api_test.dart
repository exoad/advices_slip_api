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
  group("AdviceByID", () {
    test("AdviceSlipsApi::getAdviceByIDRawFormat sanity", () async {
      Result<Map<String, dynamic>, Exception> rawFormat =
          await AdviceSlipsApi.getAdviceByIDRawFormat(1);
      expect(rawFormat.isSuccess(), equals(true));
    });
    int idsToTest = 5;
    for (int i = 1; i <= idsToTest; i++) {
      test(
          "AdviceSlipsApi::getAdviceByIDRawFormat hasValidFormat for ID: $i",
          () async {
        Result<Map<String, dynamic>, Exception> rawFormat =
            await AdviceSlipsApi.getAdviceByIDRawFormat(i);
        expect(rawFormat.isSuccess(), equals(true));
        expect(rawFormat.getOrNull()?.keys, <String>["slip"]);
      });
      test(
          "AdviceSlipsApi::getAdviceByIDRawFormat hasSlips attribute for ID: $i",
          () async {
        Result<Map<String, dynamic>, Exception> rawFormat =
            await AdviceSlipsApi.getAdviceByIDRawFormat(i);
        expect(rawFormat.isSuccess(), equals(true));
        expect(rawFormat.getOrNull()?["slip"], isNotNull);
      });
      test(
          "AdviceSlipsApi::getAdviceByIDRawFormat hasSlipsId attribute for ID: $i",
          () async {
        Result<Map<String, dynamic>, Exception> rawFormat =
            await AdviceSlipsApi.getAdviceByIDRawFormat(i);
        expect(rawFormat.isSuccess(), equals(true));
        expect(rawFormat.getOrNull()?["slip"]["id"], isNotNull);
      });
      test(
          "AdviceSlipsApi::getAdviceByIDRawFormat hasValidIntSlipsId attribute for ID: $i",
          () async {
        Result<Map<String, dynamic>, Exception> rawFormat =
            await AdviceSlipsApi.getAdviceByIDRawFormat(i);
        expect(rawFormat.isSuccess(), equals(true));
        expect(rawFormat.getOrNull()?["slip"]["id"], isA<int>());
      });
    }
    test("AdviceSlipsApi::getAdviceByID nonExistingID", () async {
      Result<AdviceSlip, Exception> advice =
          await AdviceSlipsApi.getAdviceById(-1);
      expect(advice.isError(), equals(true));
    });
    test("AdviceSlipsApi::getAdviceByID nonExistingID", () async {
      Result<AdviceSlip, Exception> advice =
          await AdviceSlipsApi.getAdviceById(0);
      expect(advice.isError(), equals(true));
    });
  });
  group("AdvicesByQuery", () {
    test("AdviceSlipsApi::getAdviceByQueryRawFormat sanity",
        () async {
      Result<Map<String, dynamic>, Exception> rawFormat =
          await AdviceSlipsApi.searchAdviceRawFormat("test");
      expect(rawFormat.isSuccess(), equals(true));
    });
    test("AdviceSlipsApi::getAdviceByQueryRawFormat hasValidFormat",
        () async {
      Result<Map<String, dynamic>, Exception> rawFormat =
          await AdviceSlipsApi.searchAdviceRawFormat("spider");
      expect(rawFormat.isSuccess(), equals(true));
      expect(rawFormat.getOrNull()?.keys,
          containsAll(<String>["slips", "total_results", "query"]));
    });
    test(
        "AdviceSlipsApi::getAdviceByQueryRawFormat hasSlips attribute",
        () async {
      Result<Map<String, dynamic>, Exception> rawFormat =
          await AdviceSlipsApi.searchAdviceRawFormat("spider");
      expect(rawFormat.isSuccess(), equals(true));
      expect(rawFormat.getOrNull()?["slips"], isNotNull);
    });
    test(
        "AdviceSlipsApi::getAdviceByQueryRawFormat hasTotalResults attribute",
        () async {
      Result<Map<String, dynamic>, Exception> rawFormat =
          await AdviceSlipsApi.searchAdviceRawFormat("spider");
      expect(rawFormat.isSuccess(), equals(true));
      expect(rawFormat.getOrNull()?["total_results"], isNotNull);
    });
    test(
        "AdviceSlipsApi::getAdviceByQueryRawFormat hasCorrectTotalResults",
        () async {
      Result<Map<String, dynamic>, Exception> rawFormat =
          await AdviceSlipsApi.searchAdviceRawFormat("love");
      expect(rawFormat.isSuccess(), equals(true));
      expect(int.parse(rawFormat.getOrNull()?["total_results"]),
          equals(5));
    });
    test(
        "AdviceSlipsApi::getAdviceByQueryRawFormat hasSlipsAdvice attribute",
        () async {
      Result<Map<String, dynamic>, Exception> rawFormat =
          await AdviceSlipsApi.searchAdviceRawFormat("spider");
      expect(rawFormat.isSuccess(), equals(true));
      expect(rawFormat.getOrNull()?["slips"], isNotEmpty);
    });
  });
}
