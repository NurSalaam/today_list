import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  CustomAppBar({Key? key}) : super(key: key);

  final DateTime currentDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final String formattedDate =
        '${currentDate.year}-${currentDate.month.toString().padLeft(2, '0')}-${currentDate.day.toString().padLeft(2, '0')}';
    return SliverAppBar(
      expandedHeight: 100,
      flexibleSpace: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          double percentageCollapsed = 1 -
              ((constraints.maxHeight - kToolbarHeight) /
                  (100 - kToolbarHeight));
          Color backgroundColor = Colors.black;
          return Container(
            color: backgroundColor,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'ToDay',
                    style: TextStyle(
                      fontSize: 24 - (8 * percentageCollapsed),
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    formattedDate,
                    style: TextStyle(
                      fontSize: 16 - (8 * percentageCollapsed),
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      elevation: 0,
      pinned: true,
    );
  }
}
