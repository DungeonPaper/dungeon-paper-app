import 'package:dungeon_paper/db/models/character.dart';
import 'package:dungeon_paper/src/dialogs/position_alignment_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image/network.dart';
import 'package:get/get.dart';

class EditAvatarCard extends StatefulWidget {
  final Character character;
  final TextEditingController controller;
  final Function() onSave;

  const EditAvatarCard({
    Key key,
    @required this.controller,
    @required this.character,
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
          Stack(
            children: [
              avatar,
              Positioned(
                top: 8,
                right: 8,
                child: ClipOval(
                  child: Container(
                    color: Colors.white,
                    child: IconButton(
                      icon: Icon(Icons.fullscreen),
                      onPressed: _openPositionAlignmentDialog,
                    ),
                  ),
                ),
              ),
            ],
          ),
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

  void _openPositionAlignmentDialog() {
    Get.dialog(
      PositionAlignmentDialog(
        title: Text('Avatar alignment'),
        alignment: widget.character.settings.photoAlignment,
        onSave: (align) {
          widget.character.settings =
              widget.character.settings.copyWith(photoAlignment: align);
          setState(() {});
          widget.onSave();
        },
      ),
    );
  }

  Widget get avatar {
    final isUrl = Uri.parse(widget.controller.text).scheme.startsWith('http');
    var container = AspectRatio(
      aspectRatio: 14.0 / 9.0,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
          image: isUrl
              ? DecorationImage(
                  fit: BoxFit.fitWidth,
                  alignment: widget.character.settings.photoAlignment,
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
