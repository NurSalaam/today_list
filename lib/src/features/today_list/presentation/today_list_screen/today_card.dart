import 'package:flutter/material.dart';

class TodayCard extends StatelessWidget {
  final String text;
  final bool completed;

  const TodayCard({Key? key, required this.text, this.completed = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: completed
          ? BoxDecoration(
              color: Colors.green.withOpacity(0.1),
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
            value: completed,
            onChanged: (bool? value) {
              // Add your onChanged code here
            },
          ),
          Expanded(
            child: Text(
              text,
            ),
          ),
        ],
      ),
    );
  }
}
