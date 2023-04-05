class TodayItem {
  final String text;
  final DateTime dateCreated;
  final bool isCompleted;

  TodayItem(
      {required this.text,
      required this.dateCreated,
      this.isCompleted = false});

  TodayItem copyWith({String? text, DateTime? dateCreated, bool? isCompleted}) {
    return TodayItem(
      text: text ?? this.text,
      dateCreated: dateCreated ?? this.dateCreated,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}
