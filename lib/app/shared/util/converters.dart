import 'dart:typed_data';

import 'package:image/image.dart';

List<double> int8ToDouble(Uint8List integers) {
  return integers.map((e) => e / 255).toList();
}

Uint8List doubleToInt8(List<double> doubles) {
  return Uint8List.fromList(doubles.map((e) => (e * 255).round()).toList());
}

Image imageParse(Image image, Uint8List u8) {
  return Image.fromBytes(image.width, image.height, u8);
}
