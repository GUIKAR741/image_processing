import 'package:flutter_modular/flutter_modular.dart';
import 'package:image_processing/app/shared/services/dio_service.dart';

mixin BaseRepository implements Disposable {
  final DioService service = Modular.get();
}
