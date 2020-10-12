import 'package:flutter/material.dart';
import 'package:flutter_image/network.dart';

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
    return Card(
      margin: EdgeInsets.zero,
      child: Column(
        children: <Widget>[
          avatar(),
          Padding(
            padding: const EdgeInsets.all(16),
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
                      floatingLabelBehavior: FloatingLabelBehavior.always,
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
    final isUrl = Uri.parse(widget.controller.text).scheme.startsWith('http');
    var container = AspectRatio(
      aspectRatio: 14.0 / 9.0,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
          image: isUrl
              ? DecorationImage(
                  fit: BoxFit.fitWidth,
                  alignment: FractionalOffset.topCenter,
                  image: NetworkImageWithRetry(
                    widget.controller.text,
                    fetchStrategy: (uri, err) async {
                      try {
                        if (err == null || !uri.scheme.startsWith('http')) {
                          return NetworkImageWithRetry.defaultFetchStrategy(
                            uri,
                            err,
                          );
                        } else {
                          setState(() {
                            imageError = true;
                          });
                          return FetchInstructions.giveUp(uri: uri);
                        }
                      } catch (e) {
                        setState(() {
                          imageError = true;
                        });
                        return FetchInstructions.giveUp(uri: uri);
                      }
                    },
                  ),
                )
              : null,
        ),
      ),
    );
    var placeholder = Container(
      child: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Text(
          imageError
              ? "We couldn't load your image,\nPlease check the URL and try again."
              : !isUrl
                  ? "Try adding a valid URL.\nThis doesn't seem like one!"
                  : 'Add an image URL in the field below.',
          textAlign: TextAlign.center,
        ),
      ),
    );
    return widget.controller.text.isEmpty || imageError == true || !isUrl
        ? placeholder
        : container;
  }
}
