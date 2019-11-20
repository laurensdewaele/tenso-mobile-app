import 'package:flutter/cupertino.dart';

import 'package:app/styles/styles.dart' as styles;
import 'package:app/widgets/button.dart';
import 'package:app/widgets/dialog.dart';
import 'package:app/widgets/dividers.dart';

Future<T> showDeleteDialog<T>(
    {@required BuildContext context,
    @required String workoutName,
    @required VoidCallback handleCancelTap,
    @required VoidCallback handleDeleteTap}) {
  return showCupertinoDialog(
      context: context,
      builder: (BuildContext context) => AppDialog(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  'Are you sure you want to delete workout:',
                  style: styles.Typography.dialogText,
                  textAlign: TextAlign.center,
                ),
                Divider(),
                Text(workoutName, style: styles.Typography.title),
                LargeDivider(),
                Row(
                  children: <Widget>[
                    Expanded(
                        flex: 1,
                        child: GestureDetector(
                          onTap: handleCancelTap,
                          child: Center(
                            child: Text(
                              'Cancel',
                              style: styles.Typography.buttonBlack,
                            ),
                          ),
                        )),
                    Expanded(
                        flex: 1,
                        child: Button(
                          text: 'Delete',
                          handleTap: handleDeleteTap,
                          displayIcon: false,
                        ))
                  ],
                )
              ],
            ),
          ));
}
