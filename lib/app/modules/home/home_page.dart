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
                      onPressed: () {},
                      child: const Text("Intensidade"),
                    ),
                    ElevatedButton(
                      onPressed: () {},
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
