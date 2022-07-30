import 'package:dungeon_paper/app/routes/app_pages.dart';
import 'package:dungeon_paper/app/widgets/atoms/rainbow_text.dart';
import 'package:dungeon_paper/core/dw_icons.dart';
import 'package:dungeon_paper/core/utils/builder_utils.dart';
import 'package:dungeon_paper/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

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
      body: ItemBuilder.lazyListView(
        children: [
          () => Text(
                S.current.appName,
                textAlign: TextAlign.center,
                style: textTheme.headline4,
              ),
          () => Obx(
                () => Text(
                  S.current.aboutVersion(controller.version.value?.toString() ?? '-'),
                  textAlign: TextAlign.center,
                  style: textTheme.caption,
                ),
              ),
          () => const SizedBox(height: 16),
          () => Image.asset(
                'assets/images/logo.png',
                height: 150,
              ),
          () => const SizedBox(height: 16),
          () => Text(
                S.current.aboutCopyright(DateTime.now().year),
                textAlign: TextAlign.center,
              ),
          () => Text(
                S.current.aboutAuthor,
                textAlign: TextAlign.center,
              ),
          () => const Divider(height: 48),
          () => ListTile(
                leading: const Icon(DwIcons.discord),
                title: Text(S.current.aboutJoinDiscord),
                subtitle: Text(S.current.aboutJoinDiscordSubtitle, style: textTheme.caption),
                onTap: () => launch('https://bit.ly/DungeonPaper-Discord'),
                isThreeLine: true,
                visualDensity: VisualDensity.compact,
              ),
          () => ListTile(
                leading: const Icon(Icons.send),
                title: Text(S.current.aboutSendFeedback),
                subtitle: Text(S.current.aboutSendFeedbackSubtitle, style: textTheme.caption),
                onTap: () => Get.toNamed(Routes.sendFeedback),
                isThreeLine: true,
                visualDensity: VisualDensity.compact,
              ),
          () => const Divider(),
          () => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Text(S.current.aboutSocialLinks, style: textTheme.caption),
              ),
          () => Padding(
                padding: const EdgeInsets.all(16.0).copyWith(top: 0),
                child: Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    _SocialButton(
                      icon: const Icon(DwIcons.twitter),
                      label: Text(S.current.socialTwitter),
                      url: 'https://bit.ly/DungeonPaper-Twitter',
                      color: const Color.fromARGB(255, 28, 157, 236),
                    ),
                    _SocialButton(
                      icon: const Icon(DwIcons.facebook),
                      label: Text(S.current.socialFacebook),
                      url: 'https://bit.ly/DungeonPaper-Facebook',
                      color: const Color.fromARGB(255, 22, 116, 236),
                    ),
                    _SocialButton(
                      icon: const Icon(DwIcons.discord),
                      label: Text(S.current.socialDiscord),
                      url: 'https://bit.ly/DungeonPaper-Discord',
                      color: const Color.fromARGB(255, 111, 133, 212),
                    ),
                    _SocialButton(
                      icon: const Icon(DwIcons.github_circled),
                      label: Text(S.current.socialGitHub),
                      url: 'https://bit.ly/DungeonPaper-GitHub',
                      color: const Color.fromARGB(255, 33, 32, 32),
                    ),
                    _SocialButton(
                      icon: const Icon(DwIcons.google_play),
                      label: Text(S.current.socialGoogle),
                      url: 'https://bit.ly/DungeonPaper-Android',
                      color: const Color.fromARGB(255, 1, 135, 95),
                    ),
                    _SocialButton(
                      icon: const Icon(DwIcons.apple),
                      label: Text(S.current.socialApple),
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
                title: Text(S.current.aboutSpecialThanks),
                subtitle: RainbowText(
                  [
                    'dekelts',
                    'orrans',
                  ].join(', '),
                ),
              ),
          () => ListTile(
                minLeadingWidth: 36,
                leading: const SizedBox(width: 16),
                title: Text(S.current.aboutIconCredits),
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
    super.key,
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
    return ElevatedButton.icon(
      icon: icon,
      label: label,
      onPressed: () => launch(url),
      style: ElevatedButton.styleFrom(
        primary: color,
        minimumSize: const Size(200, 48),
      ),
    );
  }
}
