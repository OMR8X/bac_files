import 'package:bac_files_admin/core/functions/counters/similarity_score.dart';
import 'package:flutter/material.dart';

T? extractRelevantElement<T>(String title, List<T> elements, String Function(T) getName) {
  //
  debugPrint("call. ${DateTime.now()}");
  //
  List<(T, double)> result = [];
  //
  List<String> wordsOfTitle = splitTitleToWords(title);

  //
  for (var element in elements) {
    //
    String item = getName(element).replaceAll("اللغة", "").replaceAll("الفرع", "");
    //
    for (var word in wordsOfTitle) {
      //
      double similarity = similarityScore(word, item);
      //
      if (similarity > 0.5) {
        result.add((element, similarity));
      }
    }
    //
  }
  //
  if (result.isEmpty) return null;
  // Sorting
  result.sort((a, b) => b.$2.compareTo(a.$2));
  //
  return result.first.$1;
}

List<String> splitTitleToWords(String title) {
  //
  List<String> allWords = title.split(" ");
  //
  List<String> result = List.empty(growable: true);
  //
  for (int i = 0; i < allWords.length; i++) {
    String value = "";
    for (int j = i; j < allWords.length; j++) {
      value += " ${(allWords[j])}";
      result.add(value);
    }
  }
  //
  return result;
}
