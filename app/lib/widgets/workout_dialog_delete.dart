import 'package:flutter/cupertino.dart';

import 'package:app/styles/styles.dart' as styles;
import 'package:app/widgets/buttons.dart';
import 'package:app/widgets/dialog.dart';
import 'package:app/widgets/dividers.dart';

Future<void> showDeleteDialog(
    {@required BuildContext context,
    @required String workoutName,
    @required VoidCallback handleCancelTap,
    @required VoidCallback handleDeleteTap}) {
  final String name = workoutName.toLowerCase();

  return showAppDialog(
      context: context,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            'Are you sure you want to delete "$name"?',
            style: styles.Typography.dialogText,
            textAlign: TextAlign.center,
          ),
          Divider(height: styles.Measurements.l),
          Row(
            children: <Widget>[
              Expanded(
                  flex: 1,
                  child:
                      TextButton(text: 'Cancel', handleTap: handleCancelTap)),
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
      ));
}
