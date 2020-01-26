import 'package:flutter/material.dart';

class DialogBox {

  show({ BuildContext context, String title, Widget content, List<Widget> actions }) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => AlertDialog(
        title: Text(title),
        content: content,
        actions: actions
      )
    );
  }

}
