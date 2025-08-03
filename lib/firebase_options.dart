// lib/firebase_options.dart
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart' show kIsWeb;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    throw UnsupportedError(
      'DefaultFirebaseOptions no está configurado para esta plataforma.',
    );
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBIEzMLcsHlZIal5vWhbyj9KspOK2ncgKQ',
    authDomain: 'miweb-33817.firebaseapp.com',
    projectId: 'miweb-33817',
    storageBucket: 'miweb-33817.appspot.com',
    messagingSenderId: '785549616155',
    appId: '1:785549616155:web:7134f2fbd49db5dc1a04be',
  );
}
