String normalizeFileName(String input) {
  ///
  /// Remove all [ under-scores and dashes ] from the file name
  input = input.replaceAll(RegExp(r'[-_]'), ' ');

  ///
  /// Remove all [non-alphanumeric characters except spaces] from the file name
  input = input.replaceAll(RegExp(r'[^a-zA-Z\u0600-\u06FF\s]'), '');

  ///
  /// Replace each character in the input string using the mapping
  for (var key in arabicNormalizationMap.keys) {
    input = input.replaceAll(key, arabicNormalizationMap[key] ?? "");
  }

  ///
  return input;
}

Map<String, String> arabicNormalizationMap = {
  // Normalize variations of 'ا'
  'آ': 'ا',
  'أ': 'ا',
  'إ': 'ا',
  'إ': 'ا',
  'ٱ': 'ا',

  // Normalize variations of 'ي'
  'ئ': 'ي',
  'ى': 'ي',

  // Normalize variations of 'و'
  'ؤ': 'و',

  // Normalize variations of 'ة'
  'ة': 'ه',

  // Remove diacritics
  'ۤ': '', // Small diacritic
  'َ': '', // Fatha
  'ً': '', // Fathatan
  'ِ': '', // Kasra
  'ٍ': '', // Kasratan
  'ُ': '', // Damma
  'ٌ': '', // Dammatan
  'ْ': '', // Sukoon
  'ّ': '', // Shadda
  ' ٔ': '', // Hamza above
  'ٔ': '', // Hamza above (different form)
  ' ٕ': '', // Hamza below
  'ؤ': 'و', // Waw with hamza
  'ئ': 'ي', // Ya with hamza

  // Other Arabic characters
  'ب': 'ب',
  'ت': 'ت',
  'ث': 'ث',
  'ج': 'ج',
  'ح': 'ح',
  'خ': 'خ',
  'د': 'د',
  'ذ': 'ذ',
  'ر': 'ر',
  'ز': 'ز',
  'س': 'س',
  'ش': 'ش',
  'ص': 'ص',
  'ض': 'ض',
  'ط': 'ط',
  'ظ': 'ظ',
  'ع': 'ع',
  'غ': 'غ',
  'ف': 'ف',
  'ق': 'ق',
  'ك': 'ك',
  'ل': 'ل',
  'م': 'م',
  'ن': 'ن',
  'ه': 'ه',
  'ي': 'ي',

  // Arabic punctuation (can be added as needed)
  '،': ',',
  '؛': ';',
  '؟': '?',

  // Add more mappings as needed
};
