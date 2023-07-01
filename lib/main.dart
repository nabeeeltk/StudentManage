import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:progect_2/db/model/data_model.dart';
import 'package:progect_2/provider/provider_student.dart';
import 'package:progect_2/screen/homescreen.dart';
import 'package:provider/provider.dart';
//import 'package:progect_2/screen/student_add_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(StudentmodelAdapter().typeId)) {
    Hive.registerAdapter(StudentmodelAdapter());
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProviderStudent(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: homescreen(),
      ),
    );
  }
}
