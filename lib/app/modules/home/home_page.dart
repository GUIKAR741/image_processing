import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:image_processing/app/modules/home/home_store.dart';
import 'package:image_processing/app/modules/home/widgets/histograma.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

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
          if (controller.imageService.imageValue == null) {
            return Center(
              child: ElevatedButton(
                onPressed: () => controller.abrirImagem(),
                child: const Text("Abrir Imagem"),
              ),
            );
          }
          return SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: controller.imageService.resetImage,
                      child: const Text("Restaurar Imagem"),
                    ),
                    ElevatedButton(
                      onPressed: controller.imageService.escalaDeCinza,
                      child: const Text("Escala de Cinza"),
                    ),
                    ElevatedButton(
                      onPressed: controller.imageService.negativo,
                      child: const Text("Negativo"),
                    ),
                    ElevatedButton(
                      onPressed: controller.imageService.transfLog,
                      child: const Text("Trans. Logarítmica"),
                    ),
                    ElevatedButton(
                      onPressed: controller.gammaCorrection,
                      child: const Text("Trans. Potencia (Gamma Correction)"),
                    ),
                    ElevatedButton(
                      onPressed: controller.histograma,
                      child: const Text("Intensidade"),
                    ),
                    ElevatedButton(
                      onPressed: controller.convolucao,
                      child: const Text("Convolução"),
                    ),
                    ElevatedButton(
                      onPressed: controller.imageService.clearImage,
                      child: const Text("Fechar"),
                    )
                  ],
                ),
                Center(
                  child: controller.imageService.uiImagemFuture != null
                      ? Column(
                          children: [
                            controller.showHistograma
                                ? Histograma(
                                    imagem: controller.imageService.imageValue!
                                        .getBytes(),
                                  )
                                : Container(),
                            RawImage(
                              image: controller.imageService.uiImagemFuture,
                            ),
                          ],
                        )
                      : const CircularProgressIndicator(),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
