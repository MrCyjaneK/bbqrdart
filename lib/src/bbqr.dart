import 'dart:convert';
import 'dart:typed_data';

import 'package:bbqrdart/src/encoding.dart';
import 'package:bbqrdart/src/file_type.dart';

class BBQR {
  // B$                  fixed header for this protocol (2 chars)
  static const String header = r"B$";
  // H                   one char of data encoding: H=Hex
  final BBQREncoding encoding = BBQREncodingHex();
  // P                   one char file type: P=PSBT, T=TXN, etc
  BBQRFileType get fileType => throw UnimplementedError();
  // 05                  Two digits of base 36: total number of QR codes (0-9A-Z)
  String get qrCodeCount => throw UnimplementedError();
  // 00                  Two digits of base 36: which QR code this is in the sequence
  String get qrCodeCurrent => throw UnimplementedError();
  // (HEX or Base32 characters follow)
  String get content => throw UnimplementedError();

  bool get isDone => throw UnimplementedError();

  String asString() {
    assert(header == r"B$");
    assert(encoding.toString().length == 1);
    assert(fileType.toString().length == 1);
    assert(qrCodeCount.toString().length == 2);
    assert(qrCodeCurrent.toString().length == 2);
    //      B$     Z        P         01         00            FMUE4KXZ...
    return "$header$encoding$fileType$qrCodeCount$qrCodeCurrent$content";
  }

  void next() {}
}

class BBQRPsbt extends BBQR {
  BBQRPsbt({required this.hex});

  String hex;

  static BBQR fromBase64String(String b64) => fromUint8List(base64.decode(b64));

  static BBQR fromUint8List(Uint8List bytes) {
    return BBQRPsbt(hex: uint8ListToHex(bytes));
  }

  static String uint8ListToHex(Uint8List data) => data.map((byte) => byte.toRadixString(16).padLeft(2, '0')).join();
  

  late final List<String> allContents = (){
    return BBQRPsbt.strsplit(hex, 160);
  }();

  @override
  String get content => allContents[currentFrame];
  
  @override
  BBQREncoding get encoding => BBQREncodingHex();
  
  @override
  BBQRFileType get fileType => BBQRFileTypePSBT();
  
  @override
  String get qrCodeCount => allContents.length.toRadixString(36).padLeft(2, '0');

  @override
  String get qrCodeCurrent => currentFrame.toRadixString(36).padLeft(2, '0');

  int _frame = 0;
  int get currentFrame => (_frame % allContents.length);
  @override
  void next() {
    _frame++;
  }

  @override
  bool get isDone => (_frame % allContents.length) == (allContents.length - 1);

  static List<String> strsplit(String input, int partLength) {
    int totalLength = input.length;
    int numParts = (totalLength / partLength).ceil();
    int actualPartLength = (totalLength / numParts).ceil();

    List<String> parts = [];
    for (int i = 0; i < totalLength; i += actualPartLength) {
      int end = (i + actualPartLength < totalLength) ? i + actualPartLength : totalLength;
      parts.add(input.substring(i, end));
    }

    return parts;
  }
}