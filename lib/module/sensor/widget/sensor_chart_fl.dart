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

  final List<Color> _gradientColors = [
    const Color(0xFFED1F18),
    const Color(0xFFF06E3E),
    const Color(0xFFDBDB2C),
    const Color(0xFF2FDEC4),
    const Color(0xFF009FF5),
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
        axisTitleData: _flAxisTitleData(),
        gridData: _flGridData(),
        borderData: _flBorderData(),
        lineBarsData: [_lineBarsData()],
      ),
    );
  }

  FlAxisTitleData _flAxisTitleData() {
    return FlAxisTitleData(
      leftTitle: AxisTitle(
        showTitle: true,
        titleText: 'Temperatura (ºC)',
        textStyle: TextStyle(
          color: Colors.deepOrange,
          fontWeight: FontWeight.w300,
          fontSize: 18,
        ),
        reservedSize: 20,
      ),
      bottomTitle: AxisTitle(
        showTitle: true,
        titleText: 'Tempo (minutos)',
        textStyle: TextStyle(
          color: Colors.deepOrange,
          fontWeight: FontWeight.w300,
          fontSize: 18,
        ),
        reservedSize: 20,
      ),
    );
  }

  FlGridData _flGridData() {
    return FlGridData(
      show: true,
      getDrawingHorizontalLine: (value) {
        return FlLine(
          color: Color(_lineColor).withOpacity(0.3),
          strokeWidth: 1,
        );
      },
      checkToShowHorizontalLine: (value) {
        return (value - config.minX) % config.leftTitlesInterval == 0;
      },
      // drawVerticalLine: true,
      // drawHorizontalLine: true,
      getDrawingVerticalLine: (value) {
        return FlLine(
          color: Color(_lineColor).withOpacity(0.3),
          strokeWidth: 1,
        );
      },
    );
  }

  FlBorderData _flBorderData() {
    return FlBorderData(
      show: true,
      border: Border.all(color: Color(_lineColor), width: 1),
    );
  }

  LineChartBarData _lineBarsData() {
    return LineChartBarData(
      spots: this.data,
      isCurved: true,
      colors: _gradientColors,
      colorStops: const [0.25, 0.5, 0.75],
      gradientFrom: const Offset(0.5, 0),
      gradientTo: const Offset(0.5, 1),
      barWidth: 2,
      isStrokeCapRound: true,
      dotData: FlDotData(show: false),
      belowBarData: BarAreaData(
        show: true,
        colors: _gradientColors.map((color) => color.withOpacity(0.5)).toList(),
        gradientColorStops: const [0.125, 0.25, 0.5, 0.75],
        gradientFrom: const Offset(0.5, 0),
        gradientTo: const Offset(0.5, 1),
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
        color: Colors.deepOrange,
        fontWeight: FontWeight.w400,
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
        color: Colors.deepOrange,
        fontWeight: FontWeight.w400,
        fontSize: 16,
      ),
      margin: 10,
      interval: this.config.leftTitlesInterval == 0
          ? null
          : this.config.leftTitlesInterval,
    );
  }
}
