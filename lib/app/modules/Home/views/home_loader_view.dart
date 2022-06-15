import 'package:dungeon_paper/app/data/services/loading_service.dart';
import 'package:dungeon_paper/generated/l10n.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

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
    return Center(
      child: Obx(
        () => Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(title),
            const SizedBox(
              width: 100,
              height: 100,
              child: Center(
                child: Padding(
                  padding: EdgeInsets.all(24),
                  child: CircularProgressIndicator.adaptive(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
