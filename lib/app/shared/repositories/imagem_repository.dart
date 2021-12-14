import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:image_processing/app/shared/services/dio_service.dart';

import 'base_repository.dart';

class ImagemRepository with BaseRepository {
  final DioService _service = Modular.get();

  Future<Response> blackAndWhite(
    String imagemName,
    Uint8List imagem,
  ) async {
    var formData = FormData.fromMap({
      'imagem': MultipartFile.fromBytes(
        imagem,
        filename: imagemName,
      ),
    });
    return await _service.client.post(
      "${DioService.baseUrl}/blackAndWhite",
      data: formData,
    );
  }

  Future<Response> grayscalePonderado(
    String imagemName,
    Uint8List imagem,
  ) async {
    var formData = FormData.fromMap({
      'imagem': MultipartFile.fromBytes(
        imagem,
        filename: imagemName,
      ),
    });
    return await _service.client.post(
      "${DioService.baseUrl}/grayscalePonderado",
      data: formData,
    );
  }

  Future<Response> grayscaleMedia(String imagemName, Uint8List imagem) async {
    var formData = FormData.fromMap({
      'imagem': MultipartFile.fromBytes(
        imagem,
        filename: imagemName,
      ),
    });
    return await _service.client.post(
      "${DioService.baseUrl}/grayscaleMedia",
      data: formData,
    );
  }

  Future<Response> sepia(String imagemName, Uint8List imagem) async {
    var formData = FormData.fromMap({
      'imagem': MultipartFile.fromBytes(
        imagem,
        filename: imagemName,
      ),
    });
    return await _service.client.post(
      "${DioService.baseUrl}/sepia",
      data: formData,
    );
  }

  Future<Response> negativo(
    String imagemName,
    Uint8List imagem,
    bool rgb,
  ) async {
    var formData = FormData.fromMap({
      'imagem': MultipartFile.fromBytes(
        imagem,
        filename: imagemName,
      ),
      'isRGB': rgb ? 1 : 0,
    });
    return await _service.client.post(
      "${DioService.baseUrl}/negativo",
      data: formData,
    );
  }

  Future<Response> hsv(String imagemName, Uint8List imagem) async {
    var formData = FormData.fromMap({
      'imagem': MultipartFile.fromBytes(
        imagem,
        filename: imagemName,
      ),
    });
    return await _service.client.post(
      "${DioService.baseUrl}/hsv",
      data: formData,
    );
  }

  Future<Response> hsvCV2(String imagemName, Uint8List imagem) async {
    var formData = FormData.fromMap({
      'imagem': MultipartFile.fromBytes(
        imagem,
        filename: imagemName,
      ),
    });
    return await _service.client.post(
      "${DioService.baseUrl}/hsvCV2",
      data: formData,
    );
  }

  Future<Response> log(
      String imagemName, Uint8List imagem, double contrast) async {
    var formData = FormData.fromMap({
      'imagem': MultipartFile.fromBytes(
        imagem,
        filename: imagemName,
      ),
      'contrast': contrast,
    });
    return await _service.client.post(
      "${DioService.baseUrl}/log",
      data: formData,
    );
  }

  Future<Response> gamma(
    String imagemName,
    Uint8List imagem,
    double contrast,
    double gamma,
  ) async {
    var formData = FormData.fromMap({
      'imagem': MultipartFile.fromBytes(
        imagem,
        filename: imagemName,
      ),
      'contrast': contrast,
      'gamma': gamma,
    });
    return await _service.client.post(
      "${DioService.baseUrl}/gamma",
      data: formData,
    );
  }

  Future<Response> histograma(
    String imagemName,
    Uint8List imagem, {
    bool? mostraHistograma,
    bool? isRGB,
    bool? equalizar,
    List? espaco,
  }) async {
    Map<String, dynamic> data = {
      'imagem': MultipartFile.fromBytes(
        imagem,
        filename: imagemName,
      ),
    };
    if (mostraHistograma != null) {
      data['mostraHistograma'] = mostraHistograma ? 1 : 0;
    }
    if (isRGB != null) {
      data['isRGB'] = isRGB ? 1 : 0;
    }
    if (equalizar != null) {
      data['equalizar'] = equalizar ? 1 : 0;
    }
    if (espaco != null) {
      data['espaco'] = json.encode(espaco);
    }
    FormData formData = FormData.fromMap(data);
    return await _service.client.post(
      "${DioService.baseUrl}/histograma",
      data: formData,
    );
  }

