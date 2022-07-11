import 'package:dungeon_paper/app/data/models/meta.dart';
import 'package:dungeon_paper/app/data/services/repository_service.dart';
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

class _EntityShareFormState<T extends WithMeta> extends State<EntityShareForm>
    with RepositoryServiceMixin {
  T? source;

  @override
  void initState() {
    super.initState();
    // final storageKey = storageKeyFor(widget.entity);
    var sourceKey = widget.entity.meta.sharing?.sourceKey;
    getSourceObject(sourceKey);
  }

  void getSourceObject(String? sourceKey) {
    if (sourceKey == null) {
      setState(() {
        source = null;
      });
      return;
    }
    source = repo.my.listByType(widget.entity.runtimeType)[sourceKey];
    debugPrint('source: $source');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      // mainAxisSize: MainAxisSize.max,
      children: [
        const Text('Share'),
        Text(widget.entity.meta.toRawJson()),
        Text('is fork: ${widget.entity.meta.isFork}'),
        Text('is source: ${widget.entity.meta.isSource}'),
        if (source != null) ...[
          const Divider(),
          Text('is fork of source: ${widget.entity.meta.isForkOf(source!)}'),
          Text('is source: ${widget.entity.meta.isSourceOf(source!)}'),
          Text('is outOfSync with source: ${widget.entity.meta.isOutOfSyncWith(source!)}'),
        ],
        const Divider(),
        Text('current key: ${widget.entity.key}'),
        Text('current owner: ${widget.entity.meta.createdBy}'),
        Text('current version: ${widget.entity.meta.version}'),
        Text('source key: ${widget.entity.meta.sharing?.sourceKey}'),
        Text('source owner: ${widget.entity.meta.sharing?.sourceOwner}'),
        Text('source version: ${widget.entity.meta.sharing?.sourceVersion}'),
        Text('key is same: ${widget.entity.meta.sharing?.sourceKey == widget.entity.key}'),
        Text(
            'owner is same: ${widget.entity.meta.sharing?.sourceOwner == widget.entity.meta.createdBy}'),
        Text(
            'version is same: ${widget.entity.meta.sharing?.sourceVersion == widget.entity.meta.version}'),
        if (source != null)
          ElevatedButton(
            onPressed: () => widget.onChange(
              source!.copyWithInherited(
                meta: widget.entity.meta.copyWith(version: source!.meta.version),
              ) as T,
            ),
            child: const Text('Update'),
          ),
      ],
    );
  }
}
