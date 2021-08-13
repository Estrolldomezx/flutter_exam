import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:midterm_proj/models/model.dart';
import 'package:midterm_proj/models/model_history.dart';
import 'package:midterm_proj/pages/Goals_page.dart';
import 'package:midterm_proj/pages/history_page.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  Hive.registerAdapter(GoalsAdapter());
  await Hive.openBox<Goals>('Goals');

  Hive.registerAdapter(HistoryAdapter());
  await Hive.openBox<History>('histories');

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static final String title = 'Last Time';

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: title,
        theme: ThemeData(primarySwatch: Colors.indigo),
        home: GoalsPage(),
        initialRoute: '/',
      routes: <String, WidgetBuilder>{
        '/history_page': (context) => HistoryPage(),
        '/Goals_page': (context) => GoalsPage(),
      },
      );
}