import 'package:flutter/services.dart';

class CardNumberFormatter extends TextInputFormatter {
  static const int maxLength = 16; // Max 19 chiffres pour une carte

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String digitsOnly = newValue.text.replaceAll(RegExp(r'\D'), ''); // Garde seulement les chiffres

    if (digitsOnly.length > maxLength) {
      return oldValue; // Empêche d'entrer plus que 19 chiffres
    }

    String formatted = '';
    for (int i = 0; i < digitsOnly.length; i++) {
      if (i > 0 && i % 4 == 0) {
        formatted += ' '; // Ajoute un espace après chaque 4 chiffres
      }
      formatted += digitsOnly[i];
    }

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}
