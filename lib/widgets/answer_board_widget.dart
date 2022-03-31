import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordle_app/providers/providers.dart';
import 'package:dotted_border/dotted_border.dart';

class AnswerBoardWidget extends StatelessWidget {
  const AnswerBoardWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      primary: false,
      padding: const EdgeInsets.all(20),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 6,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (context, index) => _ContainerWord(index: index),
      itemCount: 36,
    );
  }
}

class _ContainerWord extends StatelessWidget {
  final int index;
  const _ContainerWord({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String word = context.select(
        (GameProvider gameProvider) => gameProvider.getCharacter(index));
    String? colorsAnswer = context.select(
        (GameProvider gameProvider) => gameProvider.colorsAnswer(index));
    word = word;
    return DottedBorder(
      radius: const Radius.circular(10),
      strokeWidth: 3,
      dashPattern: const [8, 4],
      color: Theme.of(context).secondaryHeaderColor,
      child: Container(
        decoration: BoxDecoration(
          color: colorsAnswer == 'correct'
              ? const Color(0xff6aaa64)
              : colorsAnswer == 'medium'
                  ? const Color(0xffc9b458)
                  : Colors.black12,
          border: Border.all(color: Colors.white.withOpacity(0.3), width: 3),
        ),
        child: Center(
          child: Text(
            word,
            style: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}
