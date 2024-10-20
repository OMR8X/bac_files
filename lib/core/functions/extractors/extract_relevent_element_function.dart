import 'package:bac_files_admin/core/functions/counters/similarity_score.dart';
import 'package:flutter/material.dart';

T? extractRelevantElement<T>(String title, List<T> elements, String Function(T) getName) {
  //
  List<(T, double)> result = [];
  //
  List<String> wordsOfTitle = title.split(" ");
  //
  for (var element in elements) {
    //
    List<String> wordsOfMaterial = getName(element).split(" ");
    //
    String item = wordsOfMaterial.length > 1 ? wordsOfMaterial[1] : wordsOfMaterial[0];
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
  debugPrint("${getName(result.first.$1)} ${result.first.$2}");
  //
  return result.first.$1;
}

// [
// (FileMaterialModel(6, اللغة العربية), 0.8),

// (FileMaterialModel(7, اللغة الإنجليزية), 0.8),
// (FileMaterialModel(7, اللغة الإنجليزية), 0.7), 

// (FileMaterialModel(8, اللغة الروسية), 0.8), 
// (FileMaterialModel(9, اللغة الفرنسية), 0.8)
// ]