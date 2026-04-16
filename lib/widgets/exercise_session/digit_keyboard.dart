import 'package:flutter/material.dart';

class DigitalKeyboardWidget extends StatelessWidget {
  final void Function(int digit) insertDigit;

  const DigitalKeyboardWidget({super.key, required this.insertDigit});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 5.0,
        children: [
          Flexible(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              spacing: 5,
              children: [
                SingleButtonWidget(relatedDigit: 0, callback: insertDigit),
                SingleButtonWidget(relatedDigit: 1, callback: insertDigit),
                SingleButtonWidget(relatedDigit: 2, callback: insertDigit),
                SingleButtonWidget(relatedDigit: 3, callback: insertDigit),
                SingleButtonWidget(relatedDigit: 4, callback: insertDigit),
              ],
            ),
          ),
          Flexible(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              spacing: 5,
              children: [
                SingleButtonWidget(relatedDigit: 5, callback: insertDigit),
                SingleButtonWidget(relatedDigit: 6, callback: insertDigit),
                SingleButtonWidget(relatedDigit: 7, callback: insertDigit),
                SingleButtonWidget(relatedDigit: 8, callback: insertDigit),
                SingleButtonWidget(relatedDigit: 9, callback: insertDigit),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SingleButtonWidget extends StatelessWidget {
  final int relatedDigit;
  final void Function(int digit) callback;

  const SingleButtonWidget({
    super.key,
    required this.relatedDigit,
    required this.callback,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.zero,
        minimumSize: Size(36, 36),
        backgroundColor: Colors.green,
      ),
      onPressed: () => callback(relatedDigit),
      child: Text(
        relatedDigit.toString(),
        style: TextStyle(color: Colors.white, backgroundColor: Colors.green),
      ),
    );
  }
}
