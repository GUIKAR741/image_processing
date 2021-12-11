import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:image/image.dart' as img;
import 'package:image_processing/app/shared/util/converters.dart';
import 'package:image_processing/app/shared/util/math_functions.dart';
import 'package:mobx/mobx.dart';

part 'image_service.g.dart';

class ImageService = ImageServiceBase with _$ImageService;

abstract class ImageServiceBase with Store {
  @observable
  img.Image? _image;

  img.Image? get imageValue => _image;

  bool _isCinza = false;

  img.Image? _imageOriginal;
  img.Image? _imageOriginalPB;

  @observable
  ObservableFuture<ui.Image>? _uiImage;

  ui.Image? get uiImagemFuture => _uiImage?.value;

  List<double> ld = [];
  Uint8List li = Uint8List(0);

  @action
  Future<ui.Image> imgImageToUiImage() async {
    img.Image imagem = _image!;
    ui.ImmutableBuffer buffer = await ui.ImmutableBuffer.fromUint8List(
      imagem.getBytes(format: img.Format.rgba),
    );
    ui.ImageDescriptor id = ui.ImageDescriptor.raw(
      buffer,
      height: imagem.height,
      width: imagem.width,
      pixelFormat: ui.PixelFormat.rgba8888,
    );
    ui.Codec codec = await id.instantiateCodec(
      targetHeight: imagem.height,
      targetWidth: imagem.width,
    );
    ui.FrameInfo fi = await codec.getNextFrame();
    ui.Image uiImage = fi.image;
    return uiImage;
  }

  @action
  void updateImage(img.Image imagem) {
    _imageOriginal ??= imagem;
    _image = imagem;
    _uiImage = imgImageToUiImage().asObservable();
  }

  @action
  void resetImage() {
    _isCinza = false;
    _image = _imageOriginal;
    _uiImage = imgImageToUiImage().asObservable();
  }

  @action
  void clearImage() {
    _isCinza = false;
    _imageOriginal = null;
    _image = null;
    _uiImage = null;
  }

  void _conversionImage(
    void Function() callback, {
    bool original = false,
    bool pb = false,
  }) {
    img.Image? imageValor = !pb && original
        ? _imageOriginal
        : (!original && pb ? _imageOriginalPB : imageValue);
    _uiImage = null;
    ld = int8ToDouble(imageValor!.getBytes());
    callback();
    li = doubleToInt8(ld);
    updateImage(imageParse(imageValor, li));
  }

  void escalaDeCinza() {
    if (!_isCinza) {
      _conversionImage(() {
        for (var i = 0, len = ld.length; i < len; i += 4) {
          final l = 0.299 * ld[i] + 0.587 * ld[i + 1] + 0.114 * ld[i + 2];
          ld[i] = l;
          ld[i + 1] = l;
          ld[i + 2] = l;
        }
      });
      _imageOriginalPB ??= img.Image.from(_image!);
      _isCinza = true;
    } else {
      _image = _imageOriginalPB;
      updateImage(_image!);
    }
  }

  void negativo() {
    if (!_isCinza) escalaDeCinza();
    _conversionImage(() {
      for (var i = 0, len = ld.length; i < len; i += 4) {
        ld[i] = 1 - ld[i];
        ld[i + 1] = 1 - ld[i + 1];
        ld[i + 2] = 1 - ld[i + 2];
      }
    });
  }

  void transfLog() {
    if (!_isCinza) escalaDeCinza();
    _conversionImage(() {
      for (var i = 0, len = ld.length; i < len; i += 4) {
        double lx = limites(log2(1 + ld[i]));
        ld[i] = lx;
        ld[i + 1] = lx;
        ld[i + 2] = lx;
      }
    });
  }

  void convolucao(List<List<num>> filtro) {
    if (!_isCinza) escalaDeCinza();
    _conversionImage(
      () {
        List<List<Pixel>> imagemMatrix = listImageToMatrix(
          li,
          imageValue!.width,
          imageValue!.height,
        );
        print(filtro);
        for (int y = 0; y < imagemMatrix.length; y++) {
          for (int x = 0; x < imagemMatrix[y].length; x++) {
            Pixel p = Pixel(a: imagemMatrix[y][x].a);
            for (var i = 0; i < filtro.length; i++) {
              for (var j = 0; j < filtro[i].length; j++) {
                final yv = (y + j - (filtro.length ~/ 2)) < 0
                    ? imagemMatrix.length + (y + j - (filtro.length ~/ 2))
                    : ((y + j - (filtro.length ~/ 2)) >= imagemMatrix.length
                        ? (y + j - (filtro.length ~/ 2)) - imagemMatrix.length
                        : (y + j - (filtro.length ~/ 2)));
                final xv = (x + i - (filtro[i].length ~/ 2)) < 0
                    ? imagemMatrix[y].length + (x + i - (filtro[i].length ~/ 2))
                    : ((x + i - (filtro[i].length ~/ 2)) >=
                            imagemMatrix[y].length
                        ? (x + i - (filtro[i].length ~/ 2)) -
                            imagemMatrix[y].length
                        : (x + i - (filtro[i].length ~/ 2)));
                // final yv = limitar(
                //   y + j - (filtro.length ~/ 2),
                //   0,
                //   imagemMatrix.length - 1,
                // );
                // final xv = limitar(
                //   x + i - (filtro[i].length ~/ 2),
                //   0,
                //   imagemMatrix[y].length - 1,
                // );

                Pixel p2 = imagemMatrix[yv][xv];
                p.r += p2.r * filtro[i][j];
                p.g += p2.g * filtro[i][j];
                p.b += p2.b * filtro[i][j];
                if (x == 0 && y == 0) {
                  // print(
                  //     "(${i + 1},${j + 1}): $xv, $yv, ${y + j - (filtro[i].length ~/ 2)}, ${x + i - (filtro[i].length ~/ 2)}");
                  print(p2.r * filtro[i][j]);
                  print(p2.g * filtro[i][j]);
                  print(p2.b * filtro[i][j]);
                }
              }
            }
            if (x==0 && y==0)print("${p.r} ${p.g} ${p.b}");
            imagemMatrix[y][x].r = limitar(p.r, 0, 255);
            imagemMatrix[y][x].g = limitar(p.g, 0, 255);
            imagemMatrix[y][x].b = limitar(p.b, 0, 255);
          }
        }
        print(toListNum(imagemMatrix).getRange(0, 100));
        ld = intToDouble(toListNum(imagemMatrix));
      },
      original: !_isCinza,
      pb: _isCinza,
    );
  }

  void transfPot(
    double gamma,
    double contrast,
  ) {
    _conversionImage(
      () {
        for (var i = 0, len = ld.length; i < len; i += 4) {
          if (_isCinza) {
            double lx = limites(contrast * pow(ld[i], gamma).toDouble());
            ld[i] = lx;
            ld[i + 1] = lx;
            ld[i + 2] = lx;
          } else {
            ld[i] = limites(contrast * pow(ld[i], gamma).toDouble());
            ld[i + 1] = limites(contrast * pow(ld[i + 1], gamma).toDouble());
            ld[i + 2] = limites(contrast * pow(ld[i + 2], gamma).toDouble());
          }
        }
      },
      original: !_isCinza,
      pb: _isCinza,
    );
  }
}
