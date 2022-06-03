import 'package:flutter/material.dart';
import 'package:flutter_storeged/services/local_storege_services.dart';

import 'package:flutter_storeged/services/shared_pref_services..dart';
import 'package:flutter_storeged/shared_pref.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void setup() {
  locator.registerSingleton<LocalStorageServices>(SharedPrefServices());
// Alternatively you could write it if you don't like global variables
}

void main() async {
  setup();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SharedPref(),
    );
  }
}
