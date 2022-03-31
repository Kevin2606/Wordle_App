import 'package:flutter/material.dart';

class GameProvider extends ChangeNotifier {
  String answer = 'PERROS';
  bool _saveWord = false;
  final List<String> _listCharacter = [];
  final List<String> _listWords = [];
  final List<String> _listCharCorrectAnswer = [];
  bool? _isCorrect;

  bool? get isCorrect => _isCorrect;
  List<String> get listWords => _listWords;
  List<String> get listCharacter => _listCharacter;
  List<String> get listCharCorrectAnswer => _listCharCorrectAnswer;

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
    _listWords.clear();
    _listCharCorrectAnswer.clear();
    _listCharacter.clear();
    _isCorrect = null;
    _saveWord = false;
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
    if (_listCharCorrectAnswer.contains(char)) {
      List<String> lastWord = _listWords.last.split('');
      for (int i = 0; i < answer.split('').length; i++) {
        if (answer.split('')[i] == lastWord[i]) {
          return 'correct';
        }
      }
      return 'medium';
    }
    return null;
  }

  void addCharacter(String word) {
    if (_listCharacter.length >= 36 || _isCorrect != null) return;
    if (_listCharacter.length % 6 != 0 || _listCharacter.isEmpty) {
      _listCharacter.add(word);
      if (_listCharacter.length % 6 == 0) _saveWord = true;
    } else if (!_saveWord) {
      _listCharacter.add(word);
    }
    notifyListeners();
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
    if (_listCharacter.length % 6 != 0 ||
        _listCharacter.isEmpty ||
        _isCorrect != null) return;
    final length = _listWords.length;
    if (_listCharacter.length == (6 * (length + 1))) {
      List<String> listWordsTemp = _listCharacter.reversed.toList();
      final answerSplit = answer.split('');

      listWordsTemp = listWordsTemp.getRange(0, 6).toList().reversed.toList();
      for (String character in listWordsTemp) {
        if (answerSplit.contains(character)) {
          if (!_listCharCorrectAnswer.contains(character)) {
            _listCharCorrectAnswer.add(character);
          }
        }
      }
      _listWords.add(listWordsTemp.join());
      _saveWord = false;
      _endGame();
      notifyListeners();
    }
  }
}
