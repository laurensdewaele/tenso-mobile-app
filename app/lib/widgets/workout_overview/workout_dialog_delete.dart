import 'package:app/styles/styles.dart' as styles;
import 'package:app/widgets/button.dart';
import 'package:app/widgets/calendar/constants.dart';
import 'package:app/widgets/dialog.dart';
import 'package:app/widgets/divider.dart';
import 'package:flutter/cupertino.dart';

Future<void> showWorkoutDeleteDialog({
  @required BuildContext context,
  @required String workoutName,
  @required VoidCallback handleCancelTap,
  @required VoidCallback handleDeleteTap,
}) {
  final String name = workoutName.toLowerCase();

  return showAppDialog(
      smallWidth: false,
      context: context,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            'Are you sure you want to delete:',
            style: styles.Lato.sBlack,
            textAlign: TextAlign.center,
          ),
          Divider(
            height: styles.Measurements.m,
          ),
          Text(
            name,
            style: styles.Staatliches.lBlack,
          ),
          Divider(height: styles.Measurements.l),
          Row(
            children: <Widget>[
              Expanded(
                  flex: 1,
                  child: Button(
                      small: true,
                      displayBackground: false,
                      text: 'Cancel',
                      handleTap: handleCancelTap)),
              Expanded(
                  flex: 1,
                  child: Button(
                    small: true,
                    text: 'Delete',
                    handleTap: handleDeleteTap,
                  ))
            ],
          )
        ],
      ));
}

Future<void> showCompletedWorkoutDeleteDialog({
  @required BuildContext context,
  @required String workoutName,
  @required DateTime completedDate,
  @required VoidCallback handleCancelTap,
  @required VoidCallback handleDeleteTap,
}) {
  final String name = workoutName.toUpperCase();
  final String weekDay = kWeekDays[completedDate.weekday];
  final String day = completedDate.day.toString();
  final String month = kMonths[completedDate.month];
  final String hour = completedDate.hour.toString();
  final String minute = completedDate.minute.toString();

  final String date = '$weekDay $day $month - $hour:$minute';

  return showAppDialog(
      smallWidth: false,
      context: context,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            'Are you sure you want to delete following entry:',
            style: styles.Lato.sBlack,
            textAlign: TextAlign.center,
          ),
          Divider(
            height: styles.Measurements.m,
          ),
          Text(
            '$name',
            style: styles.Lato.sBlackBold,
            textAlign: TextAlign.center,
          ),
          Divider(
            height: styles.Measurements.xs,
          ),
          Text(
            '$date',
            style: styles.Lato.sBlackBold,
            textAlign: TextAlign.center,
          ),
          Divider(height: styles.Measurements.l),
          Row(
            children: <Widget>[
              Expanded(
                  flex: 1,
                  child: Button(
                      small: true,
                      displayBackground: false,
                      text: 'Cancel',
                      handleTap: handleCancelTap)),
              Expanded(
                  flex: 1,
                  child: Button(
                    small: true,
                    text: 'Delete',
                    handleTap: handleDeleteTap,
                  ))
            ],
          )
        ],
      ));
}
