import 'package:dungeon_paper/db/models/campaign.dart';
import 'package:get/get.dart';

class CampaignsStore extends GetxController {
  Map<String, Campaign> campaigns;

  CampaignsStore({
    this.campaigns,
  });
}
