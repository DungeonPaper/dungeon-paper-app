import 'package:flutter/material.dart' show required;

class ProviderLinkData {
  final String id;
  final String displayName;
  final Future<bool> Function(ProviderLinkData) link;

  ProviderLinkData({
    @required this.id,
    @required this.displayName,
    @required this.link,
  });
}
