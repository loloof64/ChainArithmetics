import 'package:chain_arithmetics/widgets/constants.dart';
import 'package:flutter/material.dart';

class DigitalKeyboardWidget extends StatelessWidget {
  final void Function(int digit) insertDigit;
  final void Function() clearSelection;

  const DigitalKeyboardWidget({
    super.key,
    required this.insertDigit,
    required this.clearSelection,
  });

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
                _SingleButtonWidget(relatedDigit: 0, callback: insertDigit),
                _SingleButtonWidget(relatedDigit: 1, callback: insertDigit),
                _SingleButtonWidget(relatedDigit: 2, callback: insertDigit),
                _SingleButtonWidget(relatedDigit: 3, callback: insertDigit),
                _SingleButtonWidget(relatedDigit: 4, callback: insertDigit),
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
                _SingleButtonWidget(relatedDigit: 5, callback: insertDigit),
                _SingleButtonWidget(relatedDigit: 6, callback: insertDigit),
                _SingleButtonWidget(relatedDigit: 7, callback: insertDigit),
                _SingleButtonWidget(relatedDigit: 8, callback: insertDigit),
                _SingleButtonWidget(relatedDigit: 9, callback: insertDigit),
              ],
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.zero,
              minimumSize: Size(
                singleKeyboardButtonSize,
                singleKeyboardButtonSize,
              ),
              backgroundColor: Colors.red,
            ),
            onPressed: clearSelection,
            child: Text(
              "C",
              style: TextStyle(
                color: Colors.white,
                backgroundColor: Colors.red,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SingleButtonWidget extends StatelessWidget {
  final int relatedDigit;
  final void Function(int digit) callback;

  const _SingleButtonWidget({
    required this.relatedDigit,
    required this.callback,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.zero,
        minimumSize: Size(singleKeyboardButtonSize, singleKeyboardButtonSize),
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
