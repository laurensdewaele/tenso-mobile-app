import 'package:flutter/cupertino.dart';
import 'package:tenso_app/modules/common/button.dart';
import 'package:tenso_app/modules/common/divider.dart';
import 'package:tenso_app/modules/keyboard_input/text_input.dart';
import 'package:tenso_app/styles/styles.dart' as styles;

class CommentsDialog extends StatelessWidget {
  CommentsDialog(
      {Key key,
      @required this.initialComments,
      @required this.handleCommentsChanged})
      : super(key: key);

  final String initialComments;
  final void Function(String comments) handleCommentsChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: TextInput(
              multiLine: true,
              enabled: true,
              primaryColor: styles.Colors.turquoise,
              initialValue: initialComments,
              handleValueChanged: handleCommentsChanged),
        ),
        Divider(height: styles.Measurements.s),
        Button(
          handleTap: () {
            Navigator.of(context).pop();
          },
          text: 'Done',
          small: true,
          displayBackground: false,
        )
      ],
    );
  }
}
