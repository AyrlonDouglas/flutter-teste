import 'package:flutter/material.dart';
import 'package:projeto_perguntas/questao.dart';
import 'package:projeto_perguntas/resposta.dart';

class Questionario extends StatelessWidget {
  final int perguntaSelecionada;
  final List<Map<String, Object>> perguntas;
  final void Function(int) quandoResponder;

  const Questionario({
    super.key,
    required this.perguntaSelecionada,
    required this.perguntas,
    required this.quandoResponder,
  });

  bool get temPerguntaSelecionada {
    return perguntaSelecionada < perguntas.length;
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, Object>> respostas = temPerguntaSelecionada
        ? perguntas[perguntaSelecionada]['resposta']
            as List<Map<String, Object>>
        : [];

    List<Resposta> widgets = respostas.map((resposta) {
      return Resposta(
        resposta['texto'] as String,
        () => quandoResponder(int.parse(resposta['pontuacao'].toString())),
      );
    }).toList();

    return Column(
      children: [
        Questao(perguntas[perguntaSelecionada]['texto'].toString()),
        ...widgets,
      ],
    );
  }
}
