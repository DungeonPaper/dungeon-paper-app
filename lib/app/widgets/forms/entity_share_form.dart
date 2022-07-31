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
      children: [
        // Text(source?.meta.toRawJson() ?? 'no source'),
        // const Divider(),
        // Text(widget.entity.meta.toRawJson()),
        // const Divider(),
        Row(
          children: [
            Icon(syncStatusIcon, color: syncStatusColor(context), size: 16),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                syncStatusText,
                style: TextStyle(color: syncStatusColor(context)),
                textScaleFactor: 0.9,
              ),
            ),
            if (syncStatus == SyncStatus.outOfSync) ...[
              ElevatedButton.icon(
                onPressed: _updateOriginal,
                icon: Icon(Icons.upload),
                label: Text('Update Original'),
              ),
              const SizedBox(width: 8),
              ElevatedButton.icon(
                onPressed: _revertChanges,
                icon: Icon(Icons.refresh),
                label: Text('Revert'),
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
