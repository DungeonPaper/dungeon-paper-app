import 'package:dungeon_paper/app/data/models/meta.dart';
import 'package:dungeon_paper/app/data/services/repository_service.dart';
import 'package:dungeon_paper/app/data/services/user_service.dart';
import 'package:dungeon_paper/generated/l10n.dart';
import 'package:flutter/material.dart';

class EntityShareForm<T extends WithMeta> extends StatefulWidget {
  const EntityShareForm({
    super.key,
    required this.entity,
    required this.onChange,
  });
  final T entity;
  final void Function(T updated) onChange;

  @override
  State<EntityShareForm> createState() => _EntityShareFormState();
}

enum SyncStatus {
  inSync,
  outOfSync,
  detached,
}

class _EntityShareFormState<T extends WithMeta> extends State<EntityShareForm>
    with RepositoryServiceMixin, UserServiceMixin {
  T? source;

  IconData? get syncStatusIcon => {
        SyncStatus.inSync: Icons.check,
        SyncStatus.outOfSync: Icons.error,
        SyncStatus.detached: Icons.info,
      }[syncStatus];

  String get syncStatusText => {
        SyncStatus.inSync:
            S.current.entityShareStatusInSync(S.current.entity(widget.entity.runtimeType)),
        SyncStatus.outOfSync:
            S.current.entityShareStatusOutOfSync(S.current.entity(widget.entity.runtimeType)),
        SyncStatus.detached:
            S.current.entityShareStatusDetached(S.current.entity(widget.entity.runtimeType)),
      }[syncStatus]!;

  Color? syncStatusColor(BuildContext context) => {
        SyncStatus.inSync: Colors.green,
        SyncStatus.outOfSync: Colors.red,
        SyncStatus.detached: null,
      }[syncStatus];

  SyncStatus get syncStatus {
    if (source == null || !widget.entity.meta.isForkOf(source!)) {
      return SyncStatus.detached;
    }
    if (!widget.entity.meta.isOutOfSyncWith(source!)) {
      return SyncStatus.inSync;
    }
    return SyncStatus.outOfSync;
  }

  @override
  void initState() {
    super.initState();
    final sourceKey = widget.entity.meta.sharing?.sourceKey;
    getSourceObject(sourceKey);
  }

  void getSourceObject(String? sourceKey) {
    if (sourceKey == null) {
      setState(() {
        source = null;
      });
      return;
    }
    source = repo.my.listByType(widget.entity.runtimeType)[sourceKey] ??
        repo.builtIn.listByType(widget.entity.runtimeType)[sourceKey];
    debugPrint('source: $source');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Text(source?.meta.toRawJson() ?? 'no source'),
        // const Divider(),
        // Text(widget.entity.meta.toRawJson()),
        // const Divider(),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            Icon(syncStatusIcon, color: syncStatusColor(context), size: 16),
            Text(
              syncStatusText,
              style: TextStyle(color: syncStatusColor(context)),
              textScaleFactor: 0.9,
            ),
            if (syncStatus == SyncStatus.outOfSync) ...[
              ElevatedButton.icon(
                onPressed: _updateOriginal,
                icon: const Icon(Icons.upload),
                // TODO intl
                label: const Text('Update Original'),
              ),
              ElevatedButton.icon(
                onPressed: _revertChanges,
                icon: const Icon(Icons.refresh),
                // TODO intl
                label: const Text('Revert'),
              ),
            ],
          ],
        ),
      ],
    );
  }

  void _updateOriginal() {}

  void _revertChanges() {
    widget.onChange(Meta.forkMeta(source!, user));
  }
}
