import 'package:flutter/material.dart';

void main() {
  runApp(MiWeb());
}

class MiWeb extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'miweb',
      home: MiWebHomePage(),
    );
  }
}

class MiWebHomePage extends StatefulWidget {
  @override
  State<MiWebHomePage> createState() => _MiWebHomePageState();
}

class _MiWebHomePageState extends State<MiWebHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('miweb'),
      ),
      body: Center(
        child: Text(
          '$_counter',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
