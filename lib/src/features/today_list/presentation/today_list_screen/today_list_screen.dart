import 'package:flutter/material.dart';
import 'package:today_list/src/features/today_list/data/fake_today_item_repository.dart';
import 'package:today_list/src/features/today_list/presentation/today_list_screen/custom_app_bar.dart';
import 'package:today_list/src/features/today_list/presentation/today_list_screen/today_card.dart';

import '../../domain/today_item.dart';

class TodayListScreen extends StatelessWidget {
  const TodayListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<TodayItem> incompleteList =
        FakeTodayItemRepository.instance.getIncompleteItems();
    final List<TodayItem> completedList =
        FakeTodayItemRepository.instance.getCompleteItems();

    return Scaffold(
        body: CustomScrollView(
          slivers: [
            CustomAppBar(),
            SliverList(
              delegate: SliverChildListDelegate([
                Padding(
                  padding: const EdgeInsets.only(left: 16, top: 16),
                  child: Text(
                    incompleteList.isNotEmpty ? 'Do' : 'Glorious...',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
              ]),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    if (index.isEven) {
                      return TodayCard(text: incompleteList[index ~/ 2].text);
                    }
                    return const Divider(height: 1, thickness: 1);
                  },
                  childCount: incompleteList.length * 2 - 1,
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate([
                Padding(
                  padding: const EdgeInsets.only(left: 16, top: 16),
                  child: Text(
                    completedList.isEmpty ? 'Let\'s get going' : 'Done',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
              ]),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    if (index.isEven) {
                      return TodayCard(
                          text: completedList[index ~/ 2].text,
                          completed: true);
                    }
                    return const Divider(height: 1, thickness: 1);
                  },
                  childCount: completedList.length * 2 - 1,
                ),
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            _showAddTodayItemDialog(context);
          },
          label: const Icon(Icons.add),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ));
  }
}

Future<void> _showAddTodayItemDialog(BuildContext context) async {
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
        padding: const EdgeInsets.all(16),
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
              height: 50,
              child: TextButton(
                onPressed: () {
                  // Handle button press logic
                },
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: const Text("Add ToDay"),
              ),
            ),
          ],
        ),
      );
    },
  );
}
