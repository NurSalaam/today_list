import 'package:flutter/material.dart';
import 'package:today_list/src/features/today_list/data/today_item_repository.dart';
import 'package:today_list/src/features/today_list/domain/today_item.dart';
import 'package:today_list/src/features/today_list/presentation/today_list_screen/edit_today_item_dialog.dart';

class TodayCard extends StatelessWidget {
  final TodayItem todayItem;

  const TodayCard({Key? key, required this.todayItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    Color greenColor = isDarkMode
        ? Colors.green.withOpacity(0.35)
        : Colors.green.withOpacity(0.1);
    Color checkboxColor = isDarkMode ? Colors.white : Colors.black;
    Color checkColor = isDarkMode ? Colors.black : Colors.white;
    return GestureDetector(
      onTap: () {
        if (!todayItem.isCompleted) {
          showEditTodayItemDialog(context, todayItem);
        }
      },
      child: Container(
        decoration: todayItem.isCompleted
            ? BoxDecoration(
                color: greenColor,
                borderRadius: BorderRadius.circular(8),
              )
            : null,
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Row(
          children: [
            Checkbox(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              checkColor: checkColor,
              fillColor: MaterialStateProperty.resolveWith((states) {
                if (states.contains(MaterialState.selected)) {
                  return checkboxColor;
                }
                return isDarkMode ? Colors.white54 : Colors.black54;
              }),
              value: todayItem.isCompleted,
              onChanged: (bool? value) {
                bool isComplete = !todayItem.isCompleted;
                TodayItem updatedItem =
                    todayItem.copyWith(isCompleted: isComplete);
                TodayItemRepository().editTodayItem(updatedItem);
              },
            ),
            Expanded(
              child: Text(
                todayItem.text,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
