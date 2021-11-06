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

  final _$HomeStoreBaseActionController =
      ActionController(name: 'HomeStoreBase');

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
showHistograma: ${showHistograma}
    ''';
  }
}
