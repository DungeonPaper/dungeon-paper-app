import 'package:dungeon_paper/app/data/services/repository_service.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class AddRepositoryItemsView<T> extends GetView<RepositoryService> {
  AddRepositoryItemsView({
    Key? key,
    required this.title,
    required this.cardBuilder,
    required this.onAdd,
  }) : super(key: key);

  final Widget title;
  final Widget Function(BuildContext context, T item) cardBuilder;
  final void Function(List<T> items) onAdd;
  final pageStorageBucket = PageStorageBucket();

  List<T> get list => controller.listByType<T>().values.toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: title,
        centerTitle: true,
      ),
      body: PageStorage(
        bucket: pageStorageBucket,
        child: ListView(
            padding: const EdgeInsets.all(8).copyWith(top: 0),
            children: list
                .map((x) => Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: cardBuilder(context, x),
                    ))
                .toList()),
      ),
    );
  }
}
