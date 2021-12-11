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
import 'package:image_processing/app/shared/repositories/imagem_repository.dart';
import 'package:mobx/mobx.dart';

part 'home_store.g.dart';

class HomeStore = HomeStoreBase with _$HomeStore;

abstract class HomeStoreBase with Store {
  @observable
  double sliderGamma = 1;
  @observable
  double sliderContrast = 1;
  @observable
  bool showHistograma = false;
  @observable
  bool negativoRGB = false;

  @observable
  Uint8List? imagem;
  @observable
  Uint8List? imagemOriginal;

  String? imagemName;

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
      print(result);
      File(result).writeAsBytesSync(imagem!);
    } else {
      asuka.showSnackBar(
        const SnackBar(
          content: Text('Erro ao Salvar Imagem!'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  void convolucao() {
    // asuka.showDialog(
    //   barrierDismissible: false,
    //   barrierColor: Colors.transparent,
    //   builder: (context) => AlertDialog(
    //     title: const Text("Convolução"),
    //     actions: <Widget>[
    //       TextButton(
    //         child: const Text('Aplicar'),
    //         onPressed: () {
    //           imageService.convolucao(conv.matrizes[conv.type]!);
    //           Navigator.of(context).pop();
    //         },
    //       ),
    //       TextButton(
    //         child: const Text('Fechar'),
    //         onPressed: Navigator.of(context).pop,
    //       ),
    //     ],
    //     content: Observer(
    //       builder: (_) => SingleChildScrollView(
    //         child: Column(
    //           children: [
    //             Row(
    //               children: [
    //                 TextButton(
    //                   onPressed: () => conv.trocaTipo(Matrizes.m3X3),
    //                   child: const Text("3x3"),
    //                 ),
    //                 TextButton(
    //                   onPressed: () => conv.trocaTipo(Matrizes.m5X5),
    //                   child: const Text("5x5"),
    //                 ),
    //                 TextButton(
    //                   onPressed: () => conv.trocaTipo(Matrizes.m7X7),
    //                   child: const Text("7x7"),
    //                 ),
    //                 TextButton(
    //                   onPressed: () => conv.trocaTipo(Matrizes.m9X9),
    //                   child: const Text("9x9"),
    //                 ),
    //               ],
    //             ),
    //             conv.geraForm,
    //           ],
    //         ),
    //       ),
    //     ),
    //   ),
    // );
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
    negativoRGB = false;
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
                  negativoRGB,
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
                value: negativoRGB,
                onChanged: negativoRGBMuda,
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
  void restaurarImagem() {
    imagem = imagemOriginal;
  }

  @action
  void fechar() {
    imagemOriginal = null;
    imagem = null;
  }

  @action
  void histograma() {
    showHistograma = !showHistograma;
  }

  @action
  void negativoRGBMuda(bool? value) {
    negativoRGB = value ?? false;
  }

  @action
  void changeGamma(double value) {
    sliderGamma = value;
  }

  @action
  void changeContrast(double value) {
    sliderContrast = value;
  }
}
