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

  Future<SharedPreferences> _getSharedPreferences() async {
    return await SharedPreferences.getInstance();
  }

  // fetchAllTodayItems
  Future<List<TodayItem>> fetchAllTodayItems() async {
    SharedPreferences prefs = await _getSharedPreferences();
    List<String>? itemsJson = prefs.getStringList(kTodayItemKey);

    if (itemsJson == null) {
      return [];
    }

    return itemsJson.map((itemJson) => TodayItem.fromJson(itemJson)).toList();
  }

  Future<void> _saveItems(List<TodayItem> items) async {
    SharedPreferences prefs = await _getSharedPreferences();
    List<String> itemsJson = items.map((item) => item.toJson()).toList();
    await prefs.setStringList(kTodayItemKey, itemsJson);
    _updateItemsController();
  }

  // addTodayItem
  Future<void> addTodayItem(TodayItem item) async {
    List<TodayItem> allItems = await fetchAllTodayItems();
    allItems.add(item);
    await _saveItems(allItems);
  }

  // editTodayItem
  Future<void> editTodayItem(TodayItem updatedItem) async {
    List<TodayItem> allItems = await fetchAllTodayItems();
    int itemIndex = allItems.indexWhere((item) => item.id == updatedItem.id);

    if (itemIndex != -1) {
      allItems[itemIndex] = updatedItem;
      await _saveItems(allItems);
    } else {
      throw Exception('Item not found');
    }
  }

  // StreamController
  final StreamController<List<TodayItem>> _itemsController =
      StreamController.broadcast();
  Stream<List<TodayItem>> get itemsStream => _itemsController.stream;

  Future<void> _initializeItemsController() async {
    List<TodayItem> allItems = await fetchAllTodayItems();
    allItems.sort(
        (a, b) => a.dateCreated.compareTo(b.dateCreated)); // Sort items by id
    _itemsController.add(allItems);
  }

  Future<void> _updateItemsController() async {
    List<TodayItem> allItems = await fetchAllTodayItems();
    allItems.sort(
        (a, b) => a.dateCreated.compareTo(b.dateCreated)); // Sort items by id
    _itemsController.add(allItems);
  }

  Future<void> clearAllItems() async {
    SharedPreferences prefs = await _getSharedPreferences();
    await prefs
        .setStringList(kTodayItemKey, []); // Set an empty list to kTodayItemKey
    _itemsController.add([]);
  }

  void dispose() {
    _itemsController.close();
  }
}
