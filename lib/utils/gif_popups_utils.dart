import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class GifPopupsUtils extends ChangeNotifier {
  Future<String> getRandomGif(bool condition) async {
    String url;
    condition ? url = 'response_winner' : url = 'response_loser';
    final String response =
        await rootBundle.loadString('assets/json/$url.json');
    final data = await json.decode(response);
    final List<String> gifs = List<String>.from(data["urls"].map((x) => x));

    return gifs[Random().nextInt(gifs.length)];
  }
}
