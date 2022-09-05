import 'package:flutter/material.dart';
import 'package:wordle_app/utils/list_words_utils.dart';

class GameProvider extends ChangeNotifier {
  String answer = '';
  int _numWords = 0;
  final List<String> _wordsCorrect = [];
  final List<String> _listCharacter = [];
  final List<String> _listWords = [];
  final List<String> _listCharCorrectAnswer = [];
  bool? _isCorrect;
  bool? get isCorrect => _isCorrect;
  List<String> get listWords => _listWords;
  List<String> get listCharacter => _listCharacter;
  List<String> get listCharCorrectAnswer => _listCharCorrectAnswer;

  void startGame() {
    _numWords = 0;
    _wordsCorrect.clear();
    _listWords.clear();
    _listCharCorrectAnswer.clear();
    _listCharacter.clear();
    _isCorrect = null;
    ListWordsUtils().getRandomWord().then((value) {
      answer = value;
    });
  }

  void _endGame() {
    String word = _listWords.last;
    if (word == answer) {
      _isCorrect = true;
    }
    if (_listWords.length == 6) {
      _isCorrect = false;
    }
  }

  void restarGame() {
    _numWords = 0;
    _wordsCorrect.clear();
    _listWords.clear();
    _listCharCorrectAnswer.clear();
    _listCharacter.clear();
    _isCorrect = null;
    ListWordsUtils().getRandomWord().then((value) {
      answer = value;
    });
    notifyListeners();
  }

  String getCharacter(int index) {
    if (_listCharacter.length > index) {
      return _listCharacter[index];
    }
    return '';
  }

  String? colorsAnswer(int index) {
    if ((6 * (_listWords.length)) > index) {
      if (_listCharCorrectAnswer.contains(_listCharacter[index])) {
        if (answer.split('')[(index % 6)] == _listCharacter[index]) {
          return 'correct';
        }
        return 'medium';
      }
    }
    return null;
  }

  String? colorButton(String char) {
    if (_listCharCorrectAnswer.isEmpty) return null;
    if (!_listCharCorrectAnswer.contains(char)) return null;
    if (_wordsCorrect.contains(char)) return 'correct';
    if (_listWords.last.split('').contains(char)) {
      List<String> lastWord = _listWords.last.split('');
      List<int> index = lastWord
          .asMap()
          .entries
          .where((element) => element.value == char)
          .map((e) => e.key)
          .toList();
      for (int i in index) {
        if (answer.split('')[i] == char) {
          _wordsCorrect.add(char);
        }
      }
    }
    return (_wordsCorrect.contains(char)) ? 'correct' : 'medium';
  }

  void addCharacter(String word) {
    if (_listCharacter.length >= 36 || _isCorrect != null) return;
    if (_listCharacter.length != (_numWords + 1) * 6) {
      _listCharacter.add(word);
      notifyListeners();
    }
  }

  void removeLastCharacter() {
    if (_listCharacter.isEmpty || _isCorrect != null) return;
    final length = _listWords.length;
    if (_listWords.isEmpty) {
      _listCharacter.removeLast();
    } else if (_listCharacter.length > (6 * length)) {
      _listCharacter.removeLast();
    }
    notifyListeners();
  }

  void addWord() {
    if (_numWords <= 5 && _isCorrect != null) return;
    if (_listCharacter.length == (_numWords + 1) * 6) {
      _numWords++;
      List<String> word = _listCharacter.sublist((_numWords - 1) * 6);
      for (String element in word) {
        if (answer.split('').contains(element) &&
            !_listCharCorrectAnswer.contains(element)) {
          _listCharCorrectAnswer.add(element);
        }
      }
      _listWords.add(word.join());
      _endGame();
      notifyListeners();
    }
  }
}
