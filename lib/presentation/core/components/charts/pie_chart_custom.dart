// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import 'package:my_kakeibo/presentation/core/components/charts/indicator.dart';

class PieChartCustom extends StatefulWidget {
  final List<PieData> data;

  const PieChartCustom({super.key, required this.data});

  @override
  State<StatefulWidget> createState() => PieChart2State();
}

class PieChart2State extends State<PieChartCustom> {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    if(widget.data.isEmpty) return const SizedBox.shrink();

    return AspectRatio(
      aspectRatio: 2 / 1,
      child: Row(
        children: [
          Expanded(
            child: AspectRatio(
              aspectRatio: 1,
              child: PieChart(
                PieChartData(
                  pieTouchData: PieTouchData(
                    touchCallback: (FlTouchEvent event, pieTouchResponse) {
                      setState(() {
                        if (!event.isInterestedForInteractions ||
                            pieTouchResponse == null ||
                            pieTouchResponse.touchedSection == null) {
                          touchedIndex = -1;
                          return;
                        }
                        touchedIndex = pieTouchResponse
                            .touchedSection!.touchedSectionIndex;
                      });
                    },
                  ),
                  borderData: FlBorderData(
                    show: false,
                  ),
                  sectionsSpace: 0,
                  centerSpaceRadius: 40,
                  sections: makeSections(),
                ),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: widget.data.map((e) {
              return Column(
                children: [
                  Indicator(
                    color: e.color,
                    text: e.label,
                    isSquare: true,
                  ),
                  const SizedBox(height: 8),
                ],
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  List<PieChartSectionData> makeSections() {
    return List.generate(widget.data.length, (index) {
      final data = widget.data[index];
      final isTouched = index == touchedIndex;
      final fontSize = isTouched ? 20.0 : 12.0;
      final radius = isTouched ? 70.0 : 50.0;
      const shadows = [Shadow(color: Colors.black, blurRadius: 4)];

      return PieChartSectionData(
        color: data.color,
        value: data.value,
        title: data.title,
        radius: radius,
        titleStyle: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            shadows: shadows,
            decorationStyle: TextDecorationStyle.solid,
            decorationThickness: 3),
      );
    });
  }
}

class PieData {
  Color color;
  double value;
  String title;
  String label;

  PieData({
    required this.color,
    required this.value,
    required this.title,
    required this.label,
  });
}
