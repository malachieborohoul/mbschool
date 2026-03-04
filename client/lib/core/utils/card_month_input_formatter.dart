import 'package:flutter/services.dart';

class CardMonthInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var newText = newValue.text.replaceAll(RegExp(r'[^0-9]'), ''); // Supprime les caractères non numériques
    if (newText.length > 4) {
      newText = newText.substring(0, 4); // Limite à 4 chiffres
    }
    var buffer = StringBuffer();
    for (int i = 0; i < newText.length; i++) {
      buffer.write(newText[i]);
      if (i == 1 && newText.length > 2) {
        buffer.write('/'); // Ajoute le séparateur après 2 chiffres
      }
    }
    var string = buffer.toString();
    return newValue.copyWith(
      text: string,
      selection: TextSelection.collapsed(offset: string.length),
    );
  }
}