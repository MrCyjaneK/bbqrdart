# bbqrdart

> Native bbqr implementation for dart

## Usage

In your pubspec add

```yaml
  bbqrdart:
    git:
      url: https://github.com/mrcyjanek/bbqrdart
      ref: main
```

```dart
// sourceBytes is PSBT transaction, you can also use
// BBQRPsbt.fromBase64String
final bbqrObj = BBQRPsbt.fromUint8List(sourceBytes);
List<String> bbqr = [
    bbqrObj.asString(),
];
while (!bbqrObj.isDone) {
    bbqrObj.next();
    bbqr.add(bbqrObj.asString());
}
```

