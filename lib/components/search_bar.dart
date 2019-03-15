import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  final TextEditingController _controller;
  final void Function(String value) onChanged;

  TextEditingController get controller => _controller;

  SearchBar({
    Key key,
    TextEditingController controller,
    String value,
    this.onChanged,
  })  : _controller = controller ?? TextEditingController(text: value),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: TextField(
            controller: _controller,
            autocorrect: false,
            keyboardType: TextInputType.text,
            onChanged: onChanged,
          ),
        ),
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () {},
        ),
      ],
    );
  }
}
