import 'package:flutter/cupertino.dart' hide Icon;
import 'package:tenso_app/models/models.dart';
import 'package:tenso_app/styles/styles.dart' as styles;
import 'package:tenso_app/widgets/button.dart';
import 'package:tenso_app/widgets/divider.dart';
import 'package:tenso_app/widgets/expanded_section.dart';
import 'package:tenso_app/widgets/number_input_and_description.dart';
import 'package:tenso_app/widgets/section_with_info_icon.dart';
import 'package:tenso_app/widgets/text_input.dart';

class RateWorkoutContent extends StatelessWidget {
  RateWorkoutContent({
    Key key,
    @required this.handleCompleteTap,
    @required this.handlePerceivedExertionChanged,
    @required this.handleBodyWeightChanged,
    @required this.handleCommentsChanged,
    @required this.handleHumidityChanged,
    @required this.handleTemperatureChanged,
    @required this.tempUnit,
    @required this.initialComments,
    @required this.initialBodyWeight,
    @required this.initialHumidity,
    @required this.initialPerceivedExertion,
    @required this.initialTemperature,
    this.editing = false,
    this.maxContainerHeight,
  }) : super(key: key);

  final void Function(int v) handlePerceivedExertionChanged;
  final void Function(String s) handleBodyWeightChanged;
  final void Function(String s) handleTemperatureChanged;
  final void Function(String s) handleHumidityChanged;
  final void Function(String s) handleCommentsChanged;
  final double maxContainerHeight;
  final VoidCallback handleCompleteTap;
  final TempUnit tempUnit;
  final String initialComments;
  final double initialHumidity;
  final double initialTemperature;
  final double initialBodyWeight;
  final int initialPerceivedExertion;
  final bool editing;

  @override
  Widget build(BuildContext context) {
    final Color _primaryColor =
        editing == true ? styles.Colors.blue : styles.Colors.turquoise;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Divider(
          height: styles.Measurements.s,
        ),
        ExpandedSection(
          title: 'comments',
          children: <Widget>[
            Divider(
              height: styles.Measurements.l,
            ),
            Container(
              height: 300,
              child: TextInput(
                  multiLine: true,
                  enabled: true,
                  primaryColor: _primaryColor,
                  initialValue: initialComments,
                  handleValueChanged: handleCommentsChanged),
            ),
            Divider(
              height: styles.Measurements.xxl -
                  styles.Measurements.kInfoIconSurplus,
            ),
          ],
        ),
        ExpandedSection(
          title: 'advanced statistics',
          children: <Widget>[
            Divider(
              height: styles.Measurements.l,
            ),
            NumberInputAndDescription<double>(
              primaryColor: _primaryColor,
              description: 'body weight',
              handleValueChanged: handleBodyWeightChanged,
              initialValue: initialBodyWeight,
            ),
            Divider(
              height: styles.Measurements.m,
            ),
            NumberInputAndDescription<double>(
              primaryColor: _primaryColor,
              description: '° ${tempUnit.toString()}',
              handleValueChanged: handleTemperatureChanged,
              initialValue: initialTemperature,
            ),
            Divider(
              height: styles.Measurements.m,
            ),
            NumberInputAndDescription<double>(
              primaryColor: _primaryColor,
              description: 'humidity',
              handleValueChanged: handleHumidityChanged,
              initialValue: initialHumidity,
            ),
            Divider(
              height: styles.Measurements.xxl -
                  styles.Measurements.kInfoIconSurplus,
            ),
          ],
        ),
        SectionWithInfoIcon(
          title: 'perceived exertion *',
          appDialogContent: _PerceivedExertionInfo(),
          children: <Widget>[
            _CupertinoPicker(
              setPerceivedExertion: handlePerceivedExertionChanged,
              initialPerceivedExertion: initialPerceivedExertion,
            ),
          ],
        ),
        if (maxContainerHeight != null)
          Divider(height: maxContainerHeight - 552),
        if (maxContainerHeight == null)
          Divider(height: styles.Measurements.xxl),
        Button(
          backgroundColor: _primaryColor,
          width: double.infinity,
          text: 'done',
          handleTap: handleCompleteTap,
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
            Divider(
              height: styles.Measurements.xs,
            ),
            RichText(
              text: TextSpan(
                  text: 'Or, in other words, ',
                  style: styles.Lato.xsBlack,
                  children: [
                    TextSpan(
                        text: 'how much effort ',
                        style: styles.Lato.xsBlackBold),
                    TextSpan(
                        text:
                            'it took for you to complete the workout, on a scale of 1 to 10.',
                        style: styles.Lato.xsBlack),
                  ]),
            ),
            Divider(
              height: styles.Measurements.xs,
            ),
            RichText(
              text: TextSpan(
                  text: 'We kindly request you to fill out this value, ',
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
            Button(
                small: true,
                displayBackground: false,
                text: 'Ok',
                handleTap: () {
                  Navigator.of(context).pop();
                })
          ],
        )
      ],
    );
  }
}

class _CupertinoPicker extends StatelessWidget {
  _CupertinoPicker(
      {Key key,
      @required this.setPerceivedExertion,
      @required this.initialPerceivedExertion})
      : super(key: key);

  final void Function(int d) setPerceivedExertion;
  final int initialPerceivedExertion;

  @override
  Widget build(BuildContext context) {
    final int _initialItem =
        initialPerceivedExertion == null ? 10 : initialPerceivedExertion - 1;
    return Container(
      height: 150,
      child: CupertinoPicker(
        scrollController:
            FixedExtentScrollController(initialItem: _initialItem),
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
