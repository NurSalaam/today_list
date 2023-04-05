import 'package:today_list/src/constants/test_today_items.dart';
import 'package:today_list/src/features/today_list/domain/today_item.dart';

class FakeTodayItemRepository {
  FakeTodayItemRepository._(); //* creates a singleton instance of the class
  static FakeTodayItemRepository instance = FakeTodayItemRepository._();

  final List<TodayItem> _todayItems = kTodayItems;

  List<TodayItem> getCompleteItems() {
    return _todayItems.where((item) => item.isCompleted).toList();
  }

  List<TodayItem> getIncompleteItems() {
    return _todayItems.where((item) => !item.isCompleted).toList();
  }

  Future<List<TodayItem>> fetchCompleteItems() async {
    return Future.value(_todayItems.where((item) => item.isCompleted).toList());
  }

  Future<List<TodayItem>> fetchIncompleteItems() async {
    return Future.value(
        _todayItems.where((item) => !item.isCompleted).toList());
  }

  void clearItems() {
    _todayItems.clear();
  }

  // Stream<List<TodayItem>> watchTodayItems() {
  //   return Stream.value(_todayItems);
  // }
}
