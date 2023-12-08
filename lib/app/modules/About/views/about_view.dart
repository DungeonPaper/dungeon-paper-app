import 'dart:math';

import 'package:dungeon_paper/app/routes/app_pages.dart';
import 'package:dungeon_paper/app/widgets/atoms/rainbow_text.dart';
import 'package:dungeon_paper/core/dw_icons.dart';
import 'package:dungeon_paper/core/utils/builder_utils.dart';
import 'package:dungeon_paper/i18n.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../model_utils/user_utils.dart';
import '../controllers/about_controller.dart';

class AboutView extends GetView<AboutController> {
  const AboutView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(tr.about.title),
        centerTitle: true,
      ),
      body: ItemBuilder.lazyListView(
        children: [
          () => Text(
                tr.app.name,
                textAlign: TextAlign.center,
                style: textTheme.headlineMedium,
              ),
          () => Obx(
                () => Text(
                  tr.about.version(controller.version.value?.toString() ?? '-'),
                  textAlign: TextAlign.center,
                  style: textTheme.bodySmall,
                ),
              ),
          () => const SizedBox(height: 16),
          () => Image.asset(
                'assets/images/logo.png',
                height: 150,
              ),
          () => const SizedBox(height: 16),
          () => Text(
                tr.about.copyright(DateTime.now().year),
                textAlign: TextAlign.center,
              ),
          () => Text(
                tr.about.author,
                textAlign: TextAlign.center,
              ),
          () => const Divider(height: 48),
          () => ListTile(
                leading: const Icon(DwIcons.discord),
                title: Text(tr.about.discord.title),
                subtitle:
                    Text(tr.about.discord.subtitle, style: textTheme.bodySmall),
                onTap: () =>
                    launchUrl(Uri.parse('https://bit.ly/DungeonPaper-Discord')),
                isThreeLine: true,
                visualDensity: VisualDensity.compact,
              ),
          () => ListTile(
                leading: const Icon(Icons.send),
                title: Text(tr.about.feedback.title),
                subtitle: Text(tr.about.feedback.subtitle,
                    style: textTheme.bodySmall),
                onTap: () => Get.toNamed(Routes.sendFeedback),
                isThreeLine: true,
                visualDensity: VisualDensity.compact,
              ),
          () => const Divider(),
          () => Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Text(tr.about.socials.title, style: textTheme.bodySmall),
              ),
          () => Padding(
                padding: const EdgeInsets.all(16.0).copyWith(top: 0),
                child: Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    _SocialButton(
                      icon: Icon(DwIcons.providerIcon(ProviderName.twitter)),
                      label: Text(tr.about.socials.twitter),
                      url: 'https://bit.ly/DungeonPaper-Twitter',
                      color: const Color.fromARGB(255, 28, 157, 236),
                    ),
                    _SocialButton(
                      icon: Icon(DwIcons.providerIcon(ProviderName.facebook)),
                      label: Text(tr.about.socials.facebook),
                      url: 'https://bit.ly/DungeonPaper-Facebook',
                      color: const Color.fromARGB(255, 22, 116, 236),
                    ),
                    _SocialButton(
                      icon: Icon(DwIcons.providerIcon(ProviderName.discord)),
                      label: Text(tr.about.socials.discord),
                      url: 'https://bit.ly/DungeonPaper-Discord',
                      color: const Color.fromARGB(255, 111, 133, 212),
                    ),
                    _SocialButton(
                      icon: Icon(DwIcons.providerIcon(ProviderName.github)),
                      label: Text(tr.about.socials.github),
                      url: 'https://bit.ly/DungeonPaper-GitHub',
                      color: const Color.fromARGB(255, 33, 32, 32),
                    ),
                    _SocialButton(
                      icon: Icon(DwIcons.providerIcon(ProviderName.google)),
                      label: Text(tr.about.socials.google),
                      url: 'https://bit.ly/DungeonPaper-Android',
                      color: const Color.fromARGB(255, 1, 135, 95),
                    ),
                    _SocialButton(
                      icon: Icon(DwIcons.providerIcon(ProviderName.apple)),
                      label: Text(tr.about.socials.apple),
                      url: 'https://bit.ly/DungeonPaper-iOS',
                      color: const Color.fromARGB(255, 30, 143, 232),
                    ),
                  ],
                ),
              ),
          () => const Divider(),
          () => ListTile(
                minLeadingWidth: 36,
                leading: const Icon(Icons.favorite),
                title: Text(tr.about.specialThanks),
                subtitle: RainbowText(
                  [
                    'dekelts',
                    'orrans',
                  ].join(', '),
                ),
              ),
          () => ListTile(
                minLeadingWidth: 36,
                leading: const Icon(Icons.people),
                title: const Text('Contributors'),
                subtitle: Text(
                  [
                    'eldritchart',
                    'arthurpaulino',
                  ].join(', '),
                ),
              ),
          () => ListTile(
                minLeadingWidth: 36,
                leading: const Icon(Icons.code),
                title: Text(tr.about.icons),
                subtitle: Text(iconCredits),
              ),
        ],
      ),
    );
  }
}

final iconCredits = ([
  'ibrandify',
  'Freepik',
  'FontAwesome',
  'Skoll',
  'Delapouite',
  'iconmonstr',
  'Icon8',
  'game-icons.net',
]..sort((a, b) => a.toLowerCase().compareTo(b.toLowerCase())))
    .join(', ');

class _SocialButton extends StatelessWidget {
  const _SocialButton({
    required this.icon,
    required this.label,
    required this.url,
    required this.color,
  });

  final Widget icon;
  final Widget label;
  final String url;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return ElevatedButton.icon(
      icon: icon,
      label: label,
      onPressed: () => launchUrl(Uri.parse(url)),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: Colors.white,
        minimumSize: Size(min(200, (mediaQuery.size.width - 40) / 2), 48),
      ),
    );
  }
}
