part of 'db.dart';

class FirebaseHelpers {
  Future<void> delete({
    @required DocumentReference ref,
  }) async {
    logger.d('Deleting $this');
    await ref.delete();
  }

  Future<DocumentReference> create({
    @required DocumentReference ref,
    @required Map<String, dynamic> json,
  }) async {
    await ref.set(json);
    return ref;
  }

  Future<void> update({
    @required DocumentReference ref,
    @required Map<String, dynamic> json,
  }) async {
    await ref.update(json);
  }

  Future<DocumentReference> move({
    @required DocumentReference ref,
    @required String newId,
    @required Map<String, dynamic> json,
    bool useSameParent = true,
  }) async {
    final _ref = useSameParent ? ref.parent.doc(newId) : firestore.doc(newId);
    logger.d('Creating new document: ${_ref.path}');
    await create(ref: _ref, json: json);
    logger.d('Success. Deleting ${ref.path}');
    await ref.delete();
    return _ref;
  }
}
