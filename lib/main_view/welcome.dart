import 'package:flutter/material.dart';

class Welcome extends StatelessWidget {
  final bool loading;
  const Welcome({
    Key key,
    @required this.loading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
          BoxDecoration(color: Theme.of(context).scaffoldBackgroundColor),
      child: Center(
        child: loading
            ? CircularProgressIndicator(value: null)
            : Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text('Welcome to Dungeon Paper!',
                        style: TextStyle(fontSize: 24)),
                  ),
                  Text('Please log in at the rop right corner.')
                ],
              ),
      ),
    );
  }
}
