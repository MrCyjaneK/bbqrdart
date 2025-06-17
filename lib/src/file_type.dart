abstract class BBQRFileType {
  @override
  String toString();
}

// P	PSBT file
class BBQRFileTypePSBT implements BBQRFileType {
  @override
  String toString() {
    return "P";
  }
}

// T	Ready to send Bitcoin wire transaction
class BBQRFileTypeBitcoinWire implements BBQRFileType {
  @override
  String toString() {
    return "T";
  }
}

// J	JSON data (general purpose)
class BBQRFileTypeJSON implements BBQRFileType {
  @override
  String toString() {
    return "J";
  }
}

// C	CBOR data (general purpose)
class BBQRFileTypeCBOR implements BBQRFileType {
  @override
  String toString() {
    return "C";
  }
}

// U	Unicode text (UTF-8 encoded, simple text)
class BBQRFileTypeUnicodeUTF8 implements BBQRFileType {
  @override
  String toString() {
    return "U";
  }
}

// B	Binary data (generic octet stream)
class BBQRFileTypeBinary implements BBQRFileType {
  @override
  String toString() {
    return "B";
  }
}

// X	Executable data (platform dependant)
class BBQRFileTypeExecutable implements BBQRFileType {
  @override
  String toString() {
    return "X";
  }
}