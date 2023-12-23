import 'package:dungeon_paper/app/widgets/chips/advanced_chip.dart';
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
        title: Text('Changelog'),
      ),
      body: Consumer<ChangelogController>(
        builder: (context, controller, child) {
          if (controller.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
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
                      const AdvancedChip(
                        label: Text('Latest'),
                        backgroundColor: Colors.green,
                        visualDensity: VisualDensity.compact,
                        padding: EdgeInsets.zero,
                      ),
                    if (isCurrent)
                      const AdvancedChip(
                        label: Text('Current'),
                        backgroundColor: Colors.blue,
                        visualDensity: VisualDensity.compact,
                        padding: EdgeInsets.zero,
                      ),
                  ],
                ),
                controlAffinity: ListTileControlAffinity.platform,
                initiallyExpanded: entry.version >= controller.currentVersion,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: 600,
                      child: MarkdownBody(data: content),
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}

