import 'package:flutter/cupertino.dart';
import 'package:tenso_app/view_models/execution/adjust_hangs_dialog.vm.dart';
import 'package:tenso_app/widgets/execution/adjust_hangs_landscape.dart';
import 'package:tenso_app/widgets/execution/adjust_hangs_portrait.dart';

class AdjustedHang {
  final int sequenceTimerIndex;
  final double effectiveAddedWeight;
  final double effectiveDurationS;

  const AdjustedHang({
    @required this.sequenceTimerIndex,
    @required this.effectiveAddedWeight,
    @required this.effectiveDurationS,
  });
}

class AdjustHangsDialog extends StatefulWidget {
  AdjustHangsDialog(
      {Key key, @required this.pastHangs, @required this.handleAdjustedHangs})
      : super(key: key);

  final List<PastHang> pastHangs;
  final void Function(List<AdjustedHang> adjustedHangs) handleAdjustedHangs;

  @override
  _AdjustHangsDialogState createState() => _AdjustHangsDialogState();
}

class _AdjustHangsDialogState extends State<AdjustHangsDialog> {
  AdjustHangsDialogViewModel _viewModel;

  @override
  void initState() {
    _viewModel = AdjustHangsDialogViewModel(
        pastHangs: widget.pastHangs,
        handleAdjustedHangs: widget.handleAdjustedHangs);
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
    return WillPopScope(
      onWillPop: () async {
        _viewModel.handleDone();
        return false;
      },
      child: Container(
        width: double.infinity,
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            final Orientation _orientation = MediaQuery.of(context).orientation;
            if (_orientation == Orientation.portrait) {
              return AdjustHangsPortrait(
                groupText: _viewModel.groupText,
                setSelectedPastHang: _viewModel.setSelectedPastHang,
                selectedPastHang: _viewModel.selectedPastHang,
                pastHangs: _viewModel.pastHangs,
                handleScrollAttempt: _viewModel.handleScrollAttempt,
                canScroll: _viewModel.canScroll,
                handleDone: _viewModel.handleDone,
                repText: _viewModel.repText,
                setText: _viewModel.setText,
                setAddedWeightInput: _viewModel.setAddedWeightInput,
                setHangTimeInput: _viewModel.setHangTimeInput,
              );
            } else {
              return AdjustHangsLandscape(
                setSelectedPastHang: _viewModel.setSelectedPastHang,
                selectedPastHang: _viewModel.selectedPastHang,
                pastHangs: _viewModel.pastHangs,
                handleScrollAttempt: _viewModel.handleScrollAttempt,
                canScroll: _viewModel.canScroll,
                handleDone: _viewModel.handleDone,
                repText: _viewModel.repText,
                setText: _viewModel.setText,
                setAddedWeightInput: _viewModel.setAddedWeightInput,
                setHangTimeInput: _viewModel.setHangTimeInput,
              );
            }
          },
        ),
      ),
    );
  }
}
