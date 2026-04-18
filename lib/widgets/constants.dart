import 'package:chain_arithmetics/core/generators/operations/operation.dart';
import 'package:flutter/material.dart';

const commonFontSize = 60.0;
const commonFontWeight = 900;
const maxBufferOperations = 5;
const penaltyTimeSeconds = 5;
const oneMinuteModeQuestionsCount = 35;
final dummyOperation = Operation(
  operand_1: 0,
  operand_2: 0,
  result: 0,
  relatedOperator: Operator.add,
);

const flagTooltipDurationMs = 1800;
const penaltyTooltipDurationMs = 600;
const defaultTooltipFontSize = 18.0;
const maxAllocatedTimeMinutes = 5;
final flagTooltipOffset = Offset(30, 100);
final penaltyTooltipOffset = Offset(300, 100);
