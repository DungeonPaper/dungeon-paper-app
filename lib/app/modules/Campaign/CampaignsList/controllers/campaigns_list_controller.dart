import 'dart:async';

import 'package:dungeon_paper/app/data/models/campaign.dart';
import 'package:dungeon_paper/core/storage_handler/storage_handler.dart';
import 'package:flutter/widgets.dart';

class CampaignsListController extends ChangeNotifier {
  StreamSubscription? _campaignsListenerSubscription;
  final _campaigns = <Campaign>[];
  var count = 0;

  List<Campaign> get campaigns => _campaigns.toList();

  CampaignsListController() {
    _campaignsListenerSubscription = StorageHandler.instance
        .collectionListener('Campaigns', _campaignsListener);
  }

  @override
  void dispose() {
    super.dispose();
    _campaignsListenerSubscription?.cancel();
  }

  void _campaignsListener(List<DocData> data) {
    _campaigns
      ..clear()
      ..addAll(
        data.map((e) => Campaign.fromJson(e)).toList(),
      );
    notifyListeners();
  }
}

