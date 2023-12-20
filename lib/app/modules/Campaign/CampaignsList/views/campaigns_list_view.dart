import 'package:dungeon_paper/app/data/models/campaign.dart';
import 'package:dungeon_paper/i18n.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controllers/campaigns_list_controller.dart';

class CampaignsListView extends StatelessWidget {
  const CampaignsListView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(tr.generic.myEntity(tr.entityPlural(tn(Campaign)))),
        centerTitle: true,
      ),
      body: Consumer<CampaignsListController>(
        builder: (context, controller, _) => controller.campaigns.isEmpty
            ? Center(
                child: Text(tr.generic.noEntity(tr.entityPlural(tn(Campaign)))),
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
