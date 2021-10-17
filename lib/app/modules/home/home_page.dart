import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:image_processing/app/modules/home/home_store.dart';

class HomePage extends StatefulWidget {
  final String title;

  const HomePage({Key? key, this.title = "Home"}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, HomeStore> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Processamento de Imagens'),
      ),
      body: Observer(
        builder: (_) {
          if (controller.imageService.imageFuture == null) {
            return Center(
              child: ElevatedButton(
                onPressed: () => controller.abrirImagem(),
                child: const Text("Abrir Imagem"),
              ),
            );
          }
          if (controller.imageService.uiImagemFuture == null) {
            return const Center(child: CircularProgressIndicator());
          }
          return SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: controller.imageService.escalaDeCinza,
                      child: const Text("Escala de Cinza"),
                    ),
                    ElevatedButton(
                      onPressed: controller.imageService.negativo,
                      child: const Text("Negativo"),
                    )
                  ],
                ),
                Center(
                  child:
                      RawImage(image: controller.imageService.uiImagemFuture),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
