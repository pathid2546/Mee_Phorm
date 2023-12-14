import 'package:flutter/material.dart';
import 'package:meephrom/mongodb.dart';
import 'package:meephrom/pages/HomeLogin.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MongoDatabase.connect();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: Locale('th', 'TH'),
      debugShowCheckedModeBanner: false,
      home: HomeLog(),
    );
  }
}
