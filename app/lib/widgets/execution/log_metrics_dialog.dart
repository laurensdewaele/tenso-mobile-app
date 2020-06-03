import 'package:app/view_models/execution/log_metrics_dialog.vm.dart';
import 'package:app/widgets/execution/log_metrics_landscape.dart';
import 'package:app/widgets/execution/log_metrics_portrait.dart';
import 'package:app/widgets/toast_provider.dart';
import 'package:flutter/cupertino.dart';

class LogMetricsDialog extends StatefulWidget {
  LogMetricsDialog(
      {Key key, @required this.pastHangs, @required this.handleLoggedMetrics})
      : super(key: key);

  final List<PastHang> pastHangs;
  final void Function(List<LoggedMetric> loggedMetrics) handleLoggedMetrics;

  @override
  _EditHangsDialogState createState() => _EditHangsDialogState();
}

class _EditHangsDialogState extends State<LogMetricsDialog> {
  LogMetricsDialogViewModel _viewModel;

  @override
  void initState() {
    _viewModel = LogMetricsDialogViewModel(
        pastHangs: widget.pastHangs,
        handleLoggedMetrics: widget.handleLoggedMetrics);
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
                return LogMetricsPortrait(
                  setSelectedPastHang: _viewModel.setSelectedPastHang,
                  selectedPastHang: _viewModel.selectedPastHang,
                  pastHangs: _viewModel.pastHangs,
                  handleScrollAttempt: _viewModel.handleScrollAttempt,
                  canScroll: _viewModel.canScroll,
                  handleDone: _viewModel.handleDone,
                  hangText: _viewModel.hangText,
                  setText: _viewModel.setText,
                  setAddedWeightInput: _viewModel.setAddedWeightInput,
                  setHangTimeInput: _viewModel.setHangTimeInput,
                );
              } else {
                return LogMetricsLandscape(
                  setSelectedPastHang: _viewModel.setSelectedPastHang,
                  selectedPastHang: _viewModel.selectedPastHang,
                  pastHangs: _viewModel.pastHangs,
                  handleScrollAttempt: _viewModel.handleScrollAttempt,
                  canScroll: _viewModel.canScroll,
                  handleDone: _viewModel.handleDone,
                  hangText: _viewModel.hangText,
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
