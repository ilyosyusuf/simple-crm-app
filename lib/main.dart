
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hiveproject/providers/save_provider.dart';
import 'package:hiveproject/providers/theme_provider.dart';
import 'package:hiveproject/routes/my_route.dart';
import 'package:hiveproject/services/my_service.dart';
import 'package:provider/provider.dart';

void main() async {
  await Hive.initFlutter();
  await MyService.openBox();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context)=>SaveProvider()),
        ChangeNotifierProvider(create: (context)=> ThemeProvider()),
      ],
      child: MyApp(),
    ),
    
    );
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final _myRoute = MyRoute();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(brightness: context.watch<ThemeProvider>().themeMode),
      initialRoute: '/',
      onGenerateRoute: _myRoute.onGenerateRoute,
    );
  }
}