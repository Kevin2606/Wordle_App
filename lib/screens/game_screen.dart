import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordle_app/providers/providers.dart';
import 'package:wordle_app/widgets/widgets.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GameProvider gameProvider =
        Provider.of<GameProvider>(context, listen: false);
    gameProvider.startGame();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Wordle',
              textAlign: TextAlign.center,
            ),
            Image.asset('assets/img/logo.png', height: 75),
          ],
        ),
      ),
      body: Column(
        children: const [
          SizedBox(height: 15),
          AnswerBoardWidget(),
          SizedBox(height: 15),
          KeyboardWidget(),
          SizedBox(height: 15),
        ],
      ),
    );
  }
}
