import "package:advices_slip_api/advices_slip_api.dart";

void main() async {
  (await AdviceSlipsApi.randomAdvice())
      .onSuccess((AdviceSlip advice) => print(advice))
      .onFailure((Exception e) => print(e));
  (await AdviceSlipsApi.findAdvice("life"))
      .onSuccess((List<AdviceSlip> advice) => print(advice))
      .onFailure((Exception e) => print(e));
  (await AdviceSlipsApi.findAdvice("life"))
      .onSuccess((List<AdviceSlip> advice) => print(advice))
      .onFailure((Exception e) => print(e));
}