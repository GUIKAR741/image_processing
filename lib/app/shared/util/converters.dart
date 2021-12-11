import 'dart:typed_data';

import 'package:image/image.dart' as img;
import 'package:syncfusion_flutter_charts/charts.dart';

import 'chart_sample_data.dart';

List<double> int8ToDouble(Uint8List integers) {
  return integers.map((e) => e / 255).toList();
}

List<double> intToDouble(List<int> integers) {
  return integers.map((e) => e / 255).toList();
}

Uint8List doubleToInt8(List<double> doubles) {
  return Uint8List.fromList(doubles.map((e) => (e * 255).round()).toList());
}

class Pixel {
  num r = 0, g = 0, b = 0, a = 0;

  Pixel({this.r = 0, this.g = 0, this.b = 0, this.a = 0});

  List<num> get toList => [r, g, b, a];

  List<E> toListCast<E>() => [r as E, g as E, b as E, a as E];

  @override
  String toString() => "$r, $g, $b";
}

List<List<Pixel>> listImageToMatrix(List<num> numbers, int width, int height) {
  List<List<Pixel>> matrix = [];
  int widthMod = width * 4;
  for (int i = 0; i < height; i++) {
    matrix.add([]);
    for (int x = i * widthMod; x < i * widthMod + widthMod; x += 4) {
      matrix.last.add(Pixel(
        r: numbers[x],
        g: numbers[x + 1],
        b: numbers[x + 2],
        a: numbers[x + 3],
      ));
    }
  }
  return matrix;
}

List<E> toListNum<E>(List<List<Pixel>> pixels) {
  List<E> matrix = [];
  for (var e1 in pixels) {
    for (var e2 in e1) {
      matrix.addAll(e2.toListCast<E>());
    }
  }
  return matrix;
}

img.Image imageParse(img.Image image, Uint8List u8) {
  return img.Image.fromBytes(image.width, image.height, u8);
}

double limites(double i) => i < 0 ? 0 : (i > 1 ? 1 : i);

int limitesInt(int i) => i < 0 ? 0 : (i > 255 ? 255 : i);

E limitar<E extends num>(E i, E p, E t) => i < p ? p : (i > t ? t : i);

List<XyDataSeries<ChartSampleData, num>> getSeries({
  Uint8List? values,
}) {
  final Map<int, num> val = {
    for (var element in List.generate(256, (index) => index)) element: 0
  };
  for (var i = 0, len = values!.length; i < len; i += 4) {
    val.update(values[i], (value) => value + 1);
    val.update(values[i + 1], (value) => value + 1);
    val.update(values[i + 2], (value) => value + 1);
  }
  int total = values.length ~/ 4;
  val.forEach((key, value) {
    val[key] = value / total;
  });
  val.forEach((key, value) {
    if (key == 0) return;
    val[key] = value + val[key - 1]!;
  });
  val.forEach((key, value) {
    val[key] = (value * 255);
  });

  int maior = 0;
  // val.forEach((key, value) => value > maior ? maior = value : null);
  final List<ChartSampleData> chartData =
      val.entries.map((e) => ChartSampleData(x: e.key, y: e.value)).toList();
  // [
  //   ChartSampleData(x: 0.250),
  //   ChartSampleData(x: 0.750),
  //   ChartSampleData(x: 0.375),
  //   ChartSampleData(x: 0.735),
  //   ChartSampleData(x: 0.735),
  //   // ChartSampleData(x: 0.735),
  // ];
  // values.map((e) => ChartSampleData(x: e)).toList();
  return [
    ColumnSeries<ChartSampleData, num>(
      dataSource: chartData,
      xValueMapper: (ChartSampleData sales, _) => sales.x,
      yValueMapper: (ChartSampleData sales, _) => sales.y,
    ),
    LineSeries<ChartSampleData, num>(
      dataSource: <ChartSampleData>[
        ChartSampleData(x: 0, y: 0),
        ChartSampleData(x: 255, y: maior),
      ],
      xValueMapper: (ChartSampleData sales, _) => sales.x,
      yValueMapper: (ChartSampleData sales, _) => sales.y,
    )
  ];
}
