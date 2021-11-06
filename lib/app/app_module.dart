import 'package:flutter_modular/flutter_modular.dart';
import 'package:image_processing/app/shared/service/convolucao_service.dart';
import 'package:image_processing/app/shared/service/image_service.dart';

import 'modules/home/home_module.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => ConvolucaoService()),
    Bind.lazySingleton((i) => ImageService()),
  ];

  @override
  final List<ModularRoute> routes = [
    ModuleRoute(Modular.initialRoute, module: HomeModule()),
  ];
}
