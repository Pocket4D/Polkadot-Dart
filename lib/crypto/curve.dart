import 'dart:math';
import 'dart:typed_data';

import 'package:polkadot_dart/utils/utils.dart';

const secp256k1Params = {
  'p': 'fffffffffffffffffffffffffffffffffffffffffffffffffffffffefffffc2f',
  'a': '0',
  'b': '7',
  'Gx': '79be667ef9dcbbac55a06295ce870b07029bfcdb2dce28d959f2815b16f81798',
  'Gy': '483ada7726a3c4655da4fbfc0e1108a8fd17b448a68554199c47d08ffb10d4b8',
  'n': 'fffffffffffffffffffffffffffffffebaaedce6af48a03bbfd25e8cd0364141',
  'h': '1',
};

class Curve {
  BigInt p, a, b, n, h;
  List<BigInt> G;
  Curve(Map params) {
    p = BigInt.parse(params['p'], radix: 16);
    a = BigInt.parse(params['a'], radix: 16);
    b = BigInt.parse(params['b'], radix: 16);
    n = BigInt.parse(params['n'], radix: 16);
    h = BigInt.parse(params['h'], radix: 16);
    G = [
      BigInt.parse(secp256k1Params['Gx'], radix: 16),
      BigInt.parse(secp256k1Params['Gy'], radix: 16)
    ];
  }
}

var secp256k1 = Curve(secp256k1Params);

BigInt hex2Big(String string, {radix = 16}) {
  return BigInt.parse(string, radix: radix);
}

List<BigInt> big2Point(BigInt n) {
  return hex2Point(n.toRadixString(16));
}

List<BigInt> hex2Point(String hex) {
  final len = 130;
  if (hex.length != len) {
    throw ('point length must be $len!');
  }

  if (hex.substring(0, 2) != '04') {
    throw ('point prefix incorrect!');
  }

  return [
    BigInt.parse(hex.substring(2, 66), radix: 16),
    BigInt.parse(hex.substring(66, 130), radix: 16),
  ];
}

List<BigInt> hex2PointFromCompress(String hex) {
  final len = 66;
  if (hex.length != len) {
    throw ('point length must be $len!');
  }

  var firstByte = int.parse(hex.substring(0, 2), radix: 16);

  if ((firstByte & ~1) != 2) {
    throw ('point prefix incorrect!');
  }

  // The curve equation for secp256k1 is: y^2 = x^3 + 7.
  var x = BigInt.parse(hex.substring(2, 66), radix: 16);

  var ySqared = ((x.modPow(BigInt.from(3), secp256k1.p)) + BigInt.from(7)) % secp256k1.p;

  // power = (p+1) // 4
  var p1 = secp256k1.p + BigInt.from(1); // p+1
  var power = (p1 - p1 % BigInt.from(4)) ~/ BigInt.from(4);
  var y = ySqared.modPow(power, secp256k1.p);

  var sq = y.pow(2) % secp256k1.p;
  if (sq != ySqared) {
    throw ('failed to retrieve y of public key from hex');
  }

  var firstBit = (y & BigInt.one).toInt();
  if (firstBit != (firstByte & 1)) {
    y = secp256k1.p - y;
  }

  return [
    x,
    y,
  ];
}

String point2Hex(List<BigInt> point) {
  return '04${point[0].toRadixString(16).padLeft(64, '0')}${point[1].toRadixString(16).padLeft(64, '0')}'; // 2+64+64 = 130
}

String point2HexInCompress(List<BigInt> point) {
  // var byteLen = 32; //(256 + 7) >> 3 //  => so len of str is (32+1) * 2 = 66;
  var firstBit = 2 + (point[1] & BigInt.one).toInt();
  var prefix = firstBit.toRadixString(16).padLeft(2, '0');

  return prefix + point[0].toRadixString(16).padLeft(64, '0');
}

BigInt point2Big(List<BigInt> point) {
  return BigInt.parse(point2Hex(point), radix: 16);
}

BigInt positiveMod(BigInt n, BigInt modN) {
  return (n % modN + modN) % modN;
}

BigInt inverseMulti(BigInt x, BigInt modNum) {
  // x1 * x + x2 * y = x3
  var x1 = BigInt.one;
  var x2 = BigInt.zero;
  var x3 = modNum;

  // y1 * x + y2 * y = y3
  var y1 = BigInt.zero;
  var y2 = BigInt.one;
  var y3 = (x % modNum + modNum) % modNum;

  BigInt q;
  BigInt t1, t2, t3;
  while (true) {
    if (y3 == BigInt.zero) {
      throw ('multiplicative inverse modulo is no answer!');
    }
    if (y3 == BigInt.one) return y2;

    q = BigInt.from(x3 / y3);

    t1 = x1 - q * y1;
    t2 = x2 - q * y2;
    t3 = x3 - q * y3;

    x1 = y1;
    x2 = y2;
    x3 = y3;

    y1 = t1;
    y2 = t2;
    y3 = t3;
  }
}

