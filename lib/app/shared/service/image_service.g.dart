// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_service.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ImageService on ImageServiceBase, Store {
  final _$_imageAtom = Atom(name: 'ImageServiceBase._image');

  @override
  img.Image? get _image {
    _$_imageAtom.reportRead();
    return super._image;
  }

  @override
  set _image(img.Image? value) {
    _$_imageAtom.reportWrite(value, super._image, () {
      super._image = value;
    });
  }

  final _$_uiImageAtom = Atom(name: 'ImageServiceBase._uiImage');

  @override
  ObservableFuture<ui.Image>? get _uiImage {
    _$_uiImageAtom.reportRead();
    return super._uiImage;
  }

  @override
  set _uiImage(ObservableFuture<ui.Image>? value) {
    _$_uiImageAtom.reportWrite(value, super._uiImage, () {
      super._uiImage = value;
    });
  }

  final _$imgImageToUiImageAsyncAction =
      AsyncAction('ImageServiceBase.imgImageToUiImage');

  @override
  Future<ui.Image> imgImageToUiImage() {
    return _$imgImageToUiImageAsyncAction.run(() => super.imgImageToUiImage());
  }

  final _$ImageServiceBaseActionController =
      ActionController(name: 'ImageServiceBase');

  @override
  void updateImage(img.Image imagem) {
    final _$actionInfo = _$ImageServiceBaseActionController.startAction(
        name: 'ImageServiceBase.updateImage');
    try {
      return super.updateImage(imagem);
    } finally {
      _$ImageServiceBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void resetImage() {
    final _$actionInfo = _$ImageServiceBaseActionController.startAction(
        name: 'ImageServiceBase.resetImage');
    try {
      return super.resetImage();
    } finally {
      _$ImageServiceBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void clearImage() {
    final _$actionInfo = _$ImageServiceBaseActionController.startAction(
        name: 'ImageServiceBase.clearImage');
    try {
      return super.clearImage();
    } finally {
      _$ImageServiceBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''

    ''';
  }
}
