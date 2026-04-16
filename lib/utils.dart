import 'dart:math';

int numberOfDigits(int n) {
  if (n == 0) return 1;
  return 1 + (log(n) / ln10).floor();
}
