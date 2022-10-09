import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../data/pie_data.dart';

List<PieChartSectionData> getSections(int touchedIndex) => PieData.data
    .asMap()
    .map<int, PieChartSectionData>((index, data) {
  final isTouched = index == touchedIndex;
  final double fontSize =  16;
  final double radius =  80;
 print(data.val);
  final value = PieChartSectionData(
    color: data.color,
    value: data.val,
    title: '${data.val}',
    radius: radius,
    titleStyle: TextStyle(
      fontSize: fontSize,
      fontWeight: FontWeight.bold,
      color: const Color(0xffffffff),
    ),
  );

  return MapEntry(index, value);
})
    .values
    .toList();