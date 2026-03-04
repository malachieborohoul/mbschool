String formatRate(double value) {
  // Convertir en chaîne avec 4 décimales
  String formatted = value.toStringAsFixed(4);

  // Supprimer les zéros inutiles à la fin
  formatted = formatted.replaceAll(RegExp(r'0*$'), '');

  // Supprimer le point décimal si nécessaire
  if (formatted.endsWith('.')) {
    formatted = formatted.substring(0, formatted.length - 1);
  }

  return formatted;
}