import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';
import '../domain/today_item.dart';

class TodayItemRepository {
  static const String kTodayItemKey = 'today_items';

  // Setup Singleton
  static final TodayItemRepository _instance = TodayItemRepository._internal();
  factory TodayItemRepository() => _instance;
  TodayItemRepository._internal() {
    _initializeItemsController();
  }
  // fetchAllTodayItems
  Future<List<TodayItem>> fetchAllTodayItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? itemsJson = prefs.getStringList(kTodayItemKey);

    if (itemsJson == null) {
      return [];
    }

    return itemsJson.map((itemJson) => TodayItem.fromJson(itemJson)).toList();
  }

  // addTodayItem
  Future<void> addTodayItem(TodayItem item) async {
    List<TodayItem> allItems = await fetchAllTodayItems();
    allItems.add(item);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> itemsJson = allItems.map((item) => item.toJson()).toList();
    await prefs.setStringList(kTodayItemKey, itemsJson);
    // * STREEEEEAAAAMMMSSS
    _updateItemsController();
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
      // * STREEEEEAAAAMMMSSS
      _updateItemsController();
    } else {
      throw Exception('Item not found');
    }
  }

  //* STREEEEEAAAAAMMMMMSSS
  // today_item_repository.dart

  // StreamController
  final StreamController<List<TodayItem>> _itemsController =
      StreamController.broadcast();
  Stream<List<TodayItem>> get itemsStream => _itemsController.stream;

  Future<void> _initializeItemsController() async {
    List<TodayItem> allItems = await fetchAllTodayItems();
    allItems.sort((a, b) => a.id.compareTo(b.id)); // Sort items by id
    _itemsController.add(allItems);
  }

  Future<void> _updateItemsController() async {
    List<TodayItem> allItems = await fetchAllTodayItems();
    allItems.sort((a, b) => a.id.compareTo(b.id)); // Sort items by id
    _itemsController.add(allItems);
  }

  Stream<List<TodayItem>> streamAllTodayItems() async* {
    while (true) {
      await Future.delayed(const Duration(
          seconds: 1)); // Adjust the duration according to your needs
      yield await fetchAllTodayItems();
    }
  }

  Future<void> clearAllItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs
        .setStringList(kTodayItemKey, []); // Set an empty list to kTodayItemKey

    // Clear the repository
    _itemsController.add([]);
  }
}
