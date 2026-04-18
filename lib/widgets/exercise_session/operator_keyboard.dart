import 'package:chain_arithmetics/core/generators/common.dart';
import 'package:chain_arithmetics/widgets/constants.dart';
import 'package:flutter/material.dart';

class OperatorKeyboardWidget extends StatelessWidget {
  final void Function(Operator operator) setOperator;

  const OperatorKeyboardWidget({super.key, required this.setOperator});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 5,
        children: [
          _SingleButtonWidget(
            relatedOperator: Operator.add,
            callback: setOperator,
          ),
          _SingleButtonWidget(
            relatedOperator: Operator.sub,
            callback: setOperator,
          ),
          _SingleButtonWidget(
            relatedOperator: Operator.mult,
            callback: setOperator,
          ),
          _SingleButtonWidget(
            relatedOperator: Operator.divide,
            callback: setOperator,
          ),
        ],
      ),
    );
  }
}

class _SingleButtonWidget extends StatelessWidget {
  final Operator relatedOperator;
  final void Function(Operator operator) callback;

  const _SingleButtonWidget({
    required this.relatedOperator,
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
      onPressed: () => callback(relatedOperator),
      child: Text(
        relatedOperator.stringRepr(),
        style: TextStyle(color: Colors.white, backgroundColor: Colors.green),
      ),
    );
  }
}
