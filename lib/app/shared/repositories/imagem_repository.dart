import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:image_processing/app/shared/services/dio_service.dart';

import 'base_repository.dart';

class ImagemRepository with BaseRepository {
  final DioService _service = Modular.get();

  Future<Response> blackAndWhite(String imagemName, Uint8List imagem) async {
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
      String imagemName, Uint8List imagem) async {
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
      String imagemName, Uint8List imagem, bool rgb) async {
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
      "${DioService.baseUrl}/log",
      data: formData,
    );
  }

  @override
  void dispose() {}
}
