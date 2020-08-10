import 'package:flutter/cupertino.dart';
import 'package:tenso_app/styles/styles.dart' as styles;
import 'package:tenso_app/widgets/button.dart';
import 'package:tenso_app/widgets/divider.dart';
import 'package:tenso_app/widgets/text_input.dart';

class CommentsDialog extends StatefulWidget {
  CommentsDialog(
      {Key key, @required this.initialComments, @required this.setComments})
      : super(key: key);

  final String initialComments;
  final void Function(String comments) setComments;

  @override
  _CommentsDialogState createState() => _CommentsDialogState();
}

class _CommentsDialogState extends State<CommentsDialog> {
  String _comments;

  @override
  void initState() {
    _comments = widget.initialComments;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _handleCommentsChanged(String comments) {
    setState(() {
      _comments = comments;
    });
  }

  void _handleDoneTap() {
    widget.setComments(_comments);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final Orientation _orientation = MediaQuery.of(context).orientation;
          if (_orientation == Orientation.portrait) {
            return _CommentsPortrait(
              initialComments: _comments,
              handleCommentsChanged: _handleCommentsChanged,
              handleDoneTap: _handleDoneTap,
            );
          } else {
            return _CommentsLandscape(
              initialComments: _comments,
              handleCommentsChanged: _handleCommentsChanged,
              handleDoneTap: _handleDoneTap,
            );
          }
        },
      ),
    );
  }
}

class _CommentsPortrait extends StatelessWidget {
  const _CommentsPortrait(
      {@required this.initialComments,
      @required this.handleCommentsChanged,
      @required this.handleDoneTap});

  final String initialComments;
  final void Function(String comments) handleCommentsChanged;
  final VoidCallback handleDoneTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Divider(height: styles.Measurements.l),
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
          handleTap: handleDoneTap,
          text: 'Done',
          small: true,
          displayBackground: false,
        )
      ],
    );
  }
}

class _CommentsLandscape extends StatelessWidget {
  const _CommentsLandscape(
      {@required this.initialComments,
      @required this.handleCommentsChanged,
      @required this.handleDoneTap});

  final String initialComments;
  final void Function(String comments) handleCommentsChanged;
  final VoidCallback handleDoneTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
            child: TextInput(
                multiLine: true,
                enabled: true,
                primaryColor: styles.Colors.turquoise,
                initialValue: initialComments,
                handleValueChanged: handleCommentsChanged)),
        Divider(height: styles.Measurements.s),
        Button(
          handleTap: handleDoneTap,
          text: 'Done',
          small: true,
          displayBackground: false,
        )
      ],
    );
  }
}
