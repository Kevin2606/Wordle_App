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
      ),
      endDrawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              child: Image.asset('assets/img/logo.png'),
            ),
            ListTile(
              title: const Text('Cuenta'),
              onTap: () {
                Navigator.popAndPushNamed(context, 'AcountScreen');
              },
            ),
            ListTile(
              title: const Text('Configuración'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Salir'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
            ),
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
