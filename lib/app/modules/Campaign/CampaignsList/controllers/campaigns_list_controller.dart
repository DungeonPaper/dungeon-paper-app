import 'dart:async';

import 'package:dungeon_paper/app/data/models/campaign.dart';
import 'package:dungeon_paper/core/storage_handler/storage_handler.dart';
import 'package:get/get.dart';

class CampaignsListController extends GetxController {
  StreamSubscription? _campaignsListenerSubscription;
  final _campaigns = <Campaign>[].obs;

  List<Campaign> get campaigns => _campaigns.toList();

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    _campaignsListenerSubscription = StorageHandler.instance.collectionListener('Campaigns', _campaignsListener);
  }

  @override
  void onClose() {
    _campaignsListenerSubscription?.cancel();
    super.onClose();
  }

  void _campaignsListener(List<DocData> data) {
    _campaigns.value = data.map((e) => Campaign.fromJson(e)).toList();
  }
}
