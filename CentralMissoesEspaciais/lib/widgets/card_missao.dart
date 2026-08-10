import 'package:flutter/material.dart';

// Widget personalizado para mostrar uma etapa da missão.
class CardMissao extends StatelessWidget {
  final IconData icone;
  final String titulo;
  final String descricao;

  const CardMissao({
    super.key,
    required this.icone,
    required this.titulo,
    required this.descricao,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              icone,
              size: 35,
              color: Colors.deepPurple,
            ),
            const SizedBox(width: 12),

            // Expanded ajuda o texto a se adaptar a telas menores.
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    titulo,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(descricao),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
