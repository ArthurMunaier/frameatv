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
      child: Row(
        children: [
          Icon(
            icone,
            size: 70,
          ),
          const SizedBox(width: 20),
          Text(
            texto,
            style: const TextStyle(
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}
