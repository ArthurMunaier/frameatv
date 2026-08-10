import 'package:flutter/material.dart';

class CardAventura extends StatelessWidget {
  final IconData icone;
  final String texto;

  const CardAventura({
    super.key,
    required this.icone,
    required this.texto,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(
              icone,
              size: 55,
            ),

            const SizedBox(width: 20),

            Expanded(
              child: Text(
                texto,
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}