import 'dart:async';
import 'dart:io';

import 'package:asuka/asuka.dart' as asuka;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:image/image.dart' as img;
import 'package:image_processing/app/shared/service/convolucao_service.dart';
import 'package:image_processing/app/shared/service/image_service.dart';
import 'package:mobx/mobx.dart';

part 'home_store.g.dart';

class HomeStore = HomeStoreBase with _$HomeStore;

abstract class HomeStoreBase with Store {
  final ImageService imageService = Modular.get();
  @observable
  double sliderGamma = 1;
  @observable
  double sliderContrast = 1;
  @observable
  bool showHistograma = false;

  Future<void> abrirImagem() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowCompression: false,
      dialogTitle: "Abrir Imagem",
    );
    if (result != null) {
      if (kIsWeb) {
        imageService.updateImage(img.decodeImage(result.files.single.bytes!)!);
      } else {
        File file = File(result.files.single.path!);
        imageService.updateImage(img.decodeImage(file.readAsBytesSync())!);
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
            onPressed: () {
              imageService.convolucao(conv.matrizes[conv.type]!);
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

  void gammaCorrection() {
    asuka.showDialog(
      barrierDismissible: false,
      barrierColor: Colors.transparent,
      builder: (context) => AlertDialog(
        title: const Text("Correção de Gama"),
        actions: <Widget>[
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
                onChangeEnd: (_) =>
                    imageService.transfPot(sliderGamma, sliderContrast),
                min: 0,
                max: 2,
                value: sliderGamma,
                onChanged: changeGamma,
                label: "$sliderGamma",
              ),
              Text(sliderGamma.toStringAsFixed(2)),
              const Text("Contraste:"),
              Slider(
                onChangeEnd: (_) =>
                    imageService.transfPot(sliderGamma, sliderContrast),
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
  void histograma() {
    showHistograma = !showHistograma;
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
