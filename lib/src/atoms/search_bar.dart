import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  final TextEditingController _controller;
  final void Function(String value) onChanged;
  final void Function(String value) onSubmitted;
  final void Function() onEditingComplete;

  TextEditingController get controller => _controller;

  SearchBar({
    Key key,
    @required TextEditingController controller,
    String value,
    this.onChanged,
    this.onSubmitted,
    this.onEditingComplete,
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
            textInputAction: TextInputAction.search,
            onEditingComplete: onEditingComplete,
            onSubmitted: onSubmitted,
            onChanged: onChanged,
            decoration: InputDecoration(hintText: 'Type an item name'),
          ),
        ),
        IconButton(
          icon:
              controller.text.isEmpty ? Icon(Icons.search) : Icon(Icons.clear),
          onPressed: () {
            controller.text = '';
            if (onChanged != null) {
              onChanged('');
            } else if (onSubmitted != null) {
              onSubmitted('');
            }
          },
        ),
      ],
    );
  }
}
