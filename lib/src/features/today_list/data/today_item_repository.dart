import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';
import '../domain/today_item.dart';

class TodayItemRepository {
  static const String kTodayItemKey = 'today_items';

  // Setup Singleton
  static final TodayItemRepository _instance = TodayItemRepository._internal();
  factory TodayItemRepository() => _instance;
  TodayItemRepository._internal();

  // fetchAllTodayItems
  Future<List<TodayItem>> fetchAllTodayItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? itemsJson = prefs.getStringList(kTodayItemKey);

    if (itemsJson == null) {
      return [];
    }

    return itemsJson.map((itemJson) => TodayItem.fromJson(itemJson)).toList();
  }

  // fetchIncompleteTodayItems
  Future<List<TodayItem>> fetchIncompleteTodayItems() async {
    List<TodayItem> allItems = await fetchAllTodayItems();
    return allItems.where((item) => !item.isCompleted).toList();
  }

  // fetchCompleteTodayItems
  Future<List<TodayItem>> fetchCompleteTodayItems() async {
    List<TodayItem> allItems = await fetchAllTodayItems();
    return allItems.where((item) => item.isCompleted).toList();
  }

  // addTodayItem
  Future<void> addTodayItem(TodayItem item) async {
    print('addTodayItem: $item');
    List<TodayItem> allItems = await fetchAllTodayItems();
    allItems.add(item);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> itemsJson = allItems.map((item) => item.toJson()).toList();
    await prefs.setStringList(kTodayItemKey, itemsJson);
  }

  // editTodayItem
  Future<void> editTodayItem(TodayItem updatedItem) async {
    List<TodayItem> allItems = await fetchAllTodayItems();
    int itemIndex = allItems.indexWhere((item) => item.id == updatedItem.id);

    if (itemIndex != -1) {
      allItems[itemIndex] = updatedItem;

      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String> itemsJson = allItems.map((item) => item.toJson()).toList();
      await prefs.setStringList(kTodayItemKey, itemsJson);
    } else {
      throw Exception('Item not found');
    }
  }
}
