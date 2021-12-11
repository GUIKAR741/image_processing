import 'package:flutter_modular/flutter_modular.dart';
import 'package:image_processing/app/shared/repositories/imagem_repository.dart';
import 'package:image_processing/app/shared/services/dio_service.dart';

import 'modules/home/home_module.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => ImagemRepository()),
    Bind.lazySingleton((i) => DioService()),
  ];

  @override
  final List<ModularRoute> routes = [
    ModuleRoute(Modular.initialRoute, module: HomeModule()),
  ];
}
