import 'package:app/models/models.dart';
import 'package:app/styles/styles.dart' as styles;
import 'package:app/view_models/custom_board/hold_input_vm.dart';
import 'package:app/widgets/icon_button.dart';
import 'package:app/widgets/icons.dart' as icons;
import 'package:app/widgets/number_input_and_description.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';

class HoldInputModal extends StatefulWidget {
  const HoldInputModal(
      {@required this.handlePinchBlockInput,
      @required this.handleJugInput,
      @required this.handleSloperInput,
      @required this.handlePocketInput,
      @required this.handleEdgeInput,
      @required this.isTopRow,
      @required this.multipleSelection});

  final bool isTopRow;
  final bool multipleSelection;
  final VoidCallback handlePinchBlockInput;
  final VoidCallback handleJugInput;
  final void Function({double degrees}) handleSloperInput;
  final void Function({double depth, int supportedFingers}) handlePocketInput;
  final void Function({double depth}) handleEdgeInput;

  @override
  _HoldInputModalState createState() => _HoldInputModalState();
}

class _HoldInputModalState extends State<HoldInputModal> {
  HoldInputViewModel _viewModel;

  @override
  void initState() {
    _viewModel = HoldInputViewModel(
        multipleSelection: widget.multipleSelection,
        handleEdgeInput: widget.handleEdgeInput,
        handleJugInput: widget.handleJugInput,
        handlePinchBlockInput: widget.handlePinchBlockInput,
        handlePocketInput: widget.handlePocketInput,
        handleSloperInput: widget.handleSloperInput);
    _viewModel.addListener(_viewModelListener);
    super.initState();
  }

  void _viewModelListener() {
    setState(() {});
  }

  @override
  void dispose() {
    _viewModel.removeListener(_viewModelListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _viewModel.isChooseHoldTypePageActive == true
        ? _ChooseHoldTypePage(
            isTopRow: widget.isTopRow, handleTap: _viewModel.handleHoldTypeTap)
        : _InputPage(
            inputs: _viewModel.inputPageInputs,
            handleInput: _viewModel.handleInput,
            handleNextTap: () async {
              await _viewModel.handleNextTap();
              Navigator.of(context).pop();
            });
  }
}

class _ChooseHoldTypePage extends StatelessWidget {
  _ChooseHoldTypePage({@required this.isTopRow, @required this.handleTap});

  final bool isTopRow;
  final void Function(HoldType type) handleTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: styles.Measurements.xs, vertical: styles.Measurements.xs),
      child: isTopRow == true
          ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _Button(
                  text: 'pinch block',
                  handleTap: () => handleTap(HoldType.pinchBlock),
                ),
                _Button(
                  text: 'sloper',
                  handleTap: () => handleTap(HoldType.sloper),
                ),
                _Button(
                  text: 'jug',
                  handleTap: () => handleTap(HoldType.jug),
                ),
              ],
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _Button(
                  text: 'pocket',
                  handleTap: () => handleTap(HoldType.pocket),
                ),
                _Button(
                  text: 'edge',
                  handleTap: () => handleTap(HoldType.edge),
                ),
              ],
            ),
    );
  }
}

class _Button extends StatelessWidget {
  _Button({Key key, @required this.text, this.handleTap}) : super(key: key);

  final String text;
  final VoidCallback handleTap;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      fit: FlexFit.loose,
      child: GestureDetector(
        onTap: handleTap,
        child: Container(
          decoration: BoxDecoration(color: styles.Colors.translucent),
          width: double.infinity,
          child: Text(
            text,
            style: styles.Staatliches.xlBlack,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

class _InputPage extends StatelessWidget {
  _InputPage(
      {Key key,
      @required this.inputs,
      @required this.handleInput,
      @required this.handleNextTap})
      : super(key: key);

  final void Function({String input, InputPageInputTypes type}) handleInput;
  final VoidCallback handleNextTap;
  final List<InputPageInput> inputs;

  @override
  Widget build(BuildContext context) {
    final _alignment =
        inputs.length > 1 ? MainAxisAlignment.start : MainAxisAlignment.center;
    final _flexFit = inputs.length > 1 ? FlexFit.tight : FlexFit.loose;
    return Padding(
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
                ...inputs.map((InputPageInput input) => Flexible(
                      fit: _flexFit,
                      child: _InputPageInput(
                        initialValue: input.initialValue,
                        isInt: input.isInt,
                        description: input.description,
                        handleValueChanged: (String v) =>
                            handleInput(input: v, type: input.type),
                      ),
                    )),
              ],
            ),
          ),
          IconButton(
              handleTap: handleNextTap,
              icon: icons.forwardIconBlackXl,
              padding: const EdgeInsets.fromLTRB(
                  styles.Measurements.xl,
                  styles.Measurements.m,
                  styles.Measurements.xs,
                  styles.Measurements.m))
        ],
      ),
    );
  }
}

class _InputPageInput extends StatelessWidget {
  const _InputPageInput({
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
