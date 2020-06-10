import 'package:app/models/models.dart';
import 'package:app/widgets/workout/selected_grips_and_holds.dart';
import 'package:flutter/cupertino.dart' hide Icon;

class GroupPicker extends StatefulWidget {
  GroupPicker({Key key, @required this.groups}) : super(key: key);

  final List<Group> groups;

  @override
  _GroupPickerState createState() => _GroupPickerState();
}

class _GroupPickerState extends State<GroupPicker> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ...widget.groups.map((Group group) => SelectedGripsAndHolds(
              board: group.board,
              leftGrip: group.leftGrip,
              leftGripBoardHold: group.leftGripBoardHold,
              rightGrip: group.rightGrip,
              rightGripBoardHold: group.rightGripBoardHold,
            )),
      ],
    );
  }
}
