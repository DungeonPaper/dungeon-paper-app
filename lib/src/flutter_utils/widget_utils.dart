import 'package:flutter/material.dart';

const BOTTOM_SPACER = SizedBox(height: 64);

typedef SingleChildWidgetBuilder = Widget Function(
    BuildContext context, Widget child);

class PageLoader extends StatelessWidget {
  final Color color;
  final Color backgroundColor;
  final Size size;
  final double strokeWidth;

  const PageLoader({
    Key key,
    this.color,
    this.backgroundColor,
    this.strokeWidth,
    this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var loader = CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation<Color>(
        color ?? Theme.of(context).colorScheme.surface,
      ),
      backgroundColor: backgroundColor,
      strokeWidth: strokeWidth ?? 4.0,
    );
    if (size != null) {
      return Container(
        width: size.width,
        height: size.height,
        child: loader,
      );
    }
    return loader;
  }
}

class AddButton extends StatelessWidget {
  final Function() onPressed;
  final double textScaleFactor;
  final Color backgroundColor;
  final Color foregroundColor;

  const AddButton({
    Key key,
    @required this.onPressed,
    this.size = 50,
    this.textScaleFactor = 1.5,
    this.backgroundColor,
    this.foregroundColor,
  }) : super(key: key);

  final double size;

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      minWidth: size,
      height: size,
      child: RaisedButton(
        color: backgroundColor ?? Theme.of(context).primaryColor,
        textColor: foregroundColor ?? Theme.of(context).colorScheme.surface,
        child: Text(
          '+',
          textScaleFactor: textScaleFactor,
        ),
        onPressed: onPressed,
      ),
    );
  }
}

class EditingControllerConfig {
  dynamic key;
  String defaultValue;
  VoidCallback listener;

  EditingControllerConfig({
    this.key,
    @required this.defaultValue,
    this.listener,
  });

  TextEditingController toEditingController() {
    var controller = TextEditingController(text: defaultValue);
    if (listener != null) {
      controller.addListener(listener);
    }
    return controller;
  }
}

class WidgetUtils {
  static Map<T, TextEditingController> textEditingControllerMap<T>({
    Map<T, dynamic> map,
    List list,
  }) {
    final output = <T, TextEditingController>{};
    var idx = 0;
    final iter = map ??
        Map.fromIterable(
          list,
          key: (i) => (i is EditingControllerConfig ? i.key : i) ?? idx++,
        );
    iter.forEach((key, value) {
      var config = _parseConfig(key, value);
      output[config.key] = config.toEditingController();
    });
    return output;
  }

  static EditingControllerConfig _parseConfig<T>(T key, dynamic value) {
    EditingControllerConfig config;
    if (value is String) {
      config = EditingControllerConfig(key: key, defaultValue: value);
    } else if (value is! EditingControllerConfig) {
      throw FormatException('value must be of valid type');
    } else {
      config = value;
    }
    config.key ??= key;
    return config;
  }
}
