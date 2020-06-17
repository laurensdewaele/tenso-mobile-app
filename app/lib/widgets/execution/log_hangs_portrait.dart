import 'package:app/styles/styles.dart' as styles;
import 'package:app/view_models/execution/log_hangs_dialog.vm.dart';
import 'package:app/widgets/board/board_with_grips.dart';
import 'package:app/widgets/button.dart';
import 'package:app/widgets/divider.dart';
import 'package:app/widgets/execution/log_hangs_cupertino_picker.dart';
import 'package:app/widgets/number_input_and_description.dart';
import 'package:flutter/cupertino.dart';

class LogHangsPortrait extends StatelessWidget {
  const LogHangsPortrait({
    @required this.hangText,
    @required this.selectedPastHang,
    @required this.setText,
    @required this.handleDone,
    @required this.setHangTimeInput,
    @required this.setAddedWeightInput,
    @required this.handleScrollAttempt,
    @required this.canScroll,
    @required this.pastHangs,
    @required this.setSelectedPastHang,
  });

  final String hangText;
  final PastHang selectedPastHang;
  final String setText;
  final VoidCallback handleDone;
  final void Function(String s) setHangTimeInput;
  final void Function(String s) setAddedWeightInput;

  final VoidCallback handleScrollAttempt;
  final bool canScroll;
  final List<PastHang> pastHangs;
  final Function(int index) setSelectedPastHang;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        hangText,
                        style: styles.Staatliches.xlBlack,
                      ),
                      if (selectedPastHang.totalSets > 1)
                        Text(
                          setText,
                          style: styles.Staatliches.xlBlack,
                        ),
                    ],
                  ),
                  Divider(height: styles.Measurements.l),
                  BoardWithGrips(
                    clipped: false,
                    key: ValueKey(
                        'log-hangs-dialog-board-${selectedPastHang.currentHang}'),
                    boardImageAssetWidth: selectedPastHang.imageAssetWidth,
                    boardImageAsset: selectedPastHang.imageAsset,
                    customBoardHoldImages:
                        selectedPastHang.customBoardHoldImages,
                    withFixedHeight: true,
                    handToBoardHeightRatio:
                        selectedPastHang.handToBoardHeightRatio,
                    boardAspectRatio: selectedPastHang.boardAspectRatio,
                    rightGripBoardHold: selectedPastHang.rightGripBoardHold,
                    leftGripBoardHold: selectedPastHang.leftGripBoardHold,
                    leftGrip: selectedPastHang.leftGrip,
                    rightGrip: selectedPastHang.rightGrip,
                  ),
                  NumberInputAndDescription<double>(
                    key: ValueKey(
                        'log-hangs-dialog-duration-input-${selectedPastHang.currentHang}'),
                    enabled: true,
                    description: 'effective hung seconds',
                    handleValueChanged: setHangTimeInput,
                    initialValue: selectedPastHang.effectiveDurationS,
                  ),
                  Divider(
                    height: styles.Measurements.m,
                  ),
                  NumberInputAndDescription<double>(
                    key: ValueKey(
                        'log-hangs-dialog-added-weight-input-${selectedPastHang.currentHang}'),
                    enabled: true,
                    description: '${selectedPastHang.weightUnit} added weight',
                    handleValueChanged: setAddedWeightInput,
                    initialValue: selectedPastHang.addedWeight,
                  ),
                ],
              ),
              Divider(
                height: styles.Measurements.l,
              ),
              Container(
                height: 1,
                width: double.infinity,
                decoration: BoxDecoration(color: styles.Colors.lighestGray),
              ),
              Expanded(
                child: LogHangsCupertinoPicker(
                  canScroll: canScroll,
                  handleScrollAttempt: handleScrollAttempt,
                  pastHangs: pastHangs,
                  selectedPastHang: selectedPastHang,
                  setSelectedPastHang: setSelectedPastHang,
                ),
              ),
              Container(
                height: 1,
                width: double.infinity,
                decoration: BoxDecoration(color: styles.Colors.lighestGray),
              ),
            ],
          ),
        ),
        Button(
          handleTap: handleDone,
          text: 'Done',
          small: true,
          displayBackground: false,
        )
      ],
    );
  }
}
