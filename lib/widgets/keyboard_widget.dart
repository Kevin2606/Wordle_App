import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:wordle_app/providers/providers.dart';
import 'package:wordle_app/screens/screens.dart' show PopupEndGameScreen;
import 'package:wordle_app/utils/gif_popups_utils.dart';

class KeyboardWidget extends StatelessWidget {
  static const _listWorlds1 = [
    'Q',
    'W',
    'E',
    'R',
    'T',
    'Y',
    'U',
    'I',
    'O',
    'P'
  ];
  static const _listWorlds2 = [
    'A',
    'S',
    'D',
    'F',
    'G',
    'H',
    'J',
    'K',
    'L',
    'Ñ'
  ];
  static const _listWorlds3 = ['b1', 'Z', 'X', 'C', 'V', 'B', 'N', 'M', 'b2'];
  const KeyboardWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const double height = 65, width = double.infinity;
    return Expanded(
      child: Column(
        children: [
          SizedBox(
            height: height,
            width: width,
            child: ListView.builder(
              shrinkWrap: false,
              physics: const NeverScrollableScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: _listWorlds1.length,
              itemBuilder: (context, index) => _KeyboardButton(
                text: _listWorlds1[index],
              ),
            ),
          ),
          SizedBox(
            height: height,
            width: width,
            child: ListView.builder(
              shrinkWrap: false,
              physics: const NeverScrollableScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: _listWorlds2.length,
              itemBuilder: (context, index) => _KeyboardButton(
                text: _listWorlds2[index],
              ),
            ),
          ),
          SizedBox(
            height: height,
            width: width,
            child: ListView.builder(
              shrinkWrap: false,
              physics: const NeverScrollableScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: _listWorlds3.length,
              itemBuilder: (context, index) => _KeyboardButton(
                text: _listWorlds3[index],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _KeyboardButton extends StatelessWidget {
  final String text;

  const _KeyboardButton({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorButton = context
        .select((GameProvider gameProvider) => gameProvider.colorButton(text));
    final size = MediaQuery.of(context).size;
    if (text == 'b1' || text == 'b2') {
      return Container(
        width: ((size.width - 36) / 10) * 1.54,
        margin: const EdgeInsets.all(2),
        decoration: _boxDecorationCustom(),
        child: ElevatedButton(
          style: _buttonStyleCustom(colorButton),
          child: Icon(
            (text == 'b1') ? Icons.backspace : Icons.keyboard_return,
          ),
          onPressed: () async {
            final gameProvider =
                Provider.of<GameProvider>(context, listen: false);
            if (text == 'b1') {
              HapticFeedback.vibrate();
              gameProvider.removeLastCharacter();
            } else {
              HapticFeedback.vibrate();
              gameProvider.addWord();
              if (gameProvider.isCorrect == true ||
                  gameProvider.isCorrect == false) {
                await Future.delayed(const Duration(milliseconds: 1500));
                final gifPopupsUtils =
                    Provider.of<GifPopupsUtils>(context, listen: false);
                final String gifURL =
                    await gifPopupsUtils.getRandomGif(gameProvider.isCorrect!);
                showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (context) => PopupEndGameScreen(
                      gameCondition: gameProvider.isCorrect!, gifURL: gifURL),
                );
              }
            }
          },
        ),
      );
    } else {
      return Container(
        margin: const EdgeInsets.all(2),
        width: (size.width - 40) / 10,
        decoration: _boxDecorationCustom(),
        child: ElevatedButton(
          style: _buttonStyleCustom(colorButton),
          child: Text(
            text,
            style: const TextStyle(fontSize: 20),
            textAlign: TextAlign.center,
          ),
          onPressed: () {
            HapticFeedback.vibrate();
            final gameProvider =
                Provider.of<GameProvider>(context, listen: false);
            gameProvider.addCharacter(text);
          },
        ),
      );
    }
  }

  ButtonStyle _buttonStyleCustom(String? colorButton) {
    return ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(
        (colorButton == 'correct')
            ? const Color(0xff6aaa64)
            : (colorButton == 'medium')
                ? const Color(0xffc9b458)
                : const Color.fromARGB(1, 129, 131, 132),
      ),
      elevation: MaterialStateProperty.all<double>(0),
    );
  }

  BoxDecoration _boxDecorationCustom() {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(7),
      border: Border.all(
        color: Colors.grey.withOpacity(0.2),
        width: 2,
      ),
    );
  }
}
