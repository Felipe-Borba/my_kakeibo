import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class BarChartCustom extends StatefulWidget {
  final List<BarData> data;
  final String title;
  final String incomeLabel;
  final String expenseLabel;

  const BarChartCustom({
    super.key,
    required this.data,
    required this.title,
    required this.incomeLabel,
    required this.expenseLabel,
  });

  @override
  State<StatefulWidget> createState() => BarChartCustomState();
}

class BarChartCustomState extends State<BarChartCustom> {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    if (widget.data.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.title, style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 16),
        AspectRatio(
          aspectRatio: 1.5,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: BarChart(
              BarChartData(
                barTouchData: BarTouchData(
                  touchTooltipData: BarTouchTooltipData(
                    // tooltipBgColor: Colors.grey.shade700,
                    getTooltipItem: (group, groupIndex, rod, rodIndex) {
                      final data = widget.data[groupIndex];
                      String label = '';
                      if (rodIndex == 0) {
                        label =
                            '${widget.incomeLabel}: \$${data.income.toStringAsFixed(2)}';
                      } else {
                        label =
                            '${widget.expenseLabel}: \$${data.expense.toStringAsFixed(2)}';
                      }
                      return BarTooltipItem(
                        label,
                        const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    },
                  ),
                  touchCallback: (FlTouchEvent event, barTouchResponse) {
                    setState(() {
                      if (!event.isInterestedForInteractions ||
                          barTouchResponse == null ||
                          barTouchResponse.spot == null) {
                        touchedIndex = -1;
                        return;
                      }
                      touchedIndex =
                          barTouchResponse.spot!.touchedBarGroupIndex;
                    });
                  },
                ),
                titlesData: FlTitlesData(
                  show: true,
                  rightTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            widget.data[value.toInt()].month,
                            style: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                      },
                      reservedSize: 30,
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 40,
                      getTitlesWidget: (value, meta) {
                        return Text(
                          '\$${value.toInt()}',
                          style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      },
                    ),
                  ),
                ),
                borderData: FlBorderData(
                  show: false,
                ),
                gridData: FlGridData(
                  show: true,
                  horizontalInterval: _calculateInterval(widget.data),
                  verticalInterval: 1 / 12,
                  checkToShowVerticalLine: (value) =>
                      (value * 12).ceil() % 2 == 1,
                  getDrawingHorizontalLine: (value) {
                    return FlLine(
                      color: Colors.grey.withOpacity(0.2),
                      strokeWidth: 1,
                    );
                  },
                  getDrawingVerticalLine: (value) {
                    return FlLine(
                      color: Colors.grey.withOpacity(0.5),
                      strokeWidth: 1,
                      dashArray: [5, 5],
                    );
                  },
                ),
                barGroups: List.generate(widget.data.length, (index) {
                  final data = widget.data[index];
                  const double width = 22;

                  return BarChartGroupData(
                    x: index,
                    barRods: [
                      BarChartRodData(
                        toY: data.income,
                        color: Colors.green,
                        width: width,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(6),
                          topRight: Radius.circular(6),
                        ),
                        rodStackItems: [
                          BarChartRodStackItem(0, data.income, Colors.green),
                        ],
                        backDrawRodData: BackgroundBarChartRodData(
                          show: true,
                          toY: _findMaxValue(widget.data) * 1.1,
                          color: Colors.grey.withOpacity(0.1),
                        ),
                      ),
                      BarChartRodData(
                        toY: data.expense,
                        color: Colors.red,
                        width: width,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(6),
                          topRight: Radius.circular(6),
                        ),
                        rodStackItems: [
                          BarChartRodStackItem(0, data.expense, Colors.red),
                        ],
                        backDrawRodData: BackgroundBarChartRodData(
                          show: true,
                          toY: _findMaxValue(widget.data) * 1.1,
                          color: Colors.grey.withOpacity(0.1),
                        ),
                      ),
                    ],
                  );
                }),
                maxY: _findMaxValue(widget.data) * 1.1,
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        _buildLegend(),
      ],
    );
  }

  Widget _buildLegend() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildLegendItem(Colors.green, widget.incomeLabel),
        const SizedBox(width: 20),
        _buildLegendItem(Colors.red, widget.expenseLabel),
      ],
    );
  }

  Widget _buildLegendItem(Color color, String label) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 4),
        Text(label),
      ],
    );
  }

  double _findMaxValue(List<BarData> data) {
    double max = 0;
    for (var item in data) {
      if (item.income > max) max = item.income;
      if (item.expense > max) max = item.expense;
    }
    return max;
  }

  double _calculateInterval(List<BarData> data) {
    double maxValue = _findMaxValue(data);
    if(maxValue == 0) {
      maxValue = 5;
    };
    // Tentar criar 5 linhas de grade
    return maxValue / 5;
  }
}

class BarData {
  final String month;
  final double income;
  final double expense;

  BarData({
    required this.month,
    required this.income,
    required this.expense,
  });
}
