import 'package:app/view_models/execution/edit_hangs_dialog.vm.dart';
import 'package:app/widgets/execution/edit_hangs_landscape.dart';
import 'package:app/widgets/execution/edit_hangs_portrait.dart';
import 'package:app/widgets/toast_provider.dart';
import 'package:flutter/cupertino.dart';

class EditHangsDialog extends StatefulWidget {
  EditHangsDialog(
      {Key key,
      @required this.hangs,
      @required this.handleLoggedEffectiveMetrics})
      : super(key: key);

  final List<Hang> hangs;
  final void Function(List<LoggedEffectiveMetrics> loggedEffectiveMetrics)
      handleLoggedEffectiveMetrics;

  @override
  _EditHangsDialogState createState() => _EditHangsDialogState();
}

class _EditHangsDialogState extends State<EditHangsDialog> {
  EditHangsDialogViewModel _viewModel;

  @override
  void initState() {
    _viewModel = EditHangsDialogViewModel(
        hangs: widget.hangs,
        handleLoggedEffectiveMetrics: widget.handleLoggedEffectiveMetrics);
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
                return EditHangsPortrait(
                  setSelectedHang: _viewModel.setSelectedHang,
                  selectedHang: _viewModel.selectedHang,
                  hangs: _viewModel.hangs,
                  handleScrollAttempt: _viewModel.handleScrollAttempt,
                  canScroll: _viewModel.canScroll,
                  handleDone: _viewModel.handleDone,
                  hangText: _viewModel.hangText,
                  setText: _viewModel.setText,
                  setAddedWeightInput: _viewModel.setAddedWeightInput,
                  setHangTimeInput: _viewModel.setHangTimeInput,
                );
              } else {
                return EditHangsLandScape(
                  setSelectedHang: _viewModel.setSelectedHang,
                  selectedHang: _viewModel.selectedHang,
                  hangs: _viewModel.hangs,
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
