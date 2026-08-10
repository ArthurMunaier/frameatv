import 'package:flutter/material.dart';

class TabelaResumo extends StatelessWidget {
  final List<MapEntry<String, String>> dados;

  const TabelaResumo({
    super.key,
    required this.dados,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            const ListTile(
              title: Text(
                'Informação',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              trailing: Text(
                'Valor',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            ...dados.map(
              (item) => Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 12,
                ),
                decoration: const BoxDecoration(
                  border: Border(
                    top: BorderSide(color: Colors.black12),
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Text(
                        item.key,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      flex: 3,
                      child: Text(item.value),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
