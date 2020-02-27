import 'package:flutter/cupertino.dart';

import 'package:app/styles/styles.dart' as styles;
import 'package:app/widgets/button.dart';
import 'package:app/widgets/dialog.dart';
import 'package:app/widgets/divider.dart';

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
            'Are you sure you want to delete:',
            style: styles.Typography.textInfo,
            textAlign: TextAlign.center,
          ),
          Text(
            '$name ?',
            style: styles.Typography.textInfoBold,
            textAlign: TextAlign.center,
          ),
          Divider(height: styles.Measurements.l),
          Row(
            children: <Widget>[
              Expanded(
                  flex: 1,
                  child: Transform.scale(
                      scale: 0.8,
                      child:
                          Button(text: 'Cancel', handleTap: handleCancelTap))),
              Expanded(
                  flex: 1,
                  child: Transform.scale(
                    scale: 0.8,
                    child: Button(
                      displayBackground: false,
                      text: 'Delete',
                      handleTap: handleDeleteTap,
                    ),
                  ))
            ],
          )
        ],
      ));
}
