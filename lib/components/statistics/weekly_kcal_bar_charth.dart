import 'package:fit_rep/providers/settings_manager.dart';
import 'package:fit_rep/providers/statistics_manager.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:provider/provider.dart';

class AppColors {
  static Color primaryColor = Color.fromARGB(255, 80, 200, 120);
}

LinearGradient get _barsGradient => LinearGradient(
      colors: [
        AppColors.primaryColor.withOpacity(1.0),
        AppColors.primaryColor.withOpacity(0.4)
      ],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    );

class WeeklyKcalChart extends StatefulWidget {
  final int selectedBarIndex;
  final Function(int) onBarTap;

  const WeeklyKcalChart({
    Key? key,
    required this.selectedBarIndex,
    required this.onBarTap,
  }) : super(key: key);

  @override
  _WeeklyKcalChartState createState() => _WeeklyKcalChartState();
}

class _WeeklyKcalChartState extends State<WeeklyKcalChart> {
  int selectedBarIndex = 0;

  @override
  Widget build(BuildContext context) {
    var _statisticsProvider = Provider.of<StatisticsManager>(context);
    var settingsProvider = Provider.of<SettingsManager>(context);
    return SizedBox(
      height: 200,
      width: 400,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0),
        child: BarChart(
          BarChartData(
            barGroups: getBarGroups(
                _statisticsProvider.weeklyCalories.values.toList()),
            gridData: FlGridData(show: false),
            borderData: FlBorderData(show: false),
            titlesData: FlTitlesData(
              show: true,
              topTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              rightTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              leftTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 40,
                  getTitlesWidget: (value, meta) {
                    final titles = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
                    return Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(
                        titles[value.toInt() % titles.length],
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Kanit',
                          fontSize: 14,
                          color: settingsProvider.isDarkMode
                              ? Theme.of(context).primaryColorLight
                              : Theme.of(context).primaryColorDark,
                        ),
                      ),
                    );
                  },
                  interval: 1,
                ),
              ),
            ),
            groupsSpace: 35,
            alignment: BarChartAlignment.center,
            barTouchData: BarTouchData(
              enabled: true,
              touchCallback: (FlTouchEvent event, BarTouchResponse? response) {
                if (event is FlTapUpEvent && response != null) {
                  setState(() {
                    if (response.spot != null) {
                      selectedBarIndex = response.spot!.touchedBarGroupIndex;
                    }
                  });
                }
              },
              touchTooltipData: BarTouchTooltipData(
                getTooltipItem: (group, groupIndex, rod, rodIndex) {
                  return BarTooltipItem(
                    rod.toY.toString() + ' kcal',
                    TextStyle(
                        fontSize:
                            Theme.of(context).textTheme.bodyMedium!.fontSize,
                        fontWeight:
                            Theme.of(context).textTheme.bodyMedium!.fontWeight,
                        fontFamily:
                            Theme.of(context).textTheme.bodyMedium!.fontFamily,
                        color: settingsProvider.isDarkMode
                            ? Theme.of(context).primaryColorLight
                            : Theme.of(context).primaryColorDark),
                  );
                },
                getTooltipColor: (group) => Colors.transparent,
                tooltipBorder: BorderSide(color: Colors.transparent),
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<BarChartGroupData> getBarGroups(List<int> values) =>
      List.generate(values.length, (index) {
        return BarChartGroupData(
          x: index,
          barRods: [
            BarChartRodData(
                toY: values[index].toDouble(),
                gradient: selectedBarIndex == index ? _barsGradient : null,
                color: selectedBarIndex == index
                    ? Colors.transparent
                    : Color(0xFFC0C0C0),
                width: 16)
          ],
        );
      });
}
