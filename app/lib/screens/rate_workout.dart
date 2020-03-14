import 'package:flutter/cupertino.dart' hide Icon;

import 'package:app/styles/styles.dart' as styles;
import 'package:app/widgets/button.dart';
import 'package:app/widgets/dialog.dart';
import 'package:app/widgets/divider.dart';
import 'package:app/widgets/icon.dart';
import 'package:app/widgets/icon_button.dart';
import 'package:app/widgets/keyboard_and_toast_provider.dart';
import 'package:app/widgets/keyboard_list_view.dart';
import 'package:app/widgets/number_input_and_description.dart';

class RateWorkoutScreen extends StatelessWidget {
  RateWorkoutScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double maxContainerHeight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        MediaQuery.of(context).padding.bottom;

    return KeyboardAndToastProvider(
      child: Container(
        decoration: BoxDecoration(color: styles.Colors.bgWhite),
        child: SafeArea(
          child: KeyboardListView(children: [
            Container(
              height: maxContainerHeight,
              child: Padding(
                padding: EdgeInsets.all(styles.Measurements.m),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: Center(
                        child: Image.asset(
                          'assets/images/fist.png',
                        ),
                      ),
                    ),
                    Divider(
                      height: styles.Measurements.m,
                    ),
                    Text(
                      'Congratulations!',
                      style: styles.Staatliches.xlBlack,
                    ),
                    Divider(height: styles.Measurements.l),
                    Text(
                      'You’re one step closer to indestructible and indefatigable fingers!',
                      style: styles.Lato.sBlack,
                    ),
                    Divider(
                      height: styles.Measurements.xxl,
                    ),
                    _InputDestructionLevel(),
                  ],
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }
}

class _DestructionLevelInfo extends StatelessWidget {
  _DestructionLevelInfo({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              'This value signifies how hard the workout was for you.',
              style: styles.Lato.xsBlack,
            ),
            RichText(
              text: TextSpan(
                  text: 'Or, in other words, ',
                  style: styles.Lato.xsBlack,
                  children: [
                    TextSpan(
                        text: 'how difficult it felt to complete the workout',
                        style: styles.Lato.xsBlackBold),
                    TextSpan(
                        text: ', on a scale of 1 to 10.',
                        style: styles.Lato.xsBlack),
                  ]),
            ),
            Divider(
              height: styles.Measurements.m,
            ),
            Text(
              'As all things in life, this will not be constant.',
              style: styles.Lato.xsBlack,
            ),
            Text(
              'On good days this workout might not have been very hard, whereas on lesser days, it might seem really difficult to hold on.',
              style: styles.Lato.xsBlack,
            ),
            Divider(
              height: styles.Measurements.m,
            ),
            Text(
              'However, as we continually stimulate the body to adjust to the stresses of fingerboarding, we should see a particular exercise become easier (less hard) over time.',
              style: styles.Lato.xsBlack,
            ),
            Divider(
              height: styles.Measurements.m,
            ),
            RichText(
              text: TextSpan(
                  text:
                      'Therefore, we kindly request you to fill out this value, ',
                  style: styles.Lato.xsBlack,
                  children: [
                    TextSpan(
                        text: 'so you can better track your progression.',
                        style: styles.Lato.xsBlackBold),
                  ]),
            ),
            Divider(
              height: styles.Measurements.xxl,
            ),
            Transform.scale(
              scale: .8,
              child: Button(
                  displayBackground: false,
                  text: 'Ok',
                  handleTap: () {
                    Navigator.of(context).pop();
                  }),
            )
          ],
        )
      ],
    );
  }
}

class _InputDestructionLevel extends StatelessWidget {
  _InputDestructionLevel({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Row(
        children: [
          Text(
            'Destruction level',
            style: styles.Staatliches.xlBlack,
          ),
          IconButton(
              handleTap: () {
                showAppDialog(
                    context: context, content: _DestructionLevelInfo());
              },
              icon: Icon(
                size: 28,
                iconData: IconData(0xf44c,
                    fontFamily: 'CupertinoIcons',
                    fontPackage: 'cupertino_icons'),
                color: styles.Colors.black,
              ))
        ],
      ),
      NumberInputAndDescription(
        enabled: true,
        primaryColor: styles.Colors.turquoise,
        isDouble: false,
        description: 'felt destruction',
        handleIntValueChanged: (int n) {},
        initialIntValue: 0,
        maxIntValue: 10,
      ),
      Divider(
        height: styles.Measurements.xxl,
      ),
      Button(
        backgroundColor: styles.Colors.turquoise,
        width: double.infinity,
        text: 'done',
        handleTap: () {},
      ),
    ]);
  }
}
