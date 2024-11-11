import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../resources/constants.dart';

class MessageSendingTile extends StatelessWidget {
   MessageSendingTile({this.controller, this.onPressed});
  TextEditingController? controller;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: kMessageContainerDecoration,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: controller,
              onChanged: (value) {
                //Do something with the user input.
              },
              decoration: kMessageTextFieldDecoration,
            ),
          ),
          TextButton(
            onPressed: onPressed,
            child: const Text(
              'Send',
              style: kSendButtonTextStyle,
            ),
          ),
        ],
      ),
    );
  }
}