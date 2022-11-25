import 'package:flutter/material.dart';
import 'package:hive_completion/data/generate.dart';
import 'package:hive_completion/screens/read_data.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart' as path;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final directory = await path.getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  Hive.registerAdapter(HiveTypeDataAdapter());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ReadData(),
    );
  }
}