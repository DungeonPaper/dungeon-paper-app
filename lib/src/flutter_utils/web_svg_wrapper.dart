import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:universal_html/html.dart' as html;
import './_stub_ui.dart' if (dart.library.html) '_real_ui.dart' as ui;

class WebSvgWrapper {
  static final Random _random = Random();
  static Future<String> _loadAsset(String uri) async =>
      rootBundle.loadString(uri);
  static network(
    String uri, {
    double width,
    double height,
    BoxFit fit = BoxFit.contain,
    Color color,
    alignment = Alignment.center,
    String semanticsLabel,
  }) {
    if (kIsWeb) {
      return Container(
        key: Key(uri),
        width: width,
        height: height,
        alignment: alignment,
        child: Image.network(
          '/assets/$uri',
          width: width,
          height: height,
          fit: fit,
          color: color,
          alignment: alignment,
          semanticLabel: semanticsLabel,
        ),
      );
    }
    return FutureBuilder(
      future: _loadAsset(uri),
      initialData: '',
      builder: (ctx, snapshot) {
        if (kIsWeb) {
          var hashCode = String.fromCharCodes(
            List<int>.generate(128, (i) => _random.nextInt(256)),
          );
          // ignore: undefined_prefixed_name
          ui.platformViewRegistry.registerViewFactory(
            'img-svg-$hashCode',
            (int viewId) {
              return html.DivElement()
                ..classes.add('svg-test')
                ..style.width = width.toString()
                ..style.height = height.toString()
                ..innerHtml = snapshot.data;
            },
          );
          return Container(
            width: width,
            height: width,
            alignment: Alignment.center,
            child: HtmlElementView(
              viewType: 'img-svg-$hashCode',
            ),
          );
        }
        return Container(
          width: width,
          height: width,
        );
      },
    );
  }
}
