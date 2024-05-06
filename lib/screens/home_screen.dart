import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

// Gradient color for the bars in the bar chart
class AppColors {
  static Color primaryColor = Color(0xFF39FF14); // Green color
}

LinearGradient get _barsGradient => LinearGradient(
      colors: [
        AppColors.primaryColor.withOpacity(1.0),
        AppColors.primaryColor.withOpacity(0.4)
      ],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    );

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIcon = 3; // Default selection for "Weekly kcal"
  int? selectedBarIndex; // Variable to keep track of the selected bar

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E1E1E),
      body: Container(
        margin: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const Center(
              child: Text(
                'Weekly Statistics',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Roboto',
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 50),
            Center(
              child: Container(
                width: 300,
                height: 260,
                decoration: BoxDecoration(
                  color: const Color(0xFF1E1E1E),
                  border: Border.all(color: const Color(0xFFC0C0C0), width: 2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: Row(
                        children: <Widget>[
                          _buildIconSection(
                              Icons.emoji_events, '3', true, true),
                          _buildIconSection(
                              Icons.fitness_center, '0/3', false, true),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: <Widget>[
                          _buildIconSection(Icons.local_fire_department,
                              'XXX KCAL', true, false),
                          _buildIconSection(
                              Icons.timer, 'XXX MIN', false, false),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 80),
            _buildIconRow(),
            const SizedBox(height: 80),
            if (_selectedIcon ==
                3) // Display bar chart if "Weekly kcal" is selected
              SizedBox(
                height: 200,
                width: 400,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0),
                  child: BarChart(
                    BarChartData(
                      // Barchart configuration
                      barGroups: getBarGroups(),
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
                              final titles = [
                                'M',
                                'T',
                                'W',
                                'T',
                                'F',
                                'S',
                                'S'
                              ];
                              return Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Text(
                                  titles[value.toInt() % titles.length],
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Roboto',
                                    fontSize: 14,
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
                        touchCallback:
                            (FlTouchEvent event, BarTouchResponse? response) {
                          if (event is FlTapUpEvent && response != null) {
                            setState(() {
                              selectedBarIndex =
                                  response.spot!.touchedBarGroupIndex;
                            });
                          }
                        },
                        touchTooltipData: BarTouchTooltipData(
                          getTooltipItem: (group, groupIndex, rod, rodIndex) {
                            return BarTooltipItem(
                              rod.toY.toString() + ' kcal',
                              TextStyle(color: Colors.white),
                            );
                          },
                          getTooltipColor: (group) => Colors.transparent,
                          tooltipBorder: BorderSide(color: Colors.transparent),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  List<BarChartGroupData> getBarGroups() => List.generate(7, (index) {
        return BarChartGroupData(
          x: index,
          barRods: [
            BarChartRodData(
                toY: [0.0, 200.0, 0.0, 500.0, 350.0, 0.0, 0.0][index],
                gradient: selectedBarIndex == index ? _barsGradient : null,
                color: selectedBarIndex == index
                    ? Colors.transparent
                    : Color(0xFFC0C0C0),
                width: 16)
          ],
        );
      });

  Widget _buildIconRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        _iconButton(3, Icons.local_fire_department, 'Weekly kcal'),
        _iconButton(1, Icons.trending_up, 'Level'),
        _iconButton(2, Icons.fitness_center, 'Muscles'),
      ],
    );
  }

  Widget _iconButton(int id, IconData icon, String label) {
    bool isSelected = _selectedIcon == id;
    return Column(
      children: <Widget>[
        IconButton(
          icon: Icon(icon, size: 40),
          color: isSelected ? const Color(0xFF39FF14) : const Color(0xFFC0C0C0),
          onPressed: () {
            setState(() {
              _selectedIcon = _selectedIcon == id ? 0 : id;
            });
          },
        ),
        if (isSelected)
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.bold,
              fontFamily: 'Roboto',
            ),
          ),
      ],
    );
  }

  Widget _buildIconSection(
      IconData icon, String label, bool borderRight, bool borderBottom) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            right: borderRight
                ? const BorderSide(width: 2, color: Color(0xFFC0C0C0))
                : BorderSide.none,
            bottom: borderBottom
                ? const BorderSide(width: 2, color: Color(0xFFC0C0C0))
                : BorderSide.none,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(icon, size: 32, color: const Color(0xFF39FF14)),
              const SizedBox(height: 8),
              Text(label,
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontFamily: 'Roboto')),
            ],
          ),
        ),
      ),
    );
  }
}