BigInt getPrivKeyByRand(BigInt n) {
  var nHex = n.toRadixString(16);
  var privteKeyList = <String>[];
  var random = Random.secure();

  for (var i = 0; i < nHex.length; i++) {
    var rand16Num = (random.nextInt(100) / 100 * int.parse(nHex[i], radix: 16)).round();
    privteKeyList.add(rand16Num.toRadixString(16));
  }

  var D = BigInt.parse(privteKeyList.join(''), radix: 16);
  if (D == BigInt.zero) {
    return getPrivKeyByRand(n);
  }

  return D;
}

List<BigInt> addSamePoint(BigInt x1, BigInt y1, BigInt modNum, BigInt a) {
  var ru =
      positiveMod((BigInt.from(3) * x1.pow(2) + a) * inverseMulti(BigInt.two * y1, modNum), modNum);
  var x3 = positiveMod(ru.pow(2) - (BigInt.two * x1), modNum);
  var y3 = positiveMod(ru * (x1 - x3) - y1, modNum);
  return [x3, y3];
}

List<BigInt> addDiffPoint(BigInt x1, BigInt y1, BigInt x2, BigInt y2, BigInt modNum) {
  var ru = positiveMod((y2 - y1) * inverseMulti(x2 - x1, modNum), modNum);
  var x3 = positiveMod(ru.pow(2) - x1 - x2, modNum);
  var y3 = positiveMod(ru * (x1 - x3) - y1, modNum);
  return [x3, y3];
}

List<BigInt> getPointByBig(BigInt n, BigInt p, BigInt a, List<BigInt> pointG) {
  var bin = n.toRadixString(2);
  List<BigInt> nowPoint;
  var nextPoint = pointG;
  for (var i = bin.length - 1; i >= 0; i--) {
    if (bin[i] == '1') {
      if (nowPoint == null) {
        nowPoint = nextPoint;
      } else {
        nowPoint = addDiffPoint(nowPoint[0], nowPoint[1], nextPoint[0], nextPoint[1], p);
      }
    }

    nextPoint = addSamePoint(nextPoint[0], nextPoint[1], p, a);
  }

  return nowPoint;
}

// signRFC6979
List<BigInt> sign(BigInt n, BigInt p, BigInt a, BigInt d, List<BigInt> pointG, BigInt bigHash) {
  BigInt k;
  List<BigInt> R;
  var r = BigInt.zero;

  while (true) {
    k = getPrivKeyByRand(n);
    if (k < BigInt.one || k >= n - BigInt.one) continue;

    R = getPointByBig(k, p, a, pointG);

    r = positiveMod(R[0], n);
    if (r == BigInt.zero) continue;

    var e = bigHash;
    var s = positiveMod(((e + (r * d)) * inverseMulti(k, n)), n);

    // if (s == BigInt.zero) {
    //   return sign(n, p, a, d, pointG, bigHash);
    // }

    var kpX = R[0];
    var kpY = R[1];
    var recoveryParam = (kpY.isOdd ? 1 : 0) | (kpX.compareTo(r) != 0 ? 2 : 0);
    // if (s.compareTo(secp256k1.n % BigInt.from(2)) > 0) {
    //   recoveryParam ^= 1;
    // }
    // print("recoveryParam :$recoveryParam");
    if (s == BigInt.zero) continue;

    return [r, s, BigInt.from(recoveryParam)];
  }
}

bool curveVerify(BigInt n, BigInt p, BigInt a, List<BigInt> pointG, List<BigInt> pointQ,
    List<BigInt> sign, BigInt bigHash) {
  var r = sign[0];
  var s = sign[1];

  if (r < BigInt.one || r >= n) return false;
  if (s < BigInt.one || s >= n) return false;

  // if (!(r > BigInt.one && r < n && s > BigInt.one && s < n)) {
  //   return false;
  // }

  var e = bigHash;
  var w = inverseMulti(s, n);
  var u1 = positiveMod((e * w), n);
  var u2 = positiveMod((r * w), n);
  var u1Point = getPointByBig(u1, p, a, pointG);
  var u2Point = getPointByBig(u2, p, a, pointQ);

  List<BigInt> pointR;
  if (u1Point[0] == u2Point[0] && u1Point[1] == u2Point[1]) {
    pointR = addSamePoint(u1Point[0], u1Point[1], p, a);
  } else {
    pointR = addDiffPoint(u1Point[0], u1Point[1], u2Point[0], u2Point[1], p);
  }
  if (pointR[0] == BigInt.zero && pointR[1] == BigInt.zero) {
    return false;
  }
  var v = positiveMod(pointR[0], n);
  if (v == r) {
    return true;
  }
  return false;
}

