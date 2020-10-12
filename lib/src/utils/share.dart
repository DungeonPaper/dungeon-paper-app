import 'package:dungeon_paper/src/utils/utils.dart';
import 'package:pedantic/pedantic.dart';
import 'package:share/share.dart';

void shareAppLink() async {
  final secrets = await loadSecrets();
  unawaited(Share.share(
    "Check out Dungeon Paper, it's a character sheet app for Dungeon World, no need for pen & paper anymore!\n\n"
    '${secrets.ANDROID_APP_URL}',
  ));
}
