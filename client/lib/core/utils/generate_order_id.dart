import 'dart:math';

String generateRandomString({int length = 10}) {
  const characters = '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
  final random = Random();
  return String.fromCharCodes(Iterable.generate(
    length,
    (_) => characters.codeUnitAt(random.nextInt(characters.length)),
  ));
}

String generateOrderId() {
  final now = DateTime.now();
  final dateStr = '${now.year}${_twoDigits(now.month)}${_twoDigits(now.day)}${_twoDigits(now.hour)}${_twoDigits(now.minute)}';
  return 'INFRA$dateStr${generateRandomString(length: 6)}';
}

String _twoDigits(int n) => n.toString().padLeft(2, '0');
