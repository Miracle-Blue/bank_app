import 'package:bank_app/pages/add_card_page.dart';
import 'package:bank_app/pages/create_card_page.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'services/hive_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox(HiveDB.DB_NAME);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bank App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const AddCardPage(),
      routes: {
        AddCardPage.id: (context) => const AddCardPage(),
        CreateCardPage.id: (context) => const CreateCardPage(),
      },
    );
  }
}
