import 'package:firebase_reader/infra/google_services_parser.dart';
import 'package:firebase_reader/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get_it/get_it.dart';

class AppInitializer extends StatelessWidget {
  const AppInitializer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: initialize(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData && snapshot.data == true) {
            return Scaffold(
              body: Center(
                child: ElevatedButton(
                    onPressed: () {
                      var title = GetIt.I.get<FirebaseApp>().name;
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return MyHomePage(title: title);
                          },
                        ),
                      );
                    },
                    child: const Text("Comecar")),
              ),
            );
          }
          return const Scaffold(
            body: Center(
              child: Text("Falha ao inicializar"),
            ),
          );
        }
        return const Scaffold(
          body: Center(
            child: Text("Carregando"),
          ),
        );
      },
    );
  }

  Future<bool> initialize() async {
    var options = await GoogleServicesParser.execute();
    if (options == null) return false;

    await Firebase.initializeApp(
      name: options['projectId'],
      options: FirebaseOptions(
        apiKey: options['apiKey'],
        appId: options['appId'],
        messagingSenderId: options['messagingSenderId'],
        projectId: options['projectId'],
      ),
    );
    GetIt.I.registerSingleton<FirebaseApp>(Firebase.app(options['projectId']));
    GetIt.I.registerSingleton<DatabaseReference>(_dbInit());
    await GetIt.I.allReady();
    return true;
  }

  DatabaseReference _dbInit() {
    final inst = FirebaseDatabase.instanceFor(app: GetIt.I.get<FirebaseApp>());
    final ref = inst.ref();
    return ref;
  }
}
