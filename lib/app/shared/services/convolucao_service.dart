import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobx/mobx.dart';

part 'convolucao_service.g.dart';

enum Matrizes {
  m3X3,
  m5X5,
  m7X7,
  m9X9,
}

class ConvolucaoService = ConvolucaoServiceBase with _$ConvolucaoService;

abstract class ConvolucaoServiceBase with Store {
  @observable
  Matrizes type = Matrizes.m3X3;

  @action
  trocaTipo(Matrizes matriz) => type = matriz;

  @observable
  Map<Matrizes, List<List<num>>> matrizes = {
    Matrizes.m3X3: List.generate(3, (index) => List.generate(3, (index) => 1)),
    Matrizes.m5X5: List.generate(5, (index) => List.generate(5, (index) => 1)),
    Matrizes.m7X7: List.generate(7, (index) => List.generate(7, (index) => 1)),
    Matrizes.m9X9: List.generate(9, (index) => List.generate(9, (index) => 1)),
  };

  final Map<Matrizes, int> _tamanho = {
    Matrizes.m3X3: 3,
    Matrizes.m5X5: 5,
    Matrizes.m7X7: 7,
    Matrizes.m9X9: 9,
  };

  @computed
  List<List<num>> get matrizAtual => matrizes[type]!;

  @computed
  int get tamanho => _tamanho[type]!;

  @computed
  Column get geraForm {
    List<Row> matriz = [];
    switch (type) {
      case Matrizes.m5X5:
        for (int i = 0; i < 5; i++) {
          List<Widget> wids = [];
          for (int j = 0; j < 5; j++) {
            wids.add(
              Expanded(
                child: TextField(
                  controller: TextEditingController(
                      text: matrizes[Matrizes.m5X5]![i][j].toString()),
                  onChanged: (value) =>
                      matrizes[Matrizes.m5X5]![i][j] = num.tryParse(value) ?? 0,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                ),
              ),
            );
          }
          matriz.add(Row(children: wids));
        }
        break;
      case Matrizes.m7X7:
        for (int i = 0; i < 7; i++) {
          List<Widget> wids = [];
          for (int j = 0; j < 7; j++) {
            wids.add(
              Expanded(
                child: TextField(
                  controller: TextEditingController(
                      text: matrizes[Matrizes.m7X7]![i][j].toString()),
                  onChanged: (value) =>
                      matrizes[Matrizes.m7X7]![i][j] = num.tryParse(value) ?? 0,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                ),
              ),
            );
          }
          matriz.add(Row(children: wids));
        }
        break;
      case Matrizes.m9X9:
        for (int i = 0; i < 9; i++) {
          List<Widget> wids = [];
          for (int j = 0; j < 9; j++) {
            wids.add(
              Expanded(
                child: TextField(
                  controller: TextEditingController(
                      text: matrizes[Matrizes.m9X9]![i][j].toString()),
                  onChanged: (value) =>
                      matrizes[Matrizes.m9X9]![i][j] = num.tryParse(value) ?? 0,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                ),
              ),
            );
          }
          matriz.add(Row(children: wids));
        }
        break;
      case Matrizes.m3X3:
      default:
        for (int i = 0; i < 3; i++) {
          List<Widget> wids = [];
          for (int j = 0; j < 3; j++) {
            wids.add(
              Expanded(
                child: TextField(
                  controller: TextEditingController(
                    text: matrizes[Matrizes.m3X3]![i][j].toString(),
                  ),
                  onChanged: (value) =>
                      matrizes[Matrizes.m3X3]![i][j] = num.tryParse(value) ?? 0,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
            );
          }
          matriz.add(
            Row(
              children: wids,
            ),
          );
        }
        break;
    }
    return Column(
      children: matriz,
    );
  }
}
