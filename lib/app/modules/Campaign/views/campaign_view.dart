import 'package:flutter/material.dart';

class CampaignView extends StatelessWidget {
  const CampaignView({super.key});
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

