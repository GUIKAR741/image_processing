import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:asuka/asuka.dart' as asuka;
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:image/image.dart' as img;
import 'package:image_processing/app/shared/repositories/imagem_repository.dart';
import 'package:image_processing/app/shared/services/convolucao_service.dart';
import 'package:mobx/mobx.dart';

part 'home_store.g.dart';

class HomeStore = HomeStoreBase with _$HomeStore;

abstract class HomeStoreBase with Store {
  @observable
  double sliderGamma = 1;
  @observable
  double sliderContrast = 1;
  @observable
  int radio = 1;
  @observable
  int radioFourrier = 1;
  @observable
  bool isRGB = false;
  @observable
  bool mostra = false;
  @observable
  bool equaliza = false;
  @observable
  double value1 = 0;
  @observable
  double value2 = 0;
  @observable
  double value3 = 0;
  @observable
  double value4 = 0;
  @observable
  double clip = 0;
  @observable
  ObservableMap<String, dynamic> valuesMapped =
      ObservableMap<String, dynamic>();
  @observable
  ObservableList values = ObservableList();

  @observable
  Uint8List? imagemLocal;

  @observable
  Uint8List? imagem;
  @observable
  Uint8List? imagemOriginal;

  String? imagemName;

  @observable
  Uint8List? imagemEsconder;

  String? imagemNameEsconder;

  final ImagemRepository _repository = Modular.get();