  Future<Response> convolucao(
    String imagemName,
    Uint8List imagem,
    int tamanho,
    List matriz,
  ) async {
    FormData formData = FormData.fromMap({
      'imagem': MultipartFile.fromBytes(
        imagem,
        filename: imagemName,
      ),
      "tamanho": tamanho,
      "matriz": json.encode(matriz),
    });
    return await _service.client.post(
      "${DioService.baseUrl}/convolucao",
      data: formData,
    );
  }

  Future<Response> laplaciano(
    String imagemName,
    Uint8List imagem,
    int bordas,
  ) async {
    FormData formData = FormData.fromMap({
      'imagem': MultipartFile.fromBytes(
        imagem,
        filename: imagemName,
      ),
      "bordas": bordas,
    });
    return await _service.client.post(
      "${DioService.baseUrl}/laplaciano",
      data: formData,
    );
  }

  Future<Response> sobel(
    String imagemName,
    Uint8List imagem,
    int bordas,
    bool normaliza,
  ) async {
    FormData formData = FormData.fromMap({
      'imagem': MultipartFile.fromBytes(
        imagem,
        filename: imagemName,
      ),
      "bordas": bordas,
      "normaliza": normaliza ? 1 : 0,
    });
    return await _service.client.post(
      "${DioService.baseUrl}/sobel",
      data: formData,
    );
  }

  Future<Response> mean(
    String imagemName,
    Uint8List imagem,
    int tamanho,
  ) async {
    FormData formData = FormData.fromMap({
      'imagem': MultipartFile.fromBytes(
        imagem,
        filename: imagemName,
      ),
      "tamanho": tamanho,
    });
    return await _service.client.post(
      "${DioService.baseUrl}/mean",
      data: formData,
    );
  }

  Future<Response> geometric(
    String imagemName,
    Uint8List imagem,
    int tamanho,
  ) async {
    FormData formData = FormData.fromMap({
      'imagem': MultipartFile.fromBytes(
        imagem,
        filename: imagemName,
      ),
      "tamanho": tamanho,
    });
    return await _service.client.post(
      "${DioService.baseUrl}/geometric",
      data: formData,
    );
  }

  Future<Response> harmonic(
    String imagemName,
    Uint8List imagem,
    int tamanho,
  ) async {
    FormData formData = FormData.fromMap({
      'imagem': MultipartFile.fromBytes(
        imagem,
        filename: imagemName,
      ),
      "tamanho": tamanho,
    });
    return await _service.client.post(
      "${DioService.baseUrl}/harmonic",
      data: formData,
    );
  }

  Future<Response> contraHarmonic(
    String imagemName,
    Uint8List imagem,
    int tamanho,
    double q,
  ) async {
    FormData formData = FormData.fromMap({
      'imagem': MultipartFile.fromBytes(
        imagem,
        filename: imagemName,
      ),
      "tamanho": tamanho,
      "q": q,
    });
    return await _service.client.post(
      "${DioService.baseUrl}/contraHarmonic",
      data: formData,
    );
  }

  Future<Response> rgb2hsv(
    int r,
    int g,
    int b,
  ) async {
    FormData formData = FormData.fromMap({
      "r": r,
      "g": g,
      "b": b,
    });
    return await _service.client.post(
      "${DioService.baseUrl}/rgb2hsv",
      data: formData,
      options: Options(
        responseType: ResponseType.json,
      ),
    );
  }

  Future<Response> chromakey(
    String imagemName,
    Uint8List imagem,
    int r,
    int g,
    int b,
    int d,
  ) async {
    FormData formData = FormData.fromMap({
      'imagem': MultipartFile.fromBytes(
        imagem,
        filename: imagemName,
      ),
      "r": r,
      "g": g,
      "b": b,
      "d": d,
    });
    return await _service.client.post(
      "${DioService.baseUrl}/chromakey",
      data: formData,
    );
  }

  @override
  void dispose() {}
}
