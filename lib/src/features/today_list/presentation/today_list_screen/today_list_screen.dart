import 'package:flutter/material.dart';
import 'package:today_list/src/features/today_list/data/fake_today_item_repository.dart';
import 'package:today_list/src/features/today_list/presentation/today_list_screen/add_today_item_dialog.dart';
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
                    incompleteList.isNotEmpty
                        ? 'Do'
                        : 'Absolutely wonderful...',
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
            showAddTodayItemDialog(context);
          },
          label: const Icon(Icons.add),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ));
  }
}
