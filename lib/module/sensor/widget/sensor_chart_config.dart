class SensorChartConfig {
  double minY = 0;
  double maxY = 0;
  double minX = 0;
  double maxX = 0;
  double leftTitlesInterval = 0;

  int leftLabelsCount = 6;

  SensorChartConfig({
    this.minY,
    this.maxY,
    this.minX,
    this.maxX,
    this.leftLabelsCount,
  });

  bool get isMinAndMaxXEqual => this.maxX == this.minX;
}
