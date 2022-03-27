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
      builder: (context, child) {
        ;
        return child!;
      },
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
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
