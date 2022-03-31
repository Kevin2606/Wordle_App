import 'package:flutter/material.dart';
import 'package:wordle_app/widgets/widgets.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: Image.asset('assets/img/logo.png'),
        title: const Text(
          'Wordle',
          textAlign: TextAlign.center,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {},
          )
        ],
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
