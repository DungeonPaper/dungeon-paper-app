import 'package:dungeon_paper/core/utils/content_generators/content_generator.dart';

class CharacterNameGenerator extends ContentGenerator {
  @override
  final mapping = <String, Map<String, Iterable<Iterable<String>>>>{
    'en': {
      'first': [firstNamesP1, firstNamesP2],
      'last': [firstNamesP1, firstNamesP2],
    },
  };
}

const firstNamesP1 = {
  'bar',
  'che',
  'coo',
  'da',
  'dan',
  'du',
  'dur',
  'gal',
  'gar',
  'garle',
  'ho',
  'jo',
  'ka',
  'kor',
  'lau',
  'lo',
  'ma',
  'mac',
  'man',
  'me',
  'pok',
  'por',
  'rom',
  'ror',
  'rot',
  'tru',
  'yan',
  'yo',
};
const firstNamesP2 = {
  'are',
  'bar',
  'ber',
  'car',
  'das',
  'den',
  'ey',
  'eyo',
  'hald',
  'ko',
  'kre',
  'man',
  'mon',
  'na',
  'name',
  'nar',
  'rag',
  'rie',
  'yar',
  'zane',
  'zar',
};
