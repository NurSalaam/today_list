import 'package:flutter/material.dart';

Future<void> showAddTodayItemDialog(BuildContext context) async {
  await showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (BuildContext context) {
      double textFieldWidth = MediaQuery.of(context).size.width -
          32; // 32 is the sum of left and right padding

      void handleAddTodayItem() {
        // TODO: Handle add to list logic
        Navigator.pop(context);
      }

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
                  autofocus: true,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                  onFieldSubmitted: (value) => handleAddTodayItem(),
                  decoration: const InputDecoration(
                    hintText: "You sure this is necessary...?",
                    contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: textFieldWidth,
                child: TextButton(
                  onPressed: () {
                    // TODO: Handle button press logic
                    // ! Remeber you cant add blanck to dos
                    Navigator.of(context).pop();
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Theme.of(context).colorScheme.secondary,
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 24),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: const Text("Add ToDay"),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
