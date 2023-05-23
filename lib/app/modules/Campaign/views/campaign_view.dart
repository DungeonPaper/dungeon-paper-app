import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/campaign_controller.dart';

class CampaignView extends GetView<CampaignController> {
  const CampaignView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CampaignView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'CampaignView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
