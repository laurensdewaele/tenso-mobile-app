import 'package:app/models/models.dart';
import 'package:app/widgets/button.dart';
import 'package:app/widgets/icons.dart' as icons;
import 'package:flutter/cupertino.dart' hide Icon;

class Groups extends StatefulWidget {
  Groups(
      {Key key,
      @required this.groups,
      @required this.isNewWorkout,
      @required this.handleAddGroupTap})
      : super(key: key);

  final List<Group> groups;
  final bool isNewWorkout;
  final VoidCallback handleAddGroupTap;

  @override
  _GroupsState createState() => _GroupsState();
}

class _GroupsState extends State<Groups> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        if (widget.isNewWorkout == true)
          Button(
              text: 'Add group',
              handleTap: widget.handleAddGroupTap,
              leadingIcon: icons.plusIconWhiteXl)
      ],
    );
  }
}
