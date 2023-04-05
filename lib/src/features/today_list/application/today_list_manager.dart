import 'package:shared_preferences/shared_preferences.dart';
import 'package:today_list/src/features/today_list/data/today_item_repository.dart';

class TodayListManager {
  // Singleton instance
  static final TodayListManager _instance = TodayListManager._internal();

  factory TodayListManager() {
    return _instance;
  }

  TodayListManager._internal() {
    _loadLastCheckedDate();
    _setupPeriodicCheck();
  }

  DateTime _lastCheckedDate = DateTime.now();

  Future<void> _loadLastCheckedDate() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int lastCheckedTimestamp = prefs.getInt('lastCheckedDate') ?? 0;
    if (lastCheckedTimestamp != 0) {
      _lastCheckedDate =
          DateTime.fromMillisecondsSinceEpoch(lastCheckedTimestamp);
    }
  }

  Future<void> _saveLastCheckedDate() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(
        'lastCheckedDate', _lastCheckedDate.millisecondsSinceEpoch);
  }

  void _setupPeriodicCheck() {
    // Run the check every minute
    Future.delayed(const Duration(minutes: 1), () {
      _periodicCheck();
      _setupPeriodicCheck();
    });
  }

  void _periodicCheck() {
    DateTime now = DateTime.now();
    if (now.day != _lastCheckedDate.day ||
        now.month != _lastCheckedDate.month ||
        now.year != _lastCheckedDate.year) {
      _clearTodays();
      _lastCheckedDate = now;
      _saveLastCheckedDate();
    }
  }

  void _clearTodays() {
    TodayItemRepository().clearAllItems();
  }
}
