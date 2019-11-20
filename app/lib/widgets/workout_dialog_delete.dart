import 'package:app/widgets/dialog.dart';
import 'package:flutter/cupertino.dart';

Future<T> showDeleteDialog<T>(
    {@required BuildContext context,
    @required String workoutName,
    @required VoidCallback handleCancelTap,
    @required VoidCallback handleDeleteTap}) {
  return showCupertinoDialog(
      context: context,
      builder: (BuildContext context) => AppDialog(
            child: Text('Are you sure you want to delete workout'),
          ));
}