  Future<void> abrirImagem() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowCompression: false,
      dialogTitle: "Abrir Imagem",
    );
    if (result != null) {
      if (kIsWeb) {
        imagemName = result.files.single.name;
        imagemOriginal = result.files.single.bytes!;
        imagem = imagemOriginal;
      } else {
        imagemName = result.files.single.name;
        File file = File(result.files.single.path!);
        imagemOriginal = file.readAsBytesSync();
        imagem = imagemOriginal;
      }
    } else {
      asuka.showSnackBar(
        const SnackBar(
          content: Text('Erro ao Abrir Imagem!'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  Future<void> salvarImagem() async {
    String? result = await FilePicker.platform.saveFile(
      dialogTitle: "Salvar Imagem",
      fileName: imagemName,
    );
    if (result != null) {
      String nome = result.split('/').last;
      img.Image image = img.decodeImage(imagem!)!;
      File(result).writeAsBytesSync(img.encodeNamedImage(image, nome)!);
    } else {
      asuka.showSnackBar(
        const SnackBar(
          content: Text('Erro ao Salvar Imagem!'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @action
  Future<void> blackAndWhite() async {
    imagem = null;
    try {
      imagem = (await _repository.blackAndWhite(
        imagemName!,
        imagemOriginal!,
      ))
          .data;
    } on DioError {
      imagem = imagemOriginal;
    }
  }

  @action
  Future<void> grayscalePonderado() async {
    imagem = null;
    try {
      imagem = (await _repository.grayscalePonderado(
        imagemName!,
        imagemOriginal!,
      ))
          .data;
    } on DioError {
      imagem = imagemOriginal;
    }
  }

  @action
  Future<void> grayscaleMedia() async {
    imagem = null;
    try {
      imagem = (await _repository.grayscaleMedia(
        imagemName!,
        imagemOriginal!,
      ))
          .data;
    } on DioError {
      imagem = imagemOriginal;
    }
  }

  @action
  Future<void> sepia() async {
    imagem = null;
    try {
      imagem = (await _repository.sepia(
        imagemName!,
        imagemOriginal!,
      ))
          .data;
    } on DioError {
      imagem = imagemOriginal;
    }
  }

  @action
  Future<void> hsv() async {
    imagem = null;
    try {
      imagem = (await _repository.hsv(
        imagemName!,
        imagemOriginal!,
      ))
          .data;
    } on DioError {
      imagem = imagemOriginal;
    }
  }

  @action
  Future<void> hsvCV2() async {
    imagem = null;
    try {
      imagem = (await _repository.hsvCV2(
        imagemName!,
        imagemOriginal!,
      ))
          .data;
    } on DioError {
      imagem = imagemOriginal;
    }
  }

  @action
  void negativo() {
    isRGB = false;
    asuka.showDialog(
      barrierDismissible: false,
      barrierColor: Colors.transparent,
      builder: (context) => AlertDialog(
        title: const Text("Negativo"),
        actions: <Widget>[
          TextButton(
            child: const Text('OK'),
            onPressed: () async {
              imagem = null;
              try {
                imagem = (await _repository.negativo(
                  imagemName!,
                  imagemOriginal!,
                  isRGB,
                ))
                    .data;
              } on DioError {
                imagem = imagemOriginal;
              }
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text('Fechar'),
            onPressed: Navigator.of(context).pop,
          ),
        ],
        content: Observer(
          builder: (_) => Row(
            children: [
              Checkbox(
                value: isRGB,
                onChanged: changeIsRGB,
              ),
              const Text('RGB?'),
            ],
          ),
        ),
      ),
    );
  }

  @action
  void log() {
    sliderContrast = 1;
    asuka.showDialog(
      barrierDismissible: false,
      barrierColor: Colors.transparent,
      builder: (context) => AlertDialog(
        title: const Text("Transformação Logaritmica"),
        actions: <Widget>[
          TextButton(
            child: const Text('OK'),
            onPressed: () async {
              imagem = null;
              try {
                imagem = (await _repository.log(
                  imagemName!,
                  imagemOriginal!,
                  sliderContrast,
                ))
                    .data;
              } on DioError {
                imagem = imagemOriginal;
              }
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text('Fechar'),
            onPressed: Navigator.of(context).pop,
          ),
        ],
        content: Observer(
          builder: (_) => Column(
            children: [
              const Text("Contraste:"),
              Slider(
                min: 0,
                max: 2,
                value: sliderContrast,
                onChanged: changeContrast,
                label: "$sliderContrast",
              ),
              Text(sliderContrast.toStringAsFixed(2)),
            ],
          ),
        ),
      ),
    );
  }

  @action
  void gamma() {
    sliderGamma = 1;
    sliderContrast = 1;
    asuka.showDialog(
      barrierDismissible: false,
      barrierColor: Colors.transparent,
      builder: (context) => AlertDialog(
        title: const Text("Correção de Gama"),
        actions: <Widget>[
          TextButton(
            child: const Text('OK'),
            onPressed: () async {
              imagem = null;
              try {
                imagem = (await _repository.gamma(
                  imagemName!,
                  imagemOriginal!,
                  sliderContrast,
                  sliderGamma,
                ))
                    .data;
              } on DioError {
                imagem = imagemOriginal;
              }
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text('Fechar'),
            onPressed: Navigator.of(context).pop,
          ),
        ],
        content: Observer(
          builder: (_) => Column(
            children: [
              const Text("Gamma:"),
              Slider(
                min: 0,
                max: 2,
                value: sliderGamma,
                onChanged: changeGamma,
                label: "$sliderGamma",
              ),
              Text(sliderGamma.toStringAsFixed(2)),
              const Text("Contraste:"),
              Slider(
                min: 0,
                max: 2,
                value: sliderContrast,
                onChanged: changeContrast,
                label: "$sliderContrast",
              ),
              Text(sliderContrast.toStringAsFixed(2)),
            ],
          ),
        ),
      ),
    );
  }

  @action
  Future<void> histograma() async {
    isRGB = false;
    equaliza = false;
    radio = 1;
    values.clear();
    value1 = 0;
    value2 = 0;
    value3 = 0;
    void attImagem(Response v) {
      imagemLocal = v.data;
    }

    void atualizaHist({
      bool mostraHistograma = true,
      void Function(Response v)? callback,
    }) {
      callback = callback ?? attImagem;
      try {
        imagemLocal = null;
        _repository
            .histograma(
              imagemName!,
              imagemOriginal!,
              mostraHistograma: mostraHistograma,
              isRGB: isRGB,
              equalizar: equaliza,
              espaco: values.isNotEmpty ? values : null,
            )
            .then(callback);
      } on DioError {
        imagem = imagemOriginal;
      }
    }

    atualizaHist();
    asuka.showDialog(
      barrierDismissible: false,
      barrierColor: Colors.transparent,
      builder: (context) => AlertDialog(
        title: const Text("Intensidades"),
        actions: <Widget>[
          TextButton(
            child: const Text('OK'),
            onPressed: () async {
              imagem = null;
              atualizaHist(
                mostraHistograma: false,
                callback: (v) => imagem = v.data,
              );
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text('Fechar'),
            onPressed: Navigator.of(context).pop,
          ),
        ],
        content: Observer(
          builder: (_) => SingleChildScrollView(
            child: Column(
              children: [
                Observer(
                  builder: (_) => imagemLocal != null
                      ? Column(
                          children: [
                            Image.memory(
                              imagemLocal!,
                            ),
                          ],
                        )
                      : const CircularProgressIndicator(),
                ),
                Row(children: [
                  Radio(
                    value: 1,
                    groupValue: radio,
                    onChanged: changeRadio,
                  ),
                  const Text('Equalização'),
                  Radio(
                    value: 2,
                    groupValue: radio,
                    onChanged: changeRadio,
                  ),
                  const Text('Modificar'),
                ]),
                Observer(
                  builder: (_) => radio == 1
                      ? Column(
                          children: [
                            Row(
                              children: [
                                Checkbox(
                                  value: isRGB,
                                  onChanged: changeIsRGB,
                                ),
                                const Text('RGB?'),
                              ],
                            ),
                            Row(
                              children: [
                                Checkbox(
                                  value: equaliza,
                                  onChanged: changeEqualiza,
                                ),
                                const Text('Equaliza?'),
                              ],
                            ),
                          ],
                        )
                      : Column(
                          children: [
                            Column(
                              children: values
                                  .map(
                                    (i) => ListTile(
                                      title: Text(
                                          "X1: ${i[0]}, X2: ${i[1]}, Cor: ${i[2]}"),
                                      trailing: IconButton(
                                        icon: const Icon(Icons.remove),
                                        onPressed: () => values.remove(i),
                                      ),
                                    ),
                                  )
                                  .toList(),
                            ),
                            Text("X1: ${value1.toStringAsFixed(0)}"),
                            Slider(
                              min: 0,
                              max: 255,
                              value: value1,
                              onChanged: (v) => value1 = v,
                            ),
                            Text("X2: ${value2.toStringAsFixed(0)}"),
                            Slider(
                              min: 0,
                              max: 255,
                              value: value2,
                              onChanged: (v) => value2 = v,
                            ),
                            Text("Cor: ${value3.toStringAsFixed(0)}"),
                            Slider(
                              min: 0,
                              max: 255,
                              value: value3,
                              onChanged: (v) => value3 = v,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                values.add([
                                  value1.toInt(),
                                  value2.toInt(),
                                  value3.toInt()
                                ]);
                              },
                              child: const Text("Adicionar"),
                            ),
                          ],
                        ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: atualizaHist,
                    child: const Text("Atualiza"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void convolucao() {
    ConvolucaoService conv = Modular.get();
    asuka.showDialog(
      barrierDismissible: false,
      barrierColor: Colors.transparent,
      builder: (context) => AlertDialog(
        title: const Text("Convolução"),
        actions: <Widget>[
          TextButton(
            child: const Text('Aplicar'),
            onPressed: () async {
              imagem = null;
              try {
                List listaMatriz = [];
                for (var element in conv.matrizAtual) {
                  listaMatriz.addAll(element);
                }
                imagem = (await _repository.convolucao(
                  imagemName!,
                  imagemOriginal!,
                  conv.tamanho,
                  listaMatriz,
                ))
                    .data;
              } on DioError {
                imagem = imagemOriginal;
              }
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text('Fechar'),
            onPressed: Navigator.of(context).pop,
          ),
        ],
        content: Observer(
          builder: (_) => SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    TextButton(
                      onPressed: () => conv.trocaTipo(Matrizes.m3X3),
                      child: const Text("3x3"),
                    ),
                    TextButton(
                      onPressed: () => conv.trocaTipo(Matrizes.m5X5),
                      child: const Text("5x5"),
                    ),
                    TextButton(
                      onPressed: () => conv.trocaTipo(Matrizes.m7X7),
                      child: const Text("7x7"),
                    ),
                    TextButton(
                      onPressed: () => conv.trocaTipo(Matrizes.m9X9),
                      child: const Text("9x9"),
                    ),
                  ],
                ),
                conv.geraForm,
              ],
            ),
          ),
        ),
      ),
    );
  }

  @action
  void laplaciano() {
    radio = 0;
    asuka.showDialog(
      barrierDismissible: false,
      barrierColor: Colors.transparent,
      builder: (context) => AlertDialog(
        title: const Text("Laplaciano/High Boost"),
        actions: <Widget>[
          TextButton(
            child: const Text('OK'),
            onPressed: () async {
              Navigator.of(context).pop();
              imagem = null;
              try {
                imagem = (await _repository.laplaciano(
                  imagemName!,
                  imagemOriginal!,
                  radio,
                ))
                    .data;
              } on DioError {
                imagem = imagemOriginal;
              }
            },
          ),
          TextButton(
            child: const Text('Fechar'),
            onPressed: Navigator.of(context).pop,
          ),
        ],
        content: Observer(
          builder: (_) => SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Radio(
                        value: 0,
                        groupValue: radio,
                        onChanged: changeRadio,
                      ),
                      const Text('[ 0,-1, 0]\n[-1, 4,-1]\n[ 0,-1, 0]'),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Radio(
                        value: 1,
                        groupValue: radio,
                        onChanged: changeRadio,
                      ),
                      const Text('[-1,-1,-1]\n[-1, 8,-1]\n[-1,-1,-1]'),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Radio(
                        value: 2,
                        groupValue: radio,
                        onChanged: changeRadio,
                      ),
                      const Text('[ 0, 1, 0]\n[ 1,-4, 1]\n[ 0, 1, 0]'),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Radio(
                        value: 3,
                        groupValue: radio,
                        onChanged: changeRadio,
                      ),
                      const Text('[ 1, 1, 1]\n[ 1,-8, 1]\n[ 1, 1, 1]'),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Radio(
                        value: 4,
                        groupValue: radio,
                        onChanged: changeRadio,
                      ),
                      const Text(
                          '[1/16,2/16,1/16]\n[2/16,4/16,2/16]\n[1/16,2/16,1/16]'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @action
  void sobel() {
    radio = 0;
    isRGB = false;
    asuka.showDialog(
      barrierDismissible: false,
      barrierColor: Colors.transparent,
      builder: (context) => AlertDialog(
        title: const Text("Sobel"),
        actions: <Widget>[
          TextButton(
            child: const Text('OK'),
            onPressed: () async {
              Navigator.of(context).pop();
              imagem = null;
              try {
                imagem = (await _repository.sobel(
                  imagemName!,
                  imagemOriginal!,
                  radio,
                  isRGB,
                ))
                    .data;
              } on DioError {
                imagem = imagemOriginal;
              }
            },
          ),
          TextButton(
            child: const Text('Fechar'),
            onPressed: Navigator.of(context).pop,
          ),
        ],
        content: Observer(
          builder: (_) => SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    Checkbox(
                      value: isRGB,
                      onChanged: changeIsRGB,
                    ),
                    const Text('Normaliza?'),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Radio(
                        value: 0,
                        groupValue: radio,
                        onChanged: changeRadio,
                      ),
                      const Text('X'),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Radio(
                        value: 1,
                        groupValue: radio,
                        onChanged: changeRadio,
                      ),
                      const Text('Y'),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Radio(
                        value: 2,
                        groupValue: radio,
                        onChanged: changeRadio,
                      ),
                      const Text('X & Y'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void mean() {
    value1 = 3;
    asuka.showDialog(
      barrierDismissible: false,
      barrierColor: Colors.transparent,
      builder: (context) => AlertDialog(
        title: const Text("Filtro Media"),
        actions: <Widget>[
          TextButton(
            child: const Text('Aplicar'),
            onPressed: () async {
              Navigator.of(context).pop();
              imagem = null;
              try {
                imagem = (await _repository.mean(
                  imagemName!,
                  imagemOriginal!,
                  value1.toInt(),
                ))
                    .data;
              } on DioError {
                imagem = imagemOriginal;
              }
            },
          ),
          TextButton(
            child: const Text('Fechar'),
            onPressed: Navigator.of(context).pop,
          ),
        ],
        content: Observer(
          builder: (_) => SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    TextButton(
                      onPressed: () => value1 = 3,
                      child: Text(
                        "3x3",
                        style: TextStyle(
                          color: value1 == 3 ? Colors.black : null,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () => value1 = 5,
                      child: Text(
                        "5x5",
                        style: TextStyle(
                          color: value1 == 5 ? Colors.black : null,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () => value1 = 7,
                      child: Text(
                        "7x7",
                        style: TextStyle(
                          color: value1 == 7 ? Colors.black : null,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () => value1 = 9,
                      child: Text(
                        "9x9",
                        style: TextStyle(
                          color: value1 == 9 ? Colors.black : null,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void geometric() {
    value1 = 3;
    asuka.showDialog(
      barrierDismissible: false,
      barrierColor: Colors.transparent,
      builder: (context) => AlertDialog(
        title: const Text("Filtro Media Geometrica"),
        actions: <Widget>[
          TextButton(
            child: const Text('Aplicar'),
            onPressed: () async {
              Navigator.of(context).pop();
              imagem = null;
              try {
                imagem = (await _repository.geometric(
                  imagemName!,
                  imagemOriginal!,
                  value1.toInt(),
                ))
                    .data;
              } on DioError {
                imagem = imagemOriginal;
              }
            },
          ),
          TextButton(
            child: const Text('Fechar'),
            onPressed: Navigator.of(context).pop,
          ),
        ],
        content: Observer(
          builder: (_) => SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    TextButton(
                      onPressed: () => value1 = 3,
                      child: Text(
                        "3x3",
                        style: TextStyle(
                          color: value1 == 3 ? Colors.black : null,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () => value1 = 5,
                      child: Text(
                        "5x5",
                        style: TextStyle(
                          color: value1 == 5 ? Colors.black : null,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () => value1 = 7,
                      child: Text(
                        "7x7",
                        style: TextStyle(
                          color: value1 == 7 ? Colors.black : null,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () => value1 = 9,
                      child: Text(
                        "9x9",
                        style: TextStyle(
                          color: value1 == 9 ? Colors.black : null,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void harmonic() {
    value1 = 3;
    asuka.showDialog(
      barrierDismissible: false,
      barrierColor: Colors.transparent,
      builder: (context) => AlertDialog(
        title: const Text("Filtro Media Harmonica"),
        actions: <Widget>[
          TextButton(
            child: const Text('Aplicar'),
            onPressed: () async {
              Navigator.of(context).pop();
              imagem = null;
              try {
                imagem = (await _repository.harmonic(
                  imagemName!,
                  imagemOriginal!,
                  value1.toInt(),
                ))
                    .data;
              } on DioError {
                imagem = imagemOriginal;
              }
            },
          ),
          TextButton(
            child: const Text('Fechar'),
            onPressed: Navigator.of(context).pop,
          ),
        ],
        content: Observer(
          builder: (_) => SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    TextButton(
                      onPressed: () => value1 = 3,
                      child: Text(
                        "3x3",
                        style: TextStyle(
                          color: value1 == 3 ? Colors.black : null,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () => value1 = 5,
                      child: Text(
                        "5x5",
                        style: TextStyle(
                          color: value1 == 5 ? Colors.black : null,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () => value1 = 7,
                      child: Text(
                        "7x7",
                        style: TextStyle(
                          color: value1 == 7 ? Colors.black : null,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () => value1 = 9,
                      child: Text(
                        "9x9",
                        style: TextStyle(
                          color: value1 == 9 ? Colors.black : null,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void contraHarmonic() {
    value1 = 3;
    value2 = 0;
    asuka.showDialog(
      barrierDismissible: false,
      barrierColor: Colors.transparent,
      builder: (context) => AlertDialog(
        title: const Text("Filtro Media Contra Harmonica"),
        actions: <Widget>[
          TextButton(
            child: const Text('Aplicar'),
            onPressed: () async {
              Navigator.of(context).pop();
              imagem = null;
              try {
                imagem = (await _repository.contraHarmonic(
                  imagemName!,
                  imagemOriginal!,
                  value1.toInt(),
                  value2,
                ))
                    .data;
              } on DioError {
                imagem = imagemOriginal;
              }
            },
          ),
          TextButton(
            child: const Text('Fechar'),
            onPressed: Navigator.of(context).pop,
          ),
        ],
        content: Observer(
          builder: (_) => SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    TextButton(
                      onPressed: () => value1 = 3,
                      child: Text(
                        "3x3",
                        style: TextStyle(
                          color: value1 == 3 ? Colors.black : null,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () => value1 = 5,
                      child: Text(
                        "5x5",
                        style: TextStyle(
                          color: value1 == 5 ? Colors.black : null,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () => value1 = 7,
                      child: Text(
                        "7x7",
                        style: TextStyle(
                          color: value1 == 7 ? Colors.black : null,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () => value1 = 9,
                      child: Text(
                        "9x9",
                        style: TextStyle(
                          color: value1 == 9 ? Colors.black : null,
                        ),
                      ),
                    ),
                  ],
                ),
                Text("Q: ${value2.toStringAsFixed(2)}"),
                Slider(
                  min: -2,
                  max: 2,
                  value: value2,
                  onChanged: (v) => value2 = v,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @action
  void rgb2hsv() {
    value1 = 0;
    value2 = 0;
    value3 = 0;
    valuesMapped.clear();
    asuka.showDialog(
      barrierDismissible: false,
      barrierColor: Colors.transparent,
      builder: (context) => AlertDialog(
        title: const Text("RGB para HSV"),
        actions: <Widget>[
          TextButton(
            child: const Text('Fechar'),
            onPressed: Navigator.of(context).pop,
          ),
        ],
        content: Observer(
          builder: (_) => SingleChildScrollView(
            child: Column(
              children: [
                Text("R: ${value1.toStringAsFixed(0)}"),
                Slider(
                  min: 0,
                  max: 255,
                  value: value1,
                  onChanged: (v) => value1 = v,
                ),
                Text("G: ${value2.toStringAsFixed(0)}"),
                Slider(
                  min: 0,
                  max: 255,
                  value: value2,
                  onChanged: (v) => value2 = v,
                ),
                Text("B: ${value3.toStringAsFixed(0)}"),
                Slider(
                  min: 0,
                  max: 255,
                  value: value3,
                  onChanged: (v) => value3 = v,
                ),
                ElevatedButton(
                  onPressed: () async {
                    valuesMapped = ((await _repository.rgb2hsv(
                      value1.toInt(),
                      value2.toInt(),
                      value3.toInt(),
                    ))
                            .data as Map<String, dynamic>)
                        .asObservable();
                    print(valuesMapped.runtimeType);
                  },
                  child: const Text("Converter"),
                ),
                if (valuesMapped.isNotEmpty)
                  ListTile(
                    title: Text(
                        "H: ${valuesMapped['h']}, S: ${valuesMapped['s']}, V: ${valuesMapped['v']}"),
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @action
  void chromakey() {
    value1 = 0;
    value2 = 0;
    value3 = 0;
    value4 = 0;
    asuka.showDialog(
      barrierDismissible: false,
      barrierColor: Colors.transparent,
      builder: (context) => AlertDialog(
        title: const Text("Chroma Key"),
        actions: <Widget>[
          TextButton(
            child: const Text('Aplicar'),
            onPressed: () async {
              Navigator.of(context).pop();
              imagem = null;
              try {
                imagem = (await _repository.chromakey(
                  imagemName!,
                  imagemOriginal!,
                  value1.toInt(),
                  value2.toInt(),
                  value3.toInt(),
                  value4.toInt(),
                ))
                    .data;
              } on DioError {
                imagem = imagemOriginal;
              }
            },
          ),
          TextButton(
            child: const Text('Fechar'),
            onPressed: Navigator.of(context).pop,
          ),
        ],
        content: Observer(
          builder: (_) => SingleChildScrollView(
            child: Column(
              children: [
                Text("R: ${value1.toStringAsFixed(0)}"),
                Slider(
                  min: 0,
                  max: 255,
                  value: value1,
                  onChanged: (v) => value1 = v,
                ),
                Text("G: ${value2.toStringAsFixed(0)}"),
                Slider(
                  min: 0,
                  max: 255,
                  value: value2,
                  onChanged: (v) => value2 = v,
                ),
                Text("B: ${value3.toStringAsFixed(0)}"),
                Slider(
                  min: 0,
                  max: 255,
                  value: value3,
                  onChanged: (v) => value3 = v,
                ),
                Text("Distancia da Cor: ${value4.toStringAsFixed(0)}"),
                Slider(
                  min: 0,
                  max: 255,
                  value: value4,
                  onChanged: (v) => value4 = v,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @action
  void escala() {
    value1 = 1;
    value2 = 1;
    radio = 1;
    asuka.showDialog(
      barrierDismissible: false,
      barrierColor: Colors.transparent,
      builder: (context) => AlertDialog(
        title: const Text("Escala"),
        actions: <Widget>[
          TextButton(
            child: const Text('Aplicar'),
            onPressed: () async {
              Navigator.of(context).pop();
              imagem = null;
              try {
                imagem = (await _repository.escala(
                  imagemName!,
                  imagemOriginal!,
                  value1,
                  value2,
                  radio,
                ))
                    .data;
              } on DioError {
                imagem = imagemOriginal;
              }
            },
          ),
          TextButton(
            child: const Text('Fechar'),
            onPressed: Navigator.of(context).pop,
          ),
        ],
        content: Observer(
          builder: (_) => SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    Radio(
                      value: 1,
                      groupValue: radio,
                      onChanged: changeRadio,
                    ),
                    const Text('Pixel Mais Proximo'),
                  ],
                ),
                Row(
                  children: [
                    Radio(
                      value: 2,
                      groupValue: radio,
                      onChanged: changeRadio,
                    ),
                    const Text('Bi-Linear'),
                  ],
                ),
                Text("Escala X: ${value1.toStringAsFixed(2)}"),
                Slider(
                  min: 0,
                  max: 2,
                  value: value1,
                  onChanged: (v) => value1 = v,
                ),
                Text("Escala Y: ${value2.toStringAsFixed(2)}"),
                Slider(
                  min: 0,
                  max: 2,
                  value: value2,
                  onChanged: (v) => value2 = v,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @action
  void rotacao() {
    value1 = 0;
    asuka.showDialog(
      barrierDismissible: false,
      barrierColor: Colors.transparent,
      builder: (context) => AlertDialog(
        title: const Text("Filtro Media Contra Harmonica"),
        actions: <Widget>[
          TextButton(
            child: const Text('Aplicar'),
            onPressed: () async {
              Navigator.of(context).pop();
              imagem = null;
              try {
                imagem = (await _repository.rotacao(
                  imagemName!,
                  imagemOriginal!,
                  value1.toInt(),
                ))
                    .data;
              } on DioError {
                imagem = imagemOriginal;
              }
            },
          ),
          TextButton(
            child: const Text('Fechar'),
            onPressed: Navigator.of(context).pop,
          ),
        ],
        content: Observer(
          builder: (_) => SingleChildScrollView(
            child: Column(
              children: [
                Text("Angulo: ${value1.toStringAsFixed(0)}"),
                Slider(
                  min: 0,
                  max: 360,
                  value: value1,
                  onChanged: (v) => value1 = v,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @action
  void encriptar() {
    radio = 1;
    isRGB = false;
    imagemEsconder = null;
    imagemNameEsconder = null;
    Future<void> abrirImg() async {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowCompression: false,
        dialogTitle: "Abrir Imagem",
      );
      if (result != null) {
        if (kIsWeb) {
          imagemNameEsconder = result.files.single.name;
          imagemEsconder = result.files.single.bytes!;
        } else {
          imagemNameEsconder = result.files.single.name;
          File file = File(result.files.single.path!);
          imagemEsconder = file.readAsBytesSync();
        }
        isRGB = true;
      } else {
        asuka.showSnackBar(
          const SnackBar(
            content: Text('Erro ao Abrir Imagem!'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    }

    asuka.showDialog(
      barrierDismissible: false,
      barrierColor: Colors.transparent,
      builder: (context) => AlertDialog(
        title: const Text("Criptografar"),
        actions: <Widget>[
          Observer(
            builder: (_) => isRGB == true
                ? TextButton(
                    child: const Text('Aplicar'),
                    onPressed: () async {
                      Navigator.of(context).pop();
                      imagem = null;
                      try {
                        imagem = (await _repository.estenografia(
                          imagemName!,
                          imagemOriginal!,
                          radio,
                          imagemName2: imagemNameEsconder,
                          imagem2: imagemEsconder,
                        ))
                            .data;
                      } on DioError {
                        imagem = imagemOriginal;
                      }
                    },
                  )
                : Container(),
          ),
          TextButton(
            child: const Text('Fechar'),
            onPressed: Navigator.of(context).pop,
          ),
        ],
        content: Observer(
          builder: (_) => SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    Radio(
                      value: 1,
                      groupValue: radio,
                      onChanged: changeRadio,
                    ),
                    const Text('LSB'),
                  ],
                ),
                Row(
                  children: [
                    Radio(
                      value: 3,
                      groupValue: radio,
                      onChanged: changeRadio,
                    ),
                    const Text('Padrão'),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: abrirImg,
                    child: const Text("Abrir Imagem para Esconder"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @action
  void decriptar() {
    radio = 2;
    asuka.showDialog(
      barrierDismissible: false,
      barrierColor: Colors.transparent,
      builder: (context) => AlertDialog(
        title: const Text("Descriptografar"),
        actions: <Widget>[
          TextButton(
            child: const Text('Aplicar'),
            onPressed: () async {
              Navigator.of(context).pop();
              imagem = null;
              try {
                imagem = (await _repository.estenografia(
                  imagemName!,
                  imagemOriginal!,
                  radio,
                ))
                    .data;
              } on DioError {
                imagem = imagemOriginal;
              }
            },
          ),
          TextButton(
            child: const Text('Fechar'),
            onPressed: Navigator.of(context).pop,
          ),
        ],
        content: Observer(
          builder: (_) => SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    Radio(
                      value: 2,
                      groupValue: radio,
                      onChanged: changeRadio,
                    ),
                    const Text('LSB'),
                  ],
                ),
                Row(
                  children: [
                    Radio(
                      value: 4,
                      groupValue: radio,
                      onChanged: changeRadio,
                    ),
                    const Text('Padrão'),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @action
  Future<void> fourrier() async {
    radio = 1;
    radioFourrier = 1;
    values.clear();
    value1 = 0;
    value2 = 0;
    value3 = 0;
    value4 = 0;
    clip = 1000;
    isRGB = false;
    imagemLocal = null;
    int w = 2000;
    int h = 2000;
    void attImagem(Response v) {
      imagemLocal = v.data;
    }

    void atualizaTranf({
      bool mostraTransf = true,
      void Function(Response v)? callback,
    }) {
      callback = callback ?? attImagem;
      isRGB = true;
      try {
        imagemLocal = null;
        switch (radio) {
          case 1:
            _repository
                .fourrier(
                  imagemName!,
                  imagemOriginal!,
                )
                .then(callback);
            break;
          case 2:
            _repository
                .fourrierManual(
                  imagemName!,
                  imagemOriginal!,
                  mostraTransf: mostraTransf,
                  clip: clip.toInt(),
                  espaco: values,
                )
                .then(callback);
            break;
          default:
            _repository
                .fourrierFiltros(
                  imagemName!,
                  imagemOriginal!,
                  mostraTransf: mostraTransf,
                  clip: clip.toInt(),
                  tipo: radioFourrier.toInt(),
                  raio: value1.toInt(),
                  raioInterno: value2.toInt(),
                  sigma: value3.toInt(),
                )
                .then(callback);
            break;
        }
      } on DioError {
        imagem = imagemOriginal;
      }
    }

    asuka.showDialog(
      barrierDismissible: false,
      barrierColor: Colors.transparent,
      builder: (context) => AlertDialog(
        title: const Text("Intensidades"),
        actions: <Widget>[
          Observer(
            builder: (_) => radio != 1
                ? TextButton(
                    child: const Text('OK'),
                    onPressed: () async {
                      imagem = null;
                      atualizaTranf(
                        mostraTransf: false,
                        callback: (v) => imagem = v.data,
                      );
                      Navigator.of(context).pop();
                    },
                  )
                : Container(),
          ),
          TextButton(
            child: const Text('Fechar'),
            onPressed: Navigator.of(context).pop,
          ),
        ],
        content: Observer(
          builder: (_) => SingleChildScrollView(
            child: Column(
              children: [
                Observer(
                  builder: (_) => isRGB == false
                      ? Container()
                      : imagemLocal != null
                          ? Column(
                              children: [
                                Image.memory(
                                  imagemLocal!,
                                  width: radio != 1 ? 1000 : null,
                                  height: radio != 1 ? 1000 : null,
                                ),
                              ],
                            )
                          : const CircularProgressIndicator(),
                ),
                Row(children: [
                  Radio(
                    value: 1,
                    groupValue: radio,
                    onChanged: changeRadio,
                  ),
                  const Text('Fourrier Manual 50x50'),
                ]),
                Row(children: [
                  Radio(
                    value: 2,
                    groupValue: radio,
                    onChanged: changeRadio,
                  ),
                  const Text('Filtros Manual'),
                ]),
                Row(children: [
                  Radio(
                    value: 3,
                    groupValue: radio,
                    onChanged: changeRadio,
                  ),
                  const Text('Filtros'),
                ]),
                Observer(
                  builder: (_) => radio == 1
                      ? Container()
                      : radio == 2
                          ? Column(
                              children: [
                                Column(
                                  children: values
                                      .map(
                                        (i) => ListTile(
                                          title: Text(
                                              "(X1, Y1): (${i[0]}, ${i[1]}), (X2, Y2): (${i[2]}, ${i[3]})"),
                                          trailing: IconButton(
                                            icon: const Icon(Icons.remove),
                                            onPressed: () => values.remove(i),
                                          ),
                                        ),
                                      )
                                      .toList(),
                                ),
                                Text("Clip: ${clip.toStringAsFixed(0)}"),
                                Slider(
                                  min: 0,
                                  max: 5000,
                                  value: clip,
                                  onChanged: (v) => clip = v,
                                ),
                                Text("X1: ${value1.toStringAsFixed(0)}"),
                                Slider(
                                  min: 0,
                                  max: w.toDouble(),
                                  value: value1,
                                  onChanged: (v) => value1 = v,
                                ),
                                Text("Y1: ${value2.toStringAsFixed(0)}"),
                                Slider(
                                  min: 0,
                                  max: h.toDouble(),
                                  value: value2,
                                  onChanged: (v) => value2 = v,
                                ),
                                Text("X2: ${value3.toStringAsFixed(0)}"),
                                Slider(
                                  min: 0,
                                  max: w.toDouble(),
                                  value: value3,
                                  onChanged: (v) => value3 = v,
                                ),
                                Text("Y2: ${value4.toStringAsFixed(0)}"),
                                Slider(
                                  min: 0,
                                  max: h.toDouble(),
                                  value: value4,
                                  onChanged: (v) => value4 = v,
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    values.add([
                                      value1.toInt(),
                                      value2.toInt(),
                                      value3.toInt(),
                                      value4.toInt(),
                                    ]);
                                  },
                                  child: const Text("Adicionar"),
                                ),
                              ],
                            )
                          : Column(
                              children: [
                                Text("Clip: ${clip.toStringAsFixed(0)}"),
                                Slider(
                                  min: 0,
                                  max: 5000,
                                  value: clip,
                                  onChanged: (v) => clip = v,
                                ),
                                Row(
                                  children: [
                                    Radio(
                                      value: 1,
                                      groupValue: radioFourrier,
                                      onChanged: changeRadioFourrier,
                                    ),
                                    const Text('Ideal Alta'),
                                    Radio(
                                      value: 2,
                                      groupValue: radioFourrier,
                                      onChanged: changeRadioFourrier,
                                    ),
                                    const Text('Ideal Baixa'),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Radio(
                                      value: 3,
                                      groupValue: radioFourrier,
                                      onChanged: changeRadioFourrier,
                                    ),
                                    const Text('Gaussiano Alta'),
                                    Radio(
                                      value: 4,
                                      groupValue: radioFourrier,
                                      onChanged: changeRadioFourrier,
                                    ),
                                    const Text('Gaussiano Baixa'),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Radio(
                                      value: 5,
                                      groupValue: radioFourrier,
                                      onChanged: changeRadioFourrier,
                                    ),
                                    const Text('Faixa Ideal Alta'),
                                    Radio(
                                      value: 6,
                                      groupValue: radioFourrier,
                                      onChanged: changeRadioFourrier,
                                    ),
                                    const Text('Faixa Ideal Baixa'),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Radio(
                                      value: 7,
                                      groupValue: radioFourrier,
                                      onChanged: changeRadioFourrier,
                                    ),
                                    const Text('Faixa Gaussiano Alta'),
                                    Radio(
                                      value: 8,
                                      groupValue: radioFourrier,
                                      onChanged: changeRadioFourrier,
                                    ),
                                    const Text('Faixa Gaussiano Baixa'),
                                  ],
                                ),
                                Text("Raio: ${value1.toStringAsFixed(0)}"),
                                Slider(
                                  min: 0,
                                  max: 1000,
                                  value: value1,
                                  onChanged: (v) => value1 = v,
                                ),
                                if (radioFourrier == 5 ||
                                    radioFourrier == 6 ||
                                    radioFourrier == 7 ||
                                    radioFourrier == 8)
                                  Text(
                                      "Raio Interno: ${value2.toStringAsFixed(0)}"),
                                if (radioFourrier == 5 ||
                                    radioFourrier == 6 ||
                                    radioFourrier == 7 ||
                                    radioFourrier == 8)
                                  Slider(
                                    min: 0,
                                    max: 999,
                                    value: value2,
                                    onChanged: (v) => value2 = v,
                                  ),
                                if (radioFourrier == 3 ||
                                    radioFourrier == 4 ||
                                    radioFourrier == 7 ||
                                    radioFourrier == 8)
                                  Text("Sigma: ${value3.toStringAsFixed(0)}"),
                                if (radioFourrier == 3 ||
                                    radioFourrier == 4 ||
                                    radioFourrier == 7 ||
                                    radioFourrier == 8)
                                  Slider(
                                    min: 0,
                                    max: 1000,
                                    value: value3,
                                    onChanged: (v) => value3 = v,
                                  ),
                              ],
                            ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: atualizaTranf,
                    child: const Text("Atualiza"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @action
  void restaurarImagem() {
    imagem = imagemOriginal;
  }

  @action
  void fechar() {
    imagemOriginal = null;
    imagem = null;
  }

  @action
  void changeIsRGB(bool? value) {
    isRGB = value ?? false;
  }

  @action
  void changeMostra(bool? value) {
    mostra = value ?? false;
  }

  @action
  void changeEqualiza(bool? value) {
    equaliza = value ?? false;
  }

  @action
  void changeGamma(double value) {
    sliderGamma = value;
  }

  @action
  void changeContrast(double value) {
    sliderContrast = value;
  }

  @action
  void changeRadio(int? value) {
    radio = value ?? 1;
  }

  @action
  void changeRadioFourrier(int? value) {
    radioFourrier = value ?? 1;
  }
}
