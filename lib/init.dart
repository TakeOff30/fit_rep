import 'package:fit_rep/providers/settings_manager.dart';
import 'package:fit_rep/providers/statistics_manager.dart';
import 'package:fit_rep/providers/workouts_manager.dart';

void init() {
  final WorkoutsManager _workoutsManager = WorkoutsManager();
  final SettingsManager _settingsManager = SettingsManager();
  final StatisticsManager _statisticsManager = StatisticsManager();
  // _workoutsManager.loadWorkouts();
  // _settingsManager.loadSettings();
  // _statisticsManager.loadStatistics();
  
}