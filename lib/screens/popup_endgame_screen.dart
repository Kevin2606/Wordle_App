import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordle_app/models/account_models.dart';
import 'package:wordle_app/providers/providers.dart';

class PopupEndGameScreen extends StatelessWidget {
  final bool gameCondition;
  final String gifURL;
/*   final GifPopupsUtils gifPopupsUtils = GifPopupsUtils(); */

  static final Map<String, dynamic> _prefabMessages = {
    'winner': {
      'title': '¡Felicidades!',
      'content': '¡Has ganado!',
      'gif': '',
    },
    'loser': {'title': '¡Lo sentimos!', 'content': '¡Has perdido!', 'gif': ''},
  };

  const PopupEndGameScreen({
    Key? key,
    required this.gameCondition,
    required this.gifURL,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String condition;
    gameCondition ? condition = 'winner' : condition = 'loser';
    AcountProvider acountProvider =
        Provider.of<AcountProvider>(context, listen: true);
    late Account user;
    (acountProvider.userGame == null)
        ? acountProvider.selectedUser()
        : user = acountProvider.userGame!;
    return AlertDialog(
      contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 0),
      backgroundColor: Theme.of(context).cardColor.withOpacity(0.9),
      elevation: 0,
      insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 50),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      title: Image.asset('assets/img/logo-animado.gif'),
      content: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            _prefabMessages[condition]['title'],
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            user.nickname,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            _prefabMessages[condition]['content'],
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          FadeInImage(
            placeholder: const AssetImage('assets/img/logo.png'),
            image: NetworkImage(gifURL),
            fit: BoxFit.contain,
            height: 300,
          ),
          const Text(
            '¿Quieres volver a jugar?',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
              const Color(0xff6aaa64),
            ),
          ),
          child: const Text('Si'),
          onPressed: () {
            GameProvider gameProvider =
                Provider.of<GameProvider>(context, listen: false);
            gameProvider.restarGame();
            Navigator.of(context).pop();
          },
        ),
        ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
              const Color.fromARGB(255, 179, 73, 47),
            ),
          ),
          child: const Text('No'),
          onPressed: () {
            GameProvider gameProvider =
                Provider.of<GameProvider>(context, listen: false);
            gameProvider.restarGame();
            Navigator.of(context).pop();
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
