import 'package:dungeon_paper/db/db.dart';
import 'package:dungeon_paper/db/models/converters/flutter_alignment_converter.dart';
import 'package:dungeon_paper/src/utils/utils.dart';
import 'package:flutter/painting.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'character_settings.g.dart';
part 'character_settings.freezed.dart';

@freezed
abstract class CharacterSettings
    with KeyMixin, FirebaseMixin
    implements _$CharacterSettings {
  const CharacterSettings._();

  const factory CharacterSettings({
    @Default(true) bool useDefaultMaxHp,
    @FlutterAlignmentConverter() Alignment rawPhotoAlignment,
  }) = _CharacterSettings;

  Alignment get photoAlignment => rawPhotoAlignment ?? Alignment.topCenter;

  factory CharacterSettings.fromJson(json) => _$CharacterSettingsFromJson(json);
}
