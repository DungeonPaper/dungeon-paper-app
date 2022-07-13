import 'package:get/get.dart';

enum LoadKey {
  user,
  characters,
  repo,
  library,
  afterFirstLoad,
}

class LoadingService extends GetxService {
  final _map = <LoadKey, bool>{
    LoadKey.user: true,
    LoadKey.characters: false,
    LoadKey.repo: true,
    LoadKey.library: true,
    LoadKey.afterFirstLoad: false,
  }.obs;

  bool get loadingUser => _map[LoadKey.user] == true;
  set loadingUser(bool value) => _map[LoadKey.user] = value;

  bool get loadingCharacters => _map[LoadKey.characters] == true;
  set loadingCharacters(bool value) => _map[LoadKey.characters] = value;

  bool get loadingRepo => _map[LoadKey.repo] == true;
  set loadingRepo(bool value) => _map[LoadKey.repo] = value;

  bool get loadingLibrary => _map[LoadKey.library] == true;
  set loadingLibrary(bool value) => _map[LoadKey.library] = value;

  bool get afterFirstLoad => _map[LoadKey.afterFirstLoad] == true;
  set afterFirstLoad(bool value) => _map[LoadKey.afterFirstLoad] = value;
}

mixin LoadingServiceMixin {
  LoadingService get loadingService => Get.find();
}
