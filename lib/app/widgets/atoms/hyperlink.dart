import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Hyperlink extends StatelessWidget {
  final void Function() onTap;
  final String text;

  const Hyperlink(this.text, this.onTap, {super.key});

  Hyperlink.url(this.text, String url, {super.key}) : onTap = _urlTapper(url);

  static TextSpan textSpan(BuildContext context, String text,
      {void Function()? onTap, String? url}) {
    assert(
        onTap != null || url != null, 'Either onTap or url must be provided');
    onTap ??= _urlTapper(url!);

    return TextSpan(
      text: text,
      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            color: Colors.blue[700],
            decoration: TextDecoration.underline,
          ),
      recognizer: TapGestureRecognizer()..onTap = onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: Colors.blue[700],
              decoration: TextDecoration.underline,
            ),
      ),
    );
  }

  static _urlTapper(String url) {
    return () => launchUrl(Uri.parse(url));
  }
}
