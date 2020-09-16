import 'package:flutter/cupertino.dart';
import 'package:tenso_app/modules/common/icon_button.dart';
import 'package:tenso_app/modules/common/icons.dart' as icons;
import 'package:tenso_app/modules/common/number_input_and_description.dart';
import 'package:tenso_app/modules/custom_board/choose_hold_type.vm.dart';
import 'package:tenso_app/styles/styles.dart' as styles;

class HoldInputPage extends StatefulWidget {
  HoldInputPage(
      {Key key,
      @required this.inputs,
      @required this.handleInput,
      @required this.handleNextTap})
      : super(key: key);

  final void Function({String input, InputPageInputTypes type}) handleInput;
  final VoidCallback handleNextTap;
  final List<InputPageInput> inputs;

  @override
  _HoldInputPageState createState() => _HoldInputPageState();
}

class _HoldInputPageState extends State<HoldInputPage> {
  @override
  Widget build(BuildContext context) {
    final double _keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    final double _viewPaddingBottom = MediaQuery.of(context).viewPadding.bottom;

    final _alignment = widget.inputs.length > 1
        ? MainAxisAlignment.start
        : MainAxisAlignment.center;
    final _flexFit = widget.inputs.length > 1 ? FlexFit.tight : FlexFit.loose;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(styles.Measurements.xs, 0, 0, 0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: _alignment,
                  children: <Widget>[
                    ...widget.inputs.map((InputPageInput input) => Flexible(
                          fit: _flexFit,
                          child: _Input(
                            initialValue: input.initialValue,
                            isInt: input.isInt,
                            description: input.description,
                            handleValueChanged: (String v) =>
                                widget.handleInput(input: v, type: input.type),
                          ),
                        )),
                  ],
                ),
              ),
              IconButton(
                  handleTap: widget.handleNextTap,
                  icon: icons.forwardIconBlackXl,
                  padding: const EdgeInsets.fromLTRB(
                      styles.Measurements.xl,
                      styles.Measurements.m,
                      styles.Measurements.xs,
                      styles.Measurements.m))
            ],
          ),
        ),
        AnimatedContainer(
          height: _keyboardHeight - _viewPaddingBottom,
          duration: Duration(milliseconds: 275),
          curve: Curves.easeOutQuad,
        )
      ],
    );
  }
}

class _Input extends StatelessWidget {
  const _Input({
    @required this.isInt,
    @required this.description,
    @required this.handleValueChanged,
    @required this.initialValue,
  });

  final bool isInt;
  final String description;
  final void Function(String v) handleValueChanged;
  final String initialValue;

  @override
  Widget build(BuildContext context) {
    final Widget _input = isInt == true
        ? NumberInputAndDescription<int>(
            description: description,
            initialValue: int.parse(initialValue),
            handleValueChanged: handleValueChanged)
        : NumberInputAndDescription<double>(
            description: description,
            initialValue: double.parse(initialValue),
            handleValueChanged: handleValueChanged);
    return _input;
  }
}
