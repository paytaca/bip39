import 'dart:convert';
import 'dart:typed_data';
import 'package:pointycastle/digests/sha512.dart';
import 'package:pointycastle/key_derivators/api.dart' show Pbkdf2Parameters;
import 'package:pointycastle/key_derivators/pbkdf2.dart';
import 'package:pointycastle/macs/hmac.dart';

class PBKDF2 {

  PBKDF2KeyDerivator _derivator;
  Uint8List _salt;

  PBKDF2({int blockLength = 128,
          int iterationCount = 2048,
          int desiredKeyLength = 64,
          String salt = "some-salt"}) {
    _salt = utf8.encode(salt);
    _derivator =
    new PBKDF2KeyDerivator(new HMac(new SHA512Digest(), blockLength))
      ..init(new Pbkdf2Parameters(_salt, iterationCount, desiredKeyLength));
  }

  Uint8List process(String mnemonic) {
    return _derivator.process(new Uint8List.fromList(mnemonic.codeUnits));
  }
}
