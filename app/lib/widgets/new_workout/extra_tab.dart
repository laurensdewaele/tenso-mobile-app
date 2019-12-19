import 'package:flutter/cupertino.dart';

import 'package:app/styles/styles.dart' as styles;
import 'package:app/widgets/new_workout/section.dart';
import 'package:app/widgets/new_workout/text_input.dart';

class ExtraTab extends StatefulWidget {
  ExtraTab(
      {Key key,
      @required this.difficulty,
      @required this.name,
      @required this.grades,
      @required this.shouldLoseFocusStream,
      @required this.handleErrorMessage})
      : super(key: key);

  final String difficulty;
  final String name;
  final List<String> grades;
  final Stream<bool> shouldLoseFocusStream;
  final Function(Widget message) handleErrorMessage;

  @override
  _ExtraTabState createState() => _ExtraTabState();
}

class _ExtraTabState extends State<ExtraTab> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  void _handleNameChanged(String name) {
    // TODO: Connect to store
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Section(
          title: 'difficulty',
          children: <Widget>[
            Container(
              height: 150,
              child: CupertinoPicker(
                backgroundColor: styles.Colors.bgWhite,
                onSelectedItemChanged: (int item) {},
                itemExtent: 40,
                children: <Widget>[
                  ...widget.grades.map((grade) => Center(
                        child: Text(
                          grade,
                          style: styles.Typography.text,
                        ),
                      ))
                ],
              ),
            )
          ],
        ),
        Section(
          title: 'name',
          children: <Widget>[
            TextInput(
                initialValue: widget.name,
                handleValueChanged: _handleNameChanged,
                shouldLoseFocusStream: widget.shouldLoseFocusStream,
                handleErrorMessage: widget.handleErrorMessage,
                shouldFocus: false)
          ],
        )
      ],
    );
  }
}
