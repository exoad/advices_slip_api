<h1 align="center">
Advice Slips API Wrapper
</h1>
<p align="center">
<strong><em>An unofficial wrapper for the <a href="https://api.adviceslip.com"/>Advice Slip JSON API</a> to embed into your Dart/Flutter apps.</em></strong>
</p>

**Install it [here](https://pub.dev/packages/advices_slip_api)**

## Installation

**`pubspec.yaml`:**

```yaml
dependencies:
    advices_slip_api: x.x.x
```

**Command Line**

```shell
[dart/flutter] pub add advices_slip_api
```

## Usage

```
import "package:advices_slip_api/advices_slip_api.dart";
```

#### Available Functions

**`randomAdvice()`** - Get a random advice


**`findAdvice(query)`** - Find advices given a keyword to use to find


**`getAdviceById(id)`** - Find an advice by its canonical id


## Example Usage:

```dart
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
```
