import 'package:flutter/material.dart';

class ProyectoCard extends StatelessWidget {
  final Map<String, String> proyecto;

  const ProyectoCard({super.key, required this.proyecto});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        title: Text(proyecto['titulo'] ?? ''),
        subtitle: Text(proyecto['descripcion'] ?? ''),
      ),
    );
  }
}
