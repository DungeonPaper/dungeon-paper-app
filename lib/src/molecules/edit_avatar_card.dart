import 'package:flutter/material.dart';

class EditAvatarCard extends StatefulWidget {
  final TextEditingController controller;
  final Function() onSave;

  const EditAvatarCard({
    Key key,
    @required this.controller,
    this.onSave,
  }) : super(key: key);

  @override
  _EditAvatarCardState createState() => _EditAvatarCardState();
}

class _EditAvatarCardState extends State<EditAvatarCard> {
  bool imageError = false;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).canvasColor,
      elevation: 1.0,
      type: MaterialType.card,
      borderRadius: BorderRadius.circular(5.0),
      child: Column(
        children: <Widget>[
          avatar(),
          Padding(
            padding: const EdgeInsets.all(8.0).copyWith(top: 0.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: widget.controller,
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.url,
                    enableInteractiveSelection: true,
                    decoration: InputDecoration(
                      hintText: 'We recommend uploading to imgur.com',
                      labelText: 'Avatar Image URL',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget avatar() {
    // var image = NetworkImageWithRetry(widget.controller.text,
    //     fetchStrategy: (uri, failure) async {
    //       logger.d('ahem');
    //   if (failure != null) {
    //     await Future.delayed(Duration(microseconds: 1));
    //     setState(() {
    //       imageError = true;
    //     });
    //     return FetchInstructions.giveUp(uri: uri);
    //   } else {
    //     setState(() {
    //       imageError = false;
    //     });
    //     return NetworkImageWithRetry.defaultFetchStrategy(uri, failure);
    //   }
    // });
    var image = NetworkImage(widget.controller.text);
    var container = AspectRatio(
      aspectRatio: 14.0 / 9.0,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(5.0)),
          image: DecorationImage(
            fit: BoxFit.fitWidth,
            alignment: FractionalOffset.topCenter,
            image: image,
          ),
        ),
      ),
    );
    var placeholder = Container(
      child: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Text(!imageError
            ? 'Add an image URL in the field below.'
            : "We couldn't load your image,\nPlease check the URL and try again."),
      ),
    );
    return widget.controller.text.isEmpty || imageError == true
        ? placeholder
        : container;
  }
}
