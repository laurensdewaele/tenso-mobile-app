import 'package:flutter/cupertino.dart';
import 'package:tenso_app/view_models/execution/log_hangs_dialog.vm.dart';
import 'package:tenso_app/widgets/execution/log_hangs_landscape.dart';
import 'package:tenso_app/widgets/execution/log_hangs_portrait.dart';
import 'package:tenso_app/widgets/toast_provider.dart';

class LoggedHang {
  final int sequenceTimerIndex;
  final double effectiveAddedWeight;
  final double effectiveDurationS;

  const LoggedHang({
    @required this.sequenceTimerIndex,
    @required this.effectiveAddedWeight,
    @required this.effectiveDurationS,
  });
}

class LogHangsDialog extends StatefulWidget {
  LogHangsDialog(
      {Key key, @required this.pastHangs, @required this.handleLoggedHangs})
      : super(key: key);

  final List<PastHang> pastHangs;
  final void Function(List<LoggedHang> loggedHangs) handleLoggedHangs;

  @override
  _LogHangsDialogState createState() => _LogHangsDialogState();
}

class _LogHangsDialogState extends State<LogHangsDialog> {
  LogHangsDialogViewModel _viewModel;

  @override
  void initState() {
    _viewModel = LogHangsDialogViewModel(
        pastHangs: widget.pastHangs,
        handleLoggedHangs: widget.handleLoggedHangs);
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
      child: ToastProvider(
        child: Container(
          width: double.infinity,
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              final Orientation _orientation =
                  MediaQuery.of(context).orientation;
              if (_orientation == Orientation.portrait) {
                return LogHangsPortrait(
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
                return LogHangsLandscape(
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
      ),
    );
  }
}
