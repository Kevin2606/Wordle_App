import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordle_app/providers/providers.dart';
import 'package:wordle_app/screens/screens.dart';
import 'package:wordle_app/utils/gif_popups_utils.dart';

void main() => runApp(const AppState());

class AppState extends StatelessWidget {
  const AppState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => GameProvider(),
        ),
        ChangeNotifierProvider(create: (_) => GifPopupsUtils()),
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Wordle App',
      initialRoute: 'HomeScreen',
      routes: {
        'HomeScreen': (context) => const HomeScreen(),
        'LoginScreen': (context) => const LoginScreen(),
        'GameScreen': (context) => const GameScreen(),
        'AcountScreen': (context) => const AcountScreen(),
      },
      theme: ThemeData.dark(),
    );
  }
}
