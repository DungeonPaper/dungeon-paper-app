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
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Material(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        color: Theme.of(context).canvasColor,
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: Row(
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
                  decoration: InputDecoration(
                    hintText: 'Type an item name',
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    filled: false,
                  ),
                ),
              ),
              IconButton(
                icon: controller.text.isEmpty
                    ? Icon(Icons.search)
                    : Icon(Icons.clear),
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
          ),
        ),
      ),
    );
  }
}
