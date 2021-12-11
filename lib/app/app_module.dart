import 'package:flutter_modular/flutter_modular.dart';
import 'package:image_processing/app/modules/home/home_module.dart';
import 'package:image_processing/app/shared/repositories/imagem_repository.dart';
import 'package:image_processing/app/shared/services/convolucao_service.dart';
import 'package:image_processing/app/shared/services/dio_service.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => ImagemRepository()),
    Bind.lazySingleton((i) => DioService()),
    Bind.lazySingleton((i) => ConvolucaoService()),
  ];

  @override
  final List<ModularRoute> routes = [
    ModuleRoute(Modular.initialRoute, module: HomeModule()),
  ];
}
