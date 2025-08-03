import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ContactoForm extends StatefulWidget {
  @override
  _ContactoFormState createState() => _ContactoFormState();
}

class _ContactoFormState extends State<ContactoForm> {
  final _formKey = GlobalKey<FormBuilderState>();

  void _enviarFormulario() async {
    if (_formKey.currentState?.saveAndValidate() ?? false) {
      final datos = _formKey.currentState!.value;
      try {
        await FirebaseFirestore.instance.collection('contactos').add({
          'nombre': datos['nombre'],
          'email': datos['email'],
          'mensaje': datos['mensaje'],
          'timestamp': FieldValue.serverTimestamp(),
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Mensaje enviado con éxito ✅')),
        );
        _formKey.currentState?.reset();
      } catch (_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al enviar el mensaje ❌')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: _formKey,
      child: Column(
        children: [
          FormBuilderTextField(
            name: 'nombre',
            decoration: InputDecoration(labelText: 'Nombre'),
          ),
          SizedBox(height: 16),
          FormBuilderTextField(
            name: 'email',
            decoration: InputDecoration(labelText: 'Correo'),
            keyboardType: TextInputType.emailAddress,
          ),
          SizedBox(height: 16),
          FormBuilderTextField(
            name: 'mensaje',
            decoration: InputDecoration(labelText: 'Mensaje'),
            maxLines: 4,
          ),
          SizedBox(height: 24),
          ElevatedButton(
            onPressed: _enviarFormulario,
            child: Text('Enviar'),
          ),
        ],
      ),
    );
  }
}
