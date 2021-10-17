import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:image/image.dart' as img;
import 'package:image_processing/app/shared/util/converters.dart';
import 'package:mobx/mobx.dart';

part 'image_service.g.dart';

class ImageService = ImageServiceBase with _$ImageService;

abstract class ImageServiceBase with Store {
  @observable
  ObservableFuture<img.Image>? _image;

  img.Image? get imageFuture => _image?.value;

  @observable
  ObservableFuture<ui.Image>? _uiImage;

  ui.Image? get uiImagemFuture => _uiImage?.value;

  List<double> ld = [];
  Uint8List li = Uint8List(0);

  @action
  Future<ui.Image> imgImageToUiImage() async {
    img.Image imagem = _image!.value!;
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
    _image = Future<img.Image>.value(imagem).asObservable();
    _image!.whenComplete(() {
      _uiImage = imgImageToUiImage().asObservable();
    });
  }

  void escalaDeCinza() {
    ld = int8ToDouble(imageFuture!.getBytes());
    for (var i = 0, len = ld.length; i < len; i += 4) {
      final l = 0.299 * ld[i] + 0.587 * ld[i + 1] + 0.114 * ld[i + 2];
      ld[i] = l;
      ld[i + 1] = l;
      ld[i + 2] = l;
    }
    li = doubleToInt8(ld);
    updateImage(imageParse(imageFuture!, li));
  }
  void negativo() {
    ld = int8ToDouble(imageFuture!.getBytes());
    for (var i = 0, len = ld.length; i < len; i += 4) {
      final l = 1 - (0.299 * ld[i] + 0.587 * ld[i + 1] + 0.114 * ld[i + 2]);
      ld[i] = l;
      ld[i + 1] = l;
      ld[i + 2] = l;
    }
    li = doubleToInt8(ld);
    updateImage(imageParse(imageFuture!, li));
  }
}
