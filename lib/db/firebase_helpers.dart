part of 'db.dart';

class FirebaseHelpers {
  const FirebaseHelpers();

  Future<DocumentReference> create(
      DocumentReference ref, Map<String, dynamic> data) async {
    logger.d('Creating: ${ref.path}\n$data');
    await ref.set(data);
    return ref;
  }

  Future<DocumentReference> update(
    DocumentReference ref,
    Map<String, dynamic> data, {
    Iterable<String> keys,
  }) async {
    data = pick(data, keys);
    logger.d('Updating: ${ref.path}\n$data');
    await ref.update(data);
    return ref;
  }

  Future<DocumentReference> move(
    DocumentReference ref,
    String newId, {
    Map<String, dynamic> update,
    bool useSameParent = true,
  }) async {
    logger.d(
      'Moving: ${ref.path}\n'
      'to: $newId, '
      'update: $update, '
      'useSameParent: $useSameParent',
    );
    final json = {
      ...(await ref.get()).data(),
      ...(update ?? {}),
    };
    final _ref = useSameParent ? ref.parent.doc(newId) : firestore.doc(newId);
    logger.d('Creating new document: ${_ref.path}');
    await create(_ref, json);
    logger.d('Success. Deleting ${ref.path}');
    await ref.delete();
    return _ref;
  }

  Future<void> delete(DocumentReference ref) async {
    logger.d('Deleting $this');
    return ref.delete();
  }
}

mixin FirebaseMixin {
  static const helpers = FirebaseHelpers();

  DocumentReference get ref;
  Map<String, dynamic> toJson();

  String get documentID => ref.id;

  Future<DocumentReference> create({Iterable<String> keys}) =>
      helpers.create(ref, toJson());

  Future<DocumentReference> update({Iterable<String> keys}) =>
      helpers.update(ref, toJson(), keys: keys);

  Future<DocumentReference> move(
    String newId, {
    Map<String, dynamic> update,
    bool useSameParent = true,
  }) =>
      helpers.move(
        ref,
        newId,
        update: update,
        useSameParent: useSameParent,
      );

  Future<void> delete() => helpers.delete(ref);

  Future<Iterable<T>> getRefs<T>(
          Iterable<DocumentReference> list, T Function(dynamic) map) =>
      Future.wait(
        list.map((r) => r.get()),
      ).then((chars) => chars.map(map));
}

mixin KeyMixin {
  String get key;
}
