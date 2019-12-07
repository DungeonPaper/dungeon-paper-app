import 'package:flutter/material.dart';

const BOTTOM_SPACER = SizedBox(height: 64);

typedef Widget SingleChildWidgetBuilder(BuildContext context, Widget child);

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
    CircularProgressIndicator loader = CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation<Color>(
          color ?? Theme.of(context).primaryColor),
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

  const AddButton({
    Key key,
    @required this.onPressed,
    this.size = 50,
    this.textScaleFactor = 1.5,
  }) : super(key: key);

  final double size;

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      minWidth: size,
      height: size,
      child: RaisedButton(
        color: Theme.of(context).primaryColor,
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
    TextEditingController controller =
        TextEditingController(text: defaultValue);
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
    final Map<T, TextEditingController> output = {};
    int idx = 0;
    final Map<T, dynamic> iter = map != null
        ? map
        : Map.fromIterable(
            list,
            key: (i) => (i is EditingControllerConfig ? i.key : i) ?? idx++,
          );
    iter.forEach((key, value) {
      EditingControllerConfig config = _parseConfig(key, value);
      output[config.key] = config.toEditingController();
    });
    return output;
  }

  static EditingControllerConfig _parseConfig<T>(T key, dynamic value) {
    EditingControllerConfig config;
    if (value is String) {
      config = EditingControllerConfig(key: key, defaultValue: value);
    } else if (value is! EditingControllerConfig) {
      throw new FormatException("value must be of valid type");
    } else {
      config = value;
    }
    config.key ??= key;
    return config;
  }
}
