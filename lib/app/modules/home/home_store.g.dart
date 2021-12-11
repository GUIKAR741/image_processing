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

  final _$radioAtom = Atom(name: 'HomeStoreBase.radio');

  @override
  int get radio {
    _$radioAtom.reportRead();
    return super.radio;
  }

  @override
  set radio(int value) {
    _$radioAtom.reportWrite(value, super.radio, () {
      super.radio = value;
    });
  }

  final _$isRGBAtom = Atom(name: 'HomeStoreBase.isRGB');

  @override
  bool get isRGB {
    _$isRGBAtom.reportRead();
    return super.isRGB;
  }

  @override
  set isRGB(bool value) {
    _$isRGBAtom.reportWrite(value, super.isRGB, () {
      super.isRGB = value;
    });
  }

  final _$mostraAtom = Atom(name: 'HomeStoreBase.mostra');

  @override
  bool get mostra {
    _$mostraAtom.reportRead();
    return super.mostra;
  }

  @override
  set mostra(bool value) {
    _$mostraAtom.reportWrite(value, super.mostra, () {
      super.mostra = value;
    });
  }

  final _$equalizaAtom = Atom(name: 'HomeStoreBase.equaliza');

  @override
  bool get equaliza {
    _$equalizaAtom.reportRead();
    return super.equaliza;
  }

  @override
  set equaliza(bool value) {
    _$equalizaAtom.reportWrite(value, super.equaliza, () {
      super.equaliza = value;
    });
  }

  final _$value1Atom = Atom(name: 'HomeStoreBase.value1');

  @override
  double get value1 {
    _$value1Atom.reportRead();
    return super.value1;
  }

  @override
  set value1(double value) {
    _$value1Atom.reportWrite(value, super.value1, () {
      super.value1 = value;
    });
  }

  final _$value2Atom = Atom(name: 'HomeStoreBase.value2');

  @override
  double get value2 {
    _$value2Atom.reportRead();
    return super.value2;
  }

  @override
  set value2(double value) {
    _$value2Atom.reportWrite(value, super.value2, () {
      super.value2 = value;
    });
  }

  final _$value3Atom = Atom(name: 'HomeStoreBase.value3');

  @override
  double get value3 {
    _$value3Atom.reportRead();
    return super.value3;
  }

  @override
  set value3(double value) {
    _$value3Atom.reportWrite(value, super.value3, () {
      super.value3 = value;
    });
  }

  final _$valuesAtom = Atom(name: 'HomeStoreBase.values');

  @override
  ObservableList<dynamic> get values {
    _$valuesAtom.reportRead();
    return super.values;
  }

  @override
  set values(ObservableList<dynamic> value) {
    _$valuesAtom.reportWrite(value, super.values, () {
      super.values = value;
    });
  }

  final _$imagemLocalAtom = Atom(name: 'HomeStoreBase.imagemLocal');

  @override
  Uint8List? get imagemLocal {
    _$imagemLocalAtom.reportRead();
    return super.imagemLocal;
  }

  @override
  set imagemLocal(Uint8List? value) {
    _$imagemLocalAtom.reportWrite(value, super.imagemLocal, () {
      super.imagemLocal = value;
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

  final _$histogramaAsyncAction = AsyncAction('HomeStoreBase.histograma');

  @override
  Future<void> histograma() {
    return _$histogramaAsyncAction.run(() => super.histograma());
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
  void laplaciano() {
    final _$actionInfo = _$HomeStoreBaseActionController.startAction(
        name: 'HomeStoreBase.laplaciano');
    try {
      return super.laplaciano();
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
  void changeIsRGB(bool? value) {
    final _$actionInfo = _$HomeStoreBaseActionController.startAction(
        name: 'HomeStoreBase.changeIsRGB');
    try {
      return super.changeIsRGB(value);
    } finally {
      _$HomeStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeMostra(bool? value) {
    final _$actionInfo = _$HomeStoreBaseActionController.startAction(
        name: 'HomeStoreBase.changeMostra');
    try {
      return super.changeMostra(value);
    } finally {
      _$HomeStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeEqualiza(bool? value) {
    final _$actionInfo = _$HomeStoreBaseActionController.startAction(
        name: 'HomeStoreBase.changeEqualiza');
    try {
      return super.changeEqualiza(value);
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
  void changeRadio(int? value) {
    final _$actionInfo = _$HomeStoreBaseActionController.startAction(
        name: 'HomeStoreBase.changeRadio');
    try {
      return super.changeRadio(value);
    } finally {
      _$HomeStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
sliderGamma: ${sliderGamma},
sliderContrast: ${sliderContrast},
radio: ${radio},
isRGB: ${isRGB},
mostra: ${mostra},
equaliza: ${equaliza},
value1: ${value1},
value2: ${value2},
value3: ${value3},
values: ${values},
imagemLocal: ${imagemLocal},
imagem: ${imagem},
imagemOriginal: ${imagemOriginal}
    ''';
  }
}
