double similarityScore(String a, String b) {
  int maxLength = a.length > b.length ? a.length : b.length;

  if (maxLength == 0) return 1.0; // If both strings are empty, they are identical

  int distance = levenshteinDistance(a, b);

  // Normalize the score to get a value between 0 and 1
  return 1.0 - (distance / maxLength);
}

int levenshteinDistance(String a, String b) {
  if (a == b) return 0;

  List<List<int>> matrix = List.generate(a.length + 1, (i) => List<int>.filled(b.length + 1, 0));

  for (int i = 0; i <= a.length; i++) {
    matrix[i][0] = i;
  }
  for (int j = 0; j <= b.length; j++) {
    matrix[0][j] = j;
  }

  for (int i = 1; i <= a.length; i++) {
    for (int j = 1; j <= b.length; j++) {
      //
      // Cost of substitution
      int cost = (a[i - 1] == b[j - 1]) ? 0 : 1;
      //
      // Choose the minimum cost
      matrix[i][j] = [
        matrix[i - 1][j] + 1, // deletion
        matrix[i][j - 1] + 1, // insertion
        matrix[i - 1][j - 1] + cost // substitution
      ].reduce((current, next) => current < next ? current : next);
      //
    }
  }

  return matrix[a.length][b.length];
}
