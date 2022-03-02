import 'package:dungeon_paper/app/data/models/alignment.dart';
import 'package:dungeon_paper/app/data/models/bio.dart';
import 'package:dungeon_paper/app/data/models/bond.dart';
import 'package:dungeon_paper/app/data/models/meta.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class CharacterBackgroundController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final bioDesc = TextEditingController().obs;
  final raceName = TextEditingController().obs;
  final raceDesc = TextEditingController().obs;
  final _validCache = false.obs;
  bool get _isValid => formKey.currentState?.validate() ?? false;
  bool get isValid => _validCache.value;

  CharBackground get charBackground => CharBackground(
        bioDesc: bioDesc.value.text,
        raceName: raceName.value.text,
        raceDesc: raceDesc.value.text,
        bonds: [],
      );

  void setCharBackground(CharBackground info) {
    bioDesc.value.text = info.bioDesc;
    raceName.value.text = info.raceName;
    raceDesc.value.text = info.raceDesc;
    validate();
  }

  static bool isCharBackgroundValid(CharBackground info) => info.isValid;

  bool validate() {
    return _validCache.value = _isValid;
  }
}

class CharBackground {
  final String bioDesc;
  final String raceName;
  final String raceDesc;
  final List<Bond> bonds;

  CharBackground({
    required this.bioDesc,
    required this.raceName,
    required this.raceDesc,
    required this.bonds,
  });

  bool get isValid => raceDesc.isNotEmpty;

  Bio get bio => Bio(
        description: bioDesc,
        alignment: AlignmentValue(key: 'good', description: '', meta: Meta.version(1)),
        looks: [],
      );
}
