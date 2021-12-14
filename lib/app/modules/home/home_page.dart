import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:image_processing/app/modules/home/home_store.dart';

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
          if (controller.imagemOriginal == null) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: controller.abrirImagem,
                      child: const Text("Abrir Imagem"),
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: controller.rgb2hsv,
                      child: const Text("RGB => HSV"),
                    ),
                  ),
                ),
              ],
            );
          }
          return SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: controller.restaurarImagem,
                      child: const Text("Restaurar Imagem"),
                    ),
                    ElevatedButton(
                      onPressed: controller.blackAndWhite,
                      child: const Text("Preto e Branco"),
                    ),
                    ElevatedButton(
                      onPressed: controller.grayscalePonderado,
                      child: const Text("Escala de Cinza Ponderado"),
                    ),
                    ElevatedButton(
                      onPressed: controller.grayscaleMedia,
                      child: const Text("Escala de Cinza Media"),
                    ),
                    ElevatedButton(
                      onPressed: controller.sepia,
                      child: const Text("Sepia"),
                    ),
                    ElevatedButton(
                      onPressed: controller.negativo,
                      child: const Text("Negativo"),
                    ),
                    ElevatedButton(
                      onPressed: controller.fechar,
                      child: const Text("Fechar"),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: controller.hsv,
                      child: const Text("HSV"),
                    ),
                    ElevatedButton(
                      onPressed: controller.hsvCV2,
                      child: const Text("HSV CV2"),
                    ),
                    ElevatedButton(
                      onPressed: controller.log,
                      child: const Text("Trans. Logarítmica"),
                    ),
                    ElevatedButton(
                      onPressed: controller.gamma,
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
                    !kIsWeb
                        ? ElevatedButton(
                            onPressed: controller.salvarImagem,
                            child: const Text("Salvar"),
                          )
                        : Container(),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: controller.laplaciano,
                      child: const Text("Laplaciano"),
                    ),
                    ElevatedButton(
                      onPressed: controller.sobel,
                      child: const Text("Sobel"),
                    ),
                    ElevatedButton(
                      onPressed: controller.mean,
                      child: const Text("Media"),
                    ),
                    ElevatedButton(
                      onPressed: controller.geometric,
                      child: const Text("Media Geometrica"),
                    ),
                    ElevatedButton(
                      onPressed: controller.harmonic,
                      child: const Text("Media Harmonica"),
                    ),
                    ElevatedButton(
                      onPressed: controller.contraHarmonic,
                      child: const Text("Media Contra Harmonica"),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: controller.chromakey,
                      child: const Text("Chromakey"),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      child: const Text("Fourrier"),
                    ),ElevatedButton(
                      onPressed: () {},
                      child: const Text("Escala"),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      child: const Text("Rotação"),
                    ),
                  ],
                ),
                Center(
                  child: controller.imagem != null
                      ? Column(
                          children: [
                            Image.memory(
                              controller.imagem!,
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