class CurvePrivateKey {
  BigInt D;

  /// get the unique public key of the private key on secp256k1 curve
  CurvePublicKey get publicKey {
    final point = getPointByBig(D, secp256k1.p, secp256k1.a, secp256k1.G);

    return CurvePublicKey(point[0], point[1]);
  }

  /// generate a private key from random number
  CurvePrivateKey(this.D);

  /// generate a private key from random number
  CurvePrivateKey.generate() {
    D = getPrivKeyByRand(secp256k1.n);
  }

  /// convert a hex string to a private key(bigint)
  CurvePrivateKey.fromHex(String hexString) {
    D = BigInt.parse(hexString, radix: 16);
  }

  /// generate a hex string from a private key(bigint)
  String toHex() {
    return D.toRadixString(16).padLeft(64, '0');
  }

  /// sign the **hash** of message with the private key
  CurveSignature signature(String hexHash) {
    final rs = sign(
        secp256k1.n, secp256k1.p, secp256k1.a, D, secp256k1.G, BigInt.parse(hexHash, radix: 16));

    return CurveSignature(rs[0], rs[1], rs[2].toInt());
  }

  @override
  bool operator ==(other) {
    return other is CurvePrivateKey && (D == other.D);
  }

  @override
  int get hashCode => super.hashCode;
}

class CurvePublicKey {
  BigInt X;
  BigInt Y;

  CurvePublicKey(this.X, this.Y);

  /// convert a hex string to a public key
  CurvePublicKey.fromHex(String hexString) {
    final point = hex2Point(hexString);
    X = point[0];
    Y = point[1];
  }

  /// convert a compressed hex string to a public key(List of 2 bigints)
  CurvePublicKey.fromCompressedHex(String hexString) {
    final point = hex2PointFromCompress(hexString);
    X = point[0];
    Y = point[1];
  }

  /// generate a hex string from a public key
  String toHex() {
    return point2Hex([X, Y]);
  }

  /// generate a compressed hex string from a public key
  String toCompressedHex() {
    return point2HexInCompress([X, Y]);
  }

  @override
  String toString() {
    return toHex();
  }

  @override
  bool operator ==(other) {
    return other is CurvePublicKey && (X == other.X && Y == other.Y);
  }

  @override
  int get hashCode => super.hashCode;
}

class CurveSignature {
  BigInt R;
  BigInt S;
  int V;
  int recoveryId;
  Uint8List bytes;

  CurveSignature(this.R, this.S, [this.recoveryId = 0]) {
    var rArr = bnToU8a(this.R, bitLength: 256, endian: Endian.big);
    var sArr = bnToU8a(this.S, bitLength: 256, endian: Endian.big);
    var _bytes = u8aConcat([rArr, sArr]);
    // print(_bytes.length);
    // V = _bytes[64];
    // if (V != 27 && V != 28) {
    //   V = 27 + (V % 2);
    // }
    // this.recoveryId = V - 27;
    this.bytes = u8aConcat([
      _bytes,
      Uint8List.fromList([this.recoveryId ?? 0])
    ]);
  }
  CurveSignature.fromHexes(String r, s) {
    R = BigInt.parse(r, radix: 16);
    S = BigInt.parse(s, radix: 16);
  }

  /// verify the sign and the **hash** of message with the public key
  bool verify(CurvePublicKey publicKey, String hexHash) {
    return curveVerify(
      secp256k1.n,
      secp256k1.p,
      secp256k1.a,
      secp256k1.G,
      [publicKey.X, publicKey.Y],
      [R, S],
      BigInt.parse(hexHash, radix: 16),
    );
  }

  List<BigInt> toBigInts() {
    return [R, S];
  }

  List<String> toHexes() {
    return [R.toRadixString(16).padLeft(64, '0'), S.toRadixString(16).padLeft(64, '0')];
  }

  String toRawHex() {
    return R.toRadixString(16).padLeft(64, '0') + S.toRadixString(16).padLeft(64, '0');
  }

  @override
  String toString() {
    return toRawHex();
  }

  @override
  bool operator ==(other) {
    return other is CurveSignature && (R == other.R && S == other.S);
  }

  @override
  int get hashCode => super.hashCode;
}
