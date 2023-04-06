import 'package:flutter/material.dart';

import '../../data/today_item_repository.dart';
import '../../domain/today_item.dart';

Future<void> showEditTodayItemDialog(
    BuildContext context, TodayItem todayItem) async {
  final TextEditingController textController =
      TextEditingController(text: todayItem.text);

  await showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (BuildContext context) {
      double textFieldWidth = MediaQuery.of(context).size.width -
          32; // 32 is the sum of left and right padding

      return Container(
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        padding: EdgeInsets.only(
          left: 16,
          top: 16,
          right: 16,
          bottom: MediaQuery.of(context).viewInsets.bottom + 16,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: textFieldWidth,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(15),
                ),
                child: TextFormField(
                  controller: textController,
                  autofocus: true,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                  onFieldSubmitted: (value) async {
                    String text = textController.text.trim();

                    editItem(context, text, todayItem);
                  },
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      );
    },
  );
}

void editItem(context, String text, TodayItem todayItem) async {
  if (text.isNotEmpty) {
    TodayItem updatedTodayItem = todayItem.copyWith(text: text);
    await TodayItemRepository().editTodayItem(updatedTodayItem);
  }
  Navigator.of(context).pop();
}
