import 'dart:convert';
import 'package:uuid/uuid.dart';

class TodayItem {
  final String id;
  final String text;
  final DateTime dateCreated;
  final bool isCompleted;

  TodayItem({
    String? id,
    required this.text,
    required this.dateCreated,
    this.isCompleted = false,
  }) : id = id ?? const Uuid().v4();

  TodayItem copyWith(
      {String? id, String? text, DateTime? dateCreated, bool? isCompleted}) {
    return TodayItem(
      id: id ?? this.id,
      text: text ?? this.text,
      dateCreated: dateCreated ?? this.dateCreated,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'text': text,
      'dateCreated': dateCreated.toIso8601String(),
      'isCompleted': isCompleted,
    };
  }

  factory TodayItem.fromMap(Map<String, dynamic> map) {
    return TodayItem(
      id: map['id'],
      text: map['text'],
      dateCreated: DateTime.parse(map['dateCreated']),
      isCompleted: map['isCompleted'],
    );
  }

  String toJson() => json.encode(toMap());

  factory TodayItem.fromJson(String source) =>
      TodayItem.fromMap(json.decode(source));
}
