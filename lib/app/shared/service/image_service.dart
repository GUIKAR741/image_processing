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

  img.Image? _imageOriginal;

  bool _isCinza = false;

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

  void _conversionImage(void Function() callback) {
    _uiImage = null;
    ld = int8ToDouble(imageValue!.getBytes());
    callback();
    li = doubleToInt8(ld);
    updateImage(imageParse(imageValue!, li));
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
      _isCinza = true;
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
        double lx = log2(1 + ld[i]);
        ld[i] = lx;
        ld[i + 1] = lx;
        ld[i + 2] = lx;
      }
    });
  }
}
