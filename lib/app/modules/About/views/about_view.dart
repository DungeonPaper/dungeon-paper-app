import 'package:dungeon_paper/generated/l10n.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/about_controller.dart';

class AboutView extends GetView<AboutController> {
  const AboutView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(S.current.about),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Text(
            S.current.appName,
            textAlign: TextAlign.center,
            style: textTheme.headline4,
          ),
          Obx(
            () => Text(
              S.current.aboutVersion(controller.version.value?.toString() ?? '-'),
              textAlign: TextAlign.center,
              style: textTheme.caption,
            ),
          ),
          const SizedBox(height: 16),
          Image.asset(
            'assets/images/logo.png',
            height: 150,
          ),
          const SizedBox(height: 16),
          Text(
            S.current.aboutCopyright(DateTime.now().year),
            textAlign: TextAlign.center,
          ),
          Text(
            S.current.aboutAuthor,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
