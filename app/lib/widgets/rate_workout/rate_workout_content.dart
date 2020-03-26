import 'package:app/widgets/section_with_info_icon.dart';
import 'package:flutter/cupertino.dart' hide Icon;

import 'package:app/styles/styles.dart' as styles;
import 'package:app/widgets/button.dart';
import 'package:app/widgets/divider.dart';
import 'package:app/widgets/empty_input_and_description.dart';
import 'package:app/widgets/expanded_section.dart';
import 'package:app/widgets/text_input.dart';

class RateWorkoutContent extends StatelessWidget {
  RateWorkoutContent(
      {Key key,
      @required this.handleCompleteTap,
      @required this.handlePerceivedExertionChanged,
      @required this.handleOpen,
      @required this.handleBodyWeightChanged,
      @required this.handleCommentsChanged,
      @required this.handleHumidityChanged,
      @required this.handleTemperatureChanged})
      : super(key: key);

  final void Function(int v) handlePerceivedExertionChanged;
  final void Function(String s) handleBodyWeightChanged;
  final void Function(String s) handleTemperatureChanged;
  final void Function(String s) handleHumidityChanged;
  final void Function(String s) handleCommentsChanged;
  final VoidCallback handleCompleteTap;
  final VoidCallback handleOpen;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Divider(
          height: 12,
        ),
        SectionWithInfoIcon(
          title: 'perceived exertion *',
          appDialogContent: _PerceivedExertionInfo(),
          children: <Widget>[
            _CupertinoPicker(
              setPerceivedExertion: handlePerceivedExertionChanged,
            ),
          ],
        ),
        ExpandedSection(
          handleOpen: handleOpen,
          title: 'advanced statistics',
          children: <Widget>[
            Divider(
              height: styles.Measurements.l,
            ),
            EmptyInputAndDescription(
              primaryColor: styles.Colors.turquoise,
              description: 'body weight',
              handleValueChanged: handleBodyWeightChanged,
            ),
            Divider(
              height: styles.Measurements.m,
            ),
            EmptyInputAndDescription(
              primaryColor: styles.Colors.turquoise,
              description: 'temperature',
              handleValueChanged: handleTemperatureChanged,
            ),
            Divider(
              height: styles.Measurements.m,
            ),
            EmptyInputAndDescription(
              primaryColor: styles.Colors.turquoise,
              description: 'humidity',
              handleValueChanged: handleHumidityChanged,
            ),
            Divider(
              height: styles.Measurements.xl,
            ),
          ],
        ),
        ExpandedSection(
          handleOpen: handleOpen,
          title: 'comments',
          children: <Widget>[
            Divider(
              height: styles.Measurements.l,
            ),
            Container(
              height: 100,
              child: TextInput(
                  multiLine: true,
                  enabled: true,
                  primaryColor: styles.Colors.turquoise,
                  initialValue: '',
                  handleValueChanged: handleCommentsChanged),
            )
          ],
        ),
      ],
    );
  }
}

class _PerceivedExertionInfo extends StatelessWidget {
  _PerceivedExertionInfo({Key key}) : super(key: key);

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
                        text:
                            'how much effort it took for you to complete the workout',
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
              'However, as we continually stimulate the body to adjust to the stresses of fingerboarding, we should see a particular exercise become easier over time.',
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
              height: styles.Measurements.l,
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

class _CupertinoPicker extends StatelessWidget {
  _CupertinoPicker({Key key, @required this.setPerceivedExertion})
      : super(key: key);

  final void Function(int d) setPerceivedExertion;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      child: CupertinoPicker(
        scrollController: FixedExtentScrollController(initialItem: 10),
        useMagnifier: true,
        magnification: 1,
        backgroundColor: styles.Colors.bgWhite,
        onSelectedItemChanged: (int index) {
          setPerceivedExertion(index + 1);
        },
        itemExtent: 40,
        children: <Widget>[
          ...List.generate(10, (i) => i + 1).map((n) => Center(
                child: Text(
                  n.toString(),
                  style: styles.Lato.xsGray,
                ),
              ))
        ],
      ),
    );
  }
}
