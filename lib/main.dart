import 'package:firstapp/feedingProvider.dart';
import 'package:firstapp/pillsProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/splashscreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FeedingScheduleProvider()),
        ChangeNotifierProvider(create: (_) => pillsProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.purpleAccent),
          useMaterial3: true,
        ),
        home: const Splashscreen(),
      ),
    );
  }
}


