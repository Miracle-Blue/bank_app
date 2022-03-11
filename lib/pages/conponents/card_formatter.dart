import 'package:flutter/services.dart';

class CardInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final digitOnly = newValue.text.replaceAll(RegExp(r'[^\d]+'), '');
    final initialSpecialSymbolCount = newValue.selection
        .textBefore(newValue.text)
        .replaceAll(RegExp(r'[\d]+'), '')
        .length;
    final cursorPosition = newValue.selection.start - initialSpecialSymbolCount;
    var finalCursorPosition = cursorPosition;
    final digitOnlyChars = digitOnly.split('');

    if (oldValue.selection.textInside(oldValue.text) == ' ') {
      digitOnlyChars.removeAt(cursorPosition - 1);
      finalCursorPosition -= 2;
    }

    var newString = <String>[];
    for (int i = 0; i < digitOnlyChars.length; i++) {
      if (i == 4 || i == 8 || i == 12) {
        newString.add(' ');
        newString.add(digitOnlyChars[i]);
        if (i <= cursorPosition) finalCursorPosition += 1;
      } else {
        newString.add(digitOnlyChars[i]);
      }
      if (i > 15) {
        newString.removeLast();
        finalCursorPosition -= 1;
      }
    }

    final resultString = newString.join('');

    return TextEditingValue(
      text: resultString,
      selection: TextSelection.collapsed(offset: finalCursorPosition),
    );
  }
}