import 'package:dungeon_paper/src/flutter_utils/widget_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchBar extends StatelessWidget {
  final TextEditingController _controller;
  final FocusNode _focusNode;
  final void Function(String value) onChanged;
  final void Function(String value) onSubmitted;
  final void Function() onEditingComplete;
  final String hintText;

  TextEditingController get controller => _controller;

  SearchBar({
    Key key,
    TextEditingController controller,
    FocusNode focusNode,
    String value,
    this.onChanged,
    this.onSubmitted,
    this.onEditingComplete,
    this.hintText,
  })  : _controller = controller ?? TextEditingController(text: value),
        _focusNode = focusNode ?? FocusNode(),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      color: Get.theme.canvasColor,
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
                focusNode: _focusNode,
                decoration: InputDecoration(
                  hintText: hintText ?? 'Type to search',
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
                if (controller.text.isEmpty) {
                  _focusNode.requestFocus();
                } else {
                  loseAllFocus(context);
                }
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
    );
  }
}
