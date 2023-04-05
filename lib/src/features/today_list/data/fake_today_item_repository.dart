import 'package:today_list/src/constants/test_today_items.dart';
import 'package:today_list/src/features/today_list/domain/today_item.dart';

class FakeTodayItemRepository {
  FakeTodayItemRepository._(); //* creates a singleton instance of the class
  static FakeTodayItemRepository instance = FakeTodayItemRepository._();

  final List<TodayItem> _todayItems = kTodayItems;

  List<TodayItem> getTodayItems() {
    return _todayItems;
  }

  List<TodayItem> getCompleteItems() {
    return _todayItems.where((item) => item.isCompleted).toList();
  }

  List<TodayItem> getIncompleteItems() {
    return _todayItems.where((item) => !item.isCompleted).toList();
  }

  Future<List<TodayItem>> fetchTodayItems() {
    return Future.value(_todayItems);
  }

  Stream<List<TodayItem>> watchTodayItems() {
    return Stream.value(_todayItems);
  }
}
