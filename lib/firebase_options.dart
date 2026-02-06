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
    apiKey: 'AIzaSyCyy-OgBNQEpUTszaQW8vvHKOIIsNCd1vY',
    authDomain: 'miweb-portfolio.firebaseapp.com',
    projectId: 'miweb-portfolio',
    storageBucket: 'miweb-portfolio.firebasestorage.app',
    messagingSenderId: '361737353646',
    appId: '1:361737353646:web:6c50158b077e210329303f',
  );
}
