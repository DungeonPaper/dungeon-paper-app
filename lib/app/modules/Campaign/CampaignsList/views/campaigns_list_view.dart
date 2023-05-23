import 'package:dungeon_paper/app/data/models/campaign.dart';
import 'package:dungeon_paper/generated/l10n.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/campaigns_list_controller.dart';

class CampaignsListView extends GetView<CampaignsListController> {
  const CampaignsListView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.current.myGeneric(S.current.entityPlural(Campaign))),
        centerTitle: true,
      ),
      body: Obx(
        () => controller.campaigns.isEmpty
            ? Center(
                child: Text(S.current.noGeneric(S.current.entityPlural(Campaign))),
              )
            : ListView.builder(
                itemCount: controller.campaigns.length,
                itemBuilder: (context, index) {
                  final campaign = controller.campaigns[index];
                  return ListTile(
                    title: Text(campaign.name),
                    subtitle: Text(campaign.description),
                    // onTap: () => controller.openCampaign(campaign),
                    // ignore: avoid_returning_null_for_void
                    onTap: () => null,
                  );
                },
              ),
      ),
    );
  }
}
