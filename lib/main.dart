import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'pages/detalhes_grupo_page.dart';

Future<void> main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.grey,
        fontFamily: 'Inter',
        textTheme: TextTheme(
          titleLarge: const TextStyle(color: Colors.black),
          headlineLarge: const TextStyle(color: Colors.white),
          headlineSmall: const TextStyle(color: Colors.white),
          bodyLarge: const TextStyle(color: Colors.black),
          bodyMedium: const TextStyle(color: Colors.black),
          bodySmall: TextStyle(color: Colors.black.withOpacity(0.8)),
        ),
        scaffoldBackgroundColor: const Color(0xFF4169E1),
        cardTheme: CardTheme(
          color: const Color(0xFF00BFFF),
          elevation: 5,
          margin: const EdgeInsets.all(12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
      home: const Initialize(),
    );
  }
}

class Initialize extends StatelessWidget {
  const Initialize({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            return const DetalhesGrupoPage();
          }
        }
        return const Text('loading');
      },
    );
  }
}
