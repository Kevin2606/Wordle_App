import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:diacritic/diacritic.dart';

class ListWordsUtils extends ChangeNotifier {
  Future<String> getRandomWord() async {
    final String response =
        await rootBundle.loadString('assets/json/list_words.json');
    final data = await json.decode(response);
    final List<String> word = List<String>.from(data["words"].map((x) => x));
    String wordSelected = word[Random().nextInt(word.length)].toUpperCase();
    return removeDiacritics(wordSelected);
  }
}
