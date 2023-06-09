import 'package:flutter/material.dart';
import 'package:today_list/src/constants/app_sizes.dart';

import '../../data/today_item_repository.dart';
import '../../domain/today_item.dart';

Future<void> showAddTodayItemDialog(BuildContext context) async {
  final TextEditingController textController = TextEditingController();

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

                    if (text.isNotEmpty) {
                      TodayItem todayItem =
                          TodayItem(text: text, dateCreated: DateTime.now());
                      await TodayItemRepository().addTodayItem(todayItem);
                    }
                    Navigator.of(context).pop();
                  },
                  decoration: const InputDecoration(
                    hintText: "You sure this is necessary...?",
                    contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                  ),
                ),
              ),
              gapW16,
            ],
          ),
        ),
      );
    },
  );
}
