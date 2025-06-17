abstract class BBQREncoding {
  @override
  String toString();
}

// H	HEX (capitalized hex digits, 4-bits each)
class BBQREncodingHex implements BBQREncoding {
  @override
  String toString() {
    return "H";
  }
}

// 2	Base32 using RFC 4648 alphabet
class BBQREncodingBase32 implements BBQREncoding {
  @override
  String toString() {
    return "2";
  }
}

// Z	Zlib compressed (wbits=10, no header) then Base32
class BBQREncodingZlibBase32 implements BBQREncoding {
  @override
  String toString() {
    return "Z";
  }
}
