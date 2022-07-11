import 'package:dungeon_paper/app/data/services/loading_service.dart';
import 'package:dungeon_paper/app/modules/Home/views/local_widgets/home_character_header_view.dart';
import 'package:dungeon_paper/app/widgets/atoms/character_avatar.dart';
import 'package:dungeon_paper/core/utils/math_utils.dart';
import 'package:dungeon_paper/generated/l10n.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:skeleton_loader/skeleton_loader.dart';

class HomeLoaderView extends GetView with LoadingServiceMixin {
  const HomeLoaderView({Key? key}) : super(key: key);

  String get title {
    if (loadingService.loadingUser) {
      return S.current.loadingUser;
    }

    if (loadingService.loadingCharacters) {
      return S.current.loadingCharacters;
    }

    return S.current.loadingGeneral;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final brightness = theme.brightness;
    final skeletonColor = brightness == Brightness.light
        ? theme.cardColor.withOpacity(0.65)
        : colorScheme.surfaceVariant;
    final skeletonHighlightColor = brightness == Brightness.light
        ? Color.alphaBlend(
            theme.cardColor.withOpacity(0.65), colorScheme.surfaceTint.withOpacity(0.5))
        : Color.alphaBlend(theme.cardColor.withOpacity(0.65), colorScheme.surfaceTint);

    return SingleChildScrollView(
      child: SkeletonLoader(
        baseColor: skeletonColor,
        highlightColor: skeletonHighlightColor,
        builder: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: CharacterAvatar.squircle(
                size: HomeCharacterHeaderView.avatarSize,
              ),
            ),
            const SizedBox(height: 8),
            Center(
              child: Container(
                height: 26,
                width: 200,
                decoration: BoxDecoration(
                  color: skeletonColor,
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
            ),
            const SizedBox(height: 2),
            Center(
              child: Container(
                height: 24,
                width: 320,
                decoration: BoxDecoration(
                  color: skeletonColor,
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
            ),
            // const SizedBox(height: 2),
            Builder(
              builder: (context) {
                const size = 36.0;

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      for (final _ in range(5))
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6),
                          child: Container(
                            height: size,
                            width: size,
                            decoration: BoxDecoration(
                              color: skeletonColor,
                              borderRadius: BorderRadius.circular(size / 2),
                            ),
                          ),
                        ),
                    ],
                  ),
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: 500,
                height: 32,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  // crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        child: Container(
                          // height: 48,
                          decoration: BoxDecoration(
                            color: skeletonColor,
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        child: Container(
                          // height: 48,
                          decoration: BoxDecoration(
                            color: skeletonColor,
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 2),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (final _ in range(2))
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    child: Container(
                      height: 32,
                      width: 60,
                      decoration: BoxDecoration(
                        color: skeletonColor,
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 12),
            for (final _ in range(2))
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (final _ in range(3))
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 2).copyWith(bottom: 4),
                      child: Container(
                        height: 56,
                        width: 118,
                        decoration: BoxDecoration(
                          color: skeletonColor,
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                    ),
                ],
              ),
            const SizedBox(height: 14),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (final _ in range(2))
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Container(
                      height: 48,
                      width: 180,
                      decoration: BoxDecoration(
                        color: skeletonColor,
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                  ),
              ],
            ),
            for (final _ in range(4)) ...[
              Padding(
                padding: const EdgeInsets.only(left: 16, bottom: 4, top: 12),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    height: 16,
                    width: 100,
                    decoration: BoxDecoration(
                      color: skeletonColor,
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0).copyWith(top: 6),
                child: SizedBox(
                  height: 151,
                  child: ListView(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      for (final _ in range(2))
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: Container(
                            width: 210,
                            decoration: BoxDecoration(
                              color: skeletonColor,
                              borderRadius: BorderRadius.circular(24),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
