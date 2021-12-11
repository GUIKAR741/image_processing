// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$HomeStore on HomeStoreBase, Store {
  final _$sliderGammaAtom = Atom(name: 'HomeStoreBase.sliderGamma');

  @override
  double get sliderGamma {
    _$sliderGammaAtom.reportRead();
    return super.sliderGamma;
  }

  @override
  set sliderGamma(double value) {
    _$sliderGammaAtom.reportWrite(value, super.sliderGamma, () {
      super.sliderGamma = value;
    });
  }

  final _$sliderContrastAtom = Atom(name: 'HomeStoreBase.sliderContrast');

  @override
  double get sliderContrast {
    _$sliderContrastAtom.reportRead();
    return super.sliderContrast;
  }

  @override
  set sliderContrast(double value) {
    _$sliderContrastAtom.reportWrite(value, super.sliderContrast, () {
      super.sliderContrast = value;
    });
  }

  final _$showHistogramaAtom = Atom(name: 'HomeStoreBase.showHistograma');

  @override
  bool get showHistograma {
    _$showHistogramaAtom.reportRead();
    return super.showHistograma;
  }

  @override
  set showHistograma(bool value) {
    _$showHistogramaAtom.reportWrite(value, super.showHistograma, () {
      super.showHistograma = value;
    });
  }

  final _$negativoRGBAtom = Atom(name: 'HomeStoreBase.negativoRGB');

  @override
  bool get negativoRGB {
    _$negativoRGBAtom.reportRead();
    return super.negativoRGB;
  }

  @override
  set negativoRGB(bool value) {
    _$negativoRGBAtom.reportWrite(value, super.negativoRGB, () {
      super.negativoRGB = value;
    });
  }

  final _$imagemAtom = Atom(name: 'HomeStoreBase.imagem');

  @override
  Uint8List? get imagem {
    _$imagemAtom.reportRead();
    return super.imagem;
  }

  @override
  set imagem(Uint8List? value) {
    _$imagemAtom.reportWrite(value, super.imagem, () {
      super.imagem = value;
    });
  }

  final _$imagemOriginalAtom = Atom(name: 'HomeStoreBase.imagemOriginal');

  @override
  Uint8List? get imagemOriginal {
    _$imagemOriginalAtom.reportRead();
    return super.imagemOriginal;
  }

  @override
  set imagemOriginal(Uint8List? value) {
    _$imagemOriginalAtom.reportWrite(value, super.imagemOriginal, () {
      super.imagemOriginal = value;
    });
  }

  final _$blackAndWhiteAsyncAction = AsyncAction('HomeStoreBase.blackAndWhite');

  @override
  Future<void> blackAndWhite() {
    return _$blackAndWhiteAsyncAction.run(() => super.blackAndWhite());
  }

  final _$grayscalePonderadoAsyncAction =
      AsyncAction('HomeStoreBase.grayscalePonderado');

  @override
  Future<void> grayscalePonderado() {
    return _$grayscalePonderadoAsyncAction
        .run(() => super.grayscalePonderado());
  }

  final _$grayscaleMediaAsyncAction =
      AsyncAction('HomeStoreBase.grayscaleMedia');

  @override
  Future<void> grayscaleMedia() {
    return _$grayscaleMediaAsyncAction.run(() => super.grayscaleMedia());
  }

  final _$sepiaAsyncAction = AsyncAction('HomeStoreBase.sepia');

  @override
  Future<void> sepia() {
    return _$sepiaAsyncAction.run(() => super.sepia());
  }

  final _$hsvAsyncAction = AsyncAction('HomeStoreBase.hsv');

  @override
  Future<void> hsv() {
    return _$hsvAsyncAction.run(() => super.hsv());
  }

  final _$hsvCV2AsyncAction = AsyncAction('HomeStoreBase.hsvCV2');

  @override
  Future<void> hsvCV2() {
    return _$hsvCV2AsyncAction.run(() => super.hsvCV2());
  }

  final _$HomeStoreBaseActionController =
      ActionController(name: 'HomeStoreBase');

  @override
  void negativo() {
    final _$actionInfo = _$HomeStoreBaseActionController.startAction(
        name: 'HomeStoreBase.negativo');
    try {
      return super.negativo();
    } finally {
      _$HomeStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void log() {
    final _$actionInfo =
        _$HomeStoreBaseActionController.startAction(name: 'HomeStoreBase.log');
    try {
      return super.log();
    } finally {
      _$HomeStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void gamma() {
    final _$actionInfo = _$HomeStoreBaseActionController.startAction(
        name: 'HomeStoreBase.gamma');
    try {
      return super.gamma();
    } finally {
      _$HomeStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void restaurarImagem() {
    final _$actionInfo = _$HomeStoreBaseActionController.startAction(
        name: 'HomeStoreBase.restaurarImagem');
    try {
      return super.restaurarImagem();
    } finally {
      _$HomeStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void fechar() {
    final _$actionInfo = _$HomeStoreBaseActionController.startAction(
        name: 'HomeStoreBase.fechar');
    try {
      return super.fechar();
    } finally {
      _$HomeStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void histograma() {
    final _$actionInfo = _$HomeStoreBaseActionController.startAction(
        name: 'HomeStoreBase.histograma');
    try {
      return super.histograma();
    } finally {
      _$HomeStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void negativoRGBMuda(bool? value) {
    final _$actionInfo = _$HomeStoreBaseActionController.startAction(
        name: 'HomeStoreBase.negativoRGBMuda');
    try {
      return super.negativoRGBMuda(value);
    } finally {
      _$HomeStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeGamma(double value) {
    final _$actionInfo = _$HomeStoreBaseActionController.startAction(
        name: 'HomeStoreBase.changeGamma');
    try {
      return super.changeGamma(value);
    } finally {
      _$HomeStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeContrast(double value) {
    final _$actionInfo = _$HomeStoreBaseActionController.startAction(
        name: 'HomeStoreBase.changeContrast');
    try {
      return super.changeContrast(value);
    } finally {
      _$HomeStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
sliderGamma: ${sliderGamma},
sliderContrast: ${sliderContrast},
showHistograma: ${showHistograma},
negativoRGB: ${negativoRGB},
imagem: ${imagem},
imagemOriginal: ${imagemOriginal}
    ''';
  }
}
