import 'package:app/widgets/button.dart';
import 'package:flutter/cupertino.dart';

import 'package:app/styles/styles.dart' as styles;
import 'package:app/widgets/section.dart';
import 'package:app/widgets/new_workout/text_input.dart';

class ExtraTab extends StatelessWidget {
  ExtraTab(
      {Key key,
      @required this.difficulty,
      @required this.name,
      @required this.grades,
      @required this.shouldLoseFocusStream,
      @required this.handleSave,
      @required this.handleErrorMessage})
      : super(key: key);

  final String difficulty;
  final String name;
  final List<String> grades;
  final Stream<bool> shouldLoseFocusStream;
  final Function(Widget message) handleErrorMessage;
  final VoidCallback handleSave;

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
                useMagnifier: true,
                magnification: 1,
                backgroundColor: styles.Colors.bgWhite,
                onSelectedItemChanged: (int item) {},
                itemExtent: 40,
                children: <Widget>[
                  ...grades.map((grade) => Center(
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
                initialValue: name,
                handleValueChanged: _handleNameChanged,
                shouldLoseFocusStream: shouldLoseFocusStream,
                handleErrorMessage: handleErrorMessage,
                shouldFocus: false)
          ],
        ),
        Center(
          child: Button(
            width: styles.Measurements.xxl * 2,
            text: 'save',
            handleTap: handleSave,
            displayIcon: false,
          ),
        )
      ],
    );
  }
}
