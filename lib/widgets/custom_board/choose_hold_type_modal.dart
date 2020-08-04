import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:tenso_app/models/models.dart';
import 'package:tenso_app/styles/styles.dart' as styles;
import 'package:tenso_app/view_models/custom_board/choose_hold_type.vm.dart';
import 'package:tenso_app/widgets/custom_board/hold_input_page.dart';

class ChooseHoldTypeModal extends StatefulWidget {
  const ChooseHoldTypeModal(
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
  final void Function({double sloperDegrees}) handleSloperInput;
  final void Function({double depth, int supportedFingers}) handlePocketInput;
  final void Function({double depth}) handleEdgeInput;

  @override
  _ChooseHoldTypeModalState createState() => _ChooseHoldTypeModalState();
}

class _ChooseHoldTypeModalState extends State<ChooseHoldTypeModal> {
  ChooseHoldTypeViewModel _viewModel;

  @override
  void initState() {
    _viewModel = ChooseHoldTypeViewModel(
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
        : HoldInputPage(
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
