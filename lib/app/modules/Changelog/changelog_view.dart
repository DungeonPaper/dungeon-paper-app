import 'package:dungeon_paper/app/widgets/chips/advanced_chip.dart';
import 'package:dungeon_paper/i18n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:provider/provider.dart';

import 'changelog_controller.dart';

class ChangelogView extends StatelessWidget {
  const ChangelogView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(tr.changelog.title),
      ),
      body: Consumer<ChangelogController>(
        builder: (context, controller, child) {
          if (controller.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Align(
            alignment: Alignment.topCenter,
            child: SizedBox(
              width: 800,
              child: ListView.builder(
                itemCount: controller.entries.length,
                itemBuilder: (context, index) {
                  final isLatest = index == 0;
                  final entry = controller.entries[index];
                  final version = entry.version.toString();
                  final isCurrent = entry.version == controller.currentVersion;
                  final content = entry.content;

                  return ExpansionTile(
                    title: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      spacing: 8,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Text(version,
                              style: Theme.of(context).textTheme.titleLarge),
                        ),
                        if (isLatest)
                          AdvancedChip(
                            label: Text(tr.changelog.tags.latest),
                            backgroundColor: Colors.green,
                            visualDensity: VisualDensity.compact,
                            padding: EdgeInsets.zero,
                          ),
                        if (isCurrent)
                          AdvancedChip(
                            label: Text(tr.changelog.tags.current),
                            backgroundColor: Colors.blue,
                            visualDensity: VisualDensity.compact,
                            padding: EdgeInsets.zero,
                          ),
                      ],
                    ),
                    controlAffinity: ListTileControlAffinity.platform,
                    initiallyExpanded:
                        entry.version >= controller.currentVersion,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 32),
                        child: SizedBox(
                          width: 800,
                          child: MarkdownBody(data: content),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
