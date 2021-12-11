// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'convolucao_service.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ConvolucaoService on ConvolucaoServiceBase, Store {
  Computed<List<List<num>>>? _$matrizAtualComputed;

  @override
  List<List<num>> get matrizAtual => (_$matrizAtualComputed ??=
          Computed<List<List<num>>>(() => super.matrizAtual,
              name: 'ConvolucaoServiceBase.matrizAtual'))
      .value;
  Computed<int>? _$tamanhoComputed;

  @override
  int get tamanho => (_$tamanhoComputed ??= Computed<int>(() => super.tamanho,
          name: 'ConvolucaoServiceBase.tamanho'))
      .value;
  Computed<Column>? _$geraFormComputed;

  @override
  Column get geraForm =>
      (_$geraFormComputed ??= Computed<Column>(() => super.geraForm,
              name: 'ConvolucaoServiceBase.geraForm'))
          .value;

  final _$typeAtom = Atom(name: 'ConvolucaoServiceBase.type');

  @override
  Matrizes get type {
    _$typeAtom.reportRead();
    return super.type;
  }

  @override
  set type(Matrizes value) {
    _$typeAtom.reportWrite(value, super.type, () {
      super.type = value;
    });
  }

  final _$matrizesAtom = Atom(name: 'ConvolucaoServiceBase.matrizes');

  @override
  Map<Matrizes, List<List<num>>> get matrizes {
    _$matrizesAtom.reportRead();
    return super.matrizes;
  }

  @override
  set matrizes(Map<Matrizes, List<List<num>>> value) {
    _$matrizesAtom.reportWrite(value, super.matrizes, () {
      super.matrizes = value;
    });
  }

  final _$ConvolucaoServiceBaseActionController =
      ActionController(name: 'ConvolucaoServiceBase');

  @override
  dynamic trocaTipo(Matrizes matriz) {
    final _$actionInfo = _$ConvolucaoServiceBaseActionController.startAction(
        name: 'ConvolucaoServiceBase.trocaTipo');
    try {
      return super.trocaTipo(matriz);
    } finally {
      _$ConvolucaoServiceBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
type: ${type},
matrizes: ${matrizes},
matrizAtual: ${matrizAtual},
tamanho: ${tamanho},
geraForm: ${geraForm}
    ''';
  }
}
