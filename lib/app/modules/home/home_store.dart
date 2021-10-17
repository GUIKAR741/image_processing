import 'dart:async';
import 'dart:io';

import 'package:asuka/asuka.dart' as asuka;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_modular/flutter_modular.dart';
import 'package:image/image.dart' as img;
import 'package:image_processing/app/shared/service/image_service.dart';
import 'package:mobx/mobx.dart';

part 'home_store.g.dart';

class HomeStore = HomeStoreBase with _$HomeStore;

abstract class HomeStoreBase with Store {
  final ImageService imageService = Modular.get();

  Future<void> abrirImagem() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowCompression: false,
      dialogTitle: "Abrir Imagem",
    );
    if (result != null) {
      if (kIsWeb){
        imageService.updateImage(img.decodeImage(result.files.single.bytes!)!);
      }else{
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
}
