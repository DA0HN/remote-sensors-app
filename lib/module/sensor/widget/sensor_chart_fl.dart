import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'sensor_chart_config.dart';

// thanks https://github.com/kamilpowalowski/fluttersafari/tree/fl_chart
class SensorChartFl extends StatelessWidget {
  final SensorChartConfig config;
  final List<FlSpot> data;

  SensorChartFl({this.data, this.config});

  final _lineColor = 0xffe6e8ca;

  final List<Color> gradientColors = [
    const Color(0xff1fd166),
    const Color(0xff43f78b),
  ];

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        minY: config.minY,
        maxY: config.maxY,
        minX: config.minX,
        maxX: config.maxX,
        titlesData: FlTitlesData(
          show: true,
          bottomTitles: _bottomTitles(),
          leftTitles: _leftTitles(),
        ),
        axisTitleData: FlAxisTitleData(
          rightTitle: AxisTitle(showTitle: false, titleText: 'count'),
          leftTitle: AxisTitle(
            showTitle: true,
            titleText: 'Temperatura (ºC)',
            textStyle: TextStyle(
              color: Colors.deepOrangeAccent,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
            reservedSize: 20,
          ),
          bottomTitle: AxisTitle(
            showTitle: true,
            titleText: 'Tempo (minutos)',
            textStyle: TextStyle(
              color: Colors.deepOrangeAccent,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
            reservedSize: 20,
          ),
        ),
        gridData: FlGridData(
          show: true,
          getDrawingHorizontalLine: (value) {
            return FlLine(
              color: Color(_lineColor).withOpacity(0.2),
              strokeWidth: 1,
            );
          },
          checkToShowHorizontalLine: (value) {
            return (value - config.minX) % config.leftTitlesInterval == 0;
          },
          drawVerticalLine: false,
          drawHorizontalLine: true,
          getDrawingVerticalLine: (value) {
            return FlLine(
              color: Color(_lineColor).withOpacity(0.2),
              strokeWidth: 1,
            );
          },
        ),
        borderData: FlBorderData(
          show: true,
          border: Border.all(color: Color(_lineColor), width: 1),
        ),
        lineBarsData: [
          LineChartBarData(
            spots: this.data,
            isCurved: true,
            colors: gradientColors,
            barWidth: 1,
            dotData: FlDotData(show: false),
            belowBarData: BarAreaData(
              show: true,
              colors: gradientColors
                  .map((color) => color.withOpacity(0.3))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }

  SideTitles _bottomTitles() {
    return SideTitles(
      showTitles: true,
      reservedSize: 20,
      getTitles: (value) {
        final date = DateTime.fromMillisecondsSinceEpoch(value.toInt());
        return DateFormat(DateFormat.MINUTE_SECOND).format(date);
      },
      getTextStyles: (value) => const TextStyle(
        color: Colors.deepOrangeAccent,
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
      margin: 8,
      interval:
          config.isMinAndMaxXEqual ? null : (config.maxX - config.minX) / 4,
    );
  }

  SideTitles _leftTitles() {
    return SideTitles(
      showTitles: true,
      reservedSize: 50,
      getTitles: (value) => value.toStringAsFixed(2),
      getTextStyles: (value) => const TextStyle(
        color: Colors.deepOrangeAccent,
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
      margin: 10,
      interval: null,
    );
  }
}
