import 'package:dungeon_paper/core/global_keys.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

enum LoadKey {
  user,
  characters,
  repo,
  library,
  afterFirstLoad,
}

class LoadingProvider extends ChangeNotifier {
  static LoadingProvider of(BuildContext context, {bool listen = false}) =>
      Provider.of<LoadingProvider>(context, listen: listen);

  static Widget consumer(
          Widget Function(BuildContext, LoadingProvider, Widget?) builder) =>
      Consumer<LoadingProvider>(builder: builder);
  final _map = <LoadKey, bool>{
    LoadKey.user: true,
    LoadKey.characters: false,
    LoadKey.repo: true,
    LoadKey.library: true,
    LoadKey.afterFirstLoad: false,
  };

  bool get loadingUser => _map[LoadKey.user] == true;
  set loadingUser(bool value) {
    _map[LoadKey.user] = value;
    notifyListeners();
  }

  bool get loadingCharacters => _map[LoadKey.characters] == true;
  set loadingCharacters(bool value) {
    _map[LoadKey.characters] = value;
    notifyListeners();
  }

  bool get loadingRepo => _map[LoadKey.repo] == true;
  set loadingRepo(bool value) {
    _map[LoadKey.repo] = value;
    notifyListeners();
  }

  bool get loadingLibrary => _map[LoadKey.library] == true;
  set loadingLibrary(bool value) {
    _map[LoadKey.library] = value;
    notifyListeners();
  }

  bool get afterFirstLoad => _map[LoadKey.afterFirstLoad] == true;
  set afterFirstLoad(bool value) {
    _map[LoadKey.afterFirstLoad] = value;
    notifyListeners();
  }
}

mixin LoadingProviderMixin {
  LoadingProvider get loadingProvider =>
      LoadingProvider.of(appGlobalKey.currentContext!);
}
