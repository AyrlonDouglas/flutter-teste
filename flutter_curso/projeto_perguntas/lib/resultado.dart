import 'package:flutter/material.dart';

class Resultado extends StatelessWidget {
  final int pontuacao;
  final void Function() quandoReinciarQuestionariuo;

  const Resultado(this.pontuacao, this.quandoReinciarQuestionariuo,
      {super.key});

  String get fraseResultado {
    if (pontuacao < 8) {
      return 'Parabéns';
    } else if (pontuacao < 12) {
      return 'Você é bom!';
    } else if (pontuacao < 16) {
      return 'Impressionante';
    } else {
      return 'Nível JEDI!';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Text(
            fraseResultado,
            style: const TextStyle(fontSize: 28),
          ),
        ),
        TextButton(
          onPressed: quandoReinciarQuestionariuo,
          child: const Text(
            'Reiniciar??',
            style: TextStyle(fontSize: 18),
          ),
        )
      ],
    );
  }
}
