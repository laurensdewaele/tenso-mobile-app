import 'package:app/styles/styles.dart' as styles;
import 'package:app/view_models/execution/log_metrics_dialog.vm.dart';
import 'package:app/widgets/board/board_with_grips.dart';
import 'package:app/widgets/button.dart';
import 'package:app/widgets/divider.dart';
import 'package:app/widgets/execution/log_metrics_cupertino_picker.dart';
import 'package:app/widgets/number_input_and_description.dart';
import 'package:flutter/cupertino.dart';

class LogMetricsLandscape extends StatelessWidget {
  const LogMetricsLandscape({
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
      children: <Widget>[
        Expanded(
          child: Row(
            children: <Widget>[
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      LayoutBuilder(builder:
                          (BuildContext context, BoxConstraints constraints) {
                        return Container(
                          width: constraints.maxWidth / 1.5,
                          child: BoardWithGrips(
                            key: ValueKey(
                                'edit-hangs-dialog-board-${selectedPastHang.currentHang}'),
                            boardImageAssetWidth:
                                selectedPastHang.imageAssetWidth,
                            boardImageAsset: selectedPastHang.imageAsset,
                            customBoardHoldImages:
                                selectedPastHang.customBoardHoldImages,
                            withFixedHeight: true,
                            handToBoardHeightRatio:
                                selectedPastHang.handToBoardHeightRatio,
                            boardAspectRatio: selectedPastHang.boardAspectRatio,
                            rightGripBoardHold:
                                selectedPastHang.rightGripBoardHold,
                            leftGripBoardHold:
                                selectedPastHang.leftGripBoardHold,
                            leftGrip: selectedPastHang.leftGrip,
                            rightGrip: selectedPastHang.rightGrip,
                          ),
                        );
                      }),
                      NumberInputAndDescription<int>(
                        key: ValueKey(
                            'edit-hangs-dialog-duration-input-landscape-${selectedPastHang.currentHang}'),
                        enabled: true,
                        description: 'effective hung seconds',
                        handleValueChanged: setHangTimeInput,
                        initialValue: selectedPastHang.duration,
                      ),
                      Divider(
                        height: styles.Measurements.m,
                      ),
                      NumberInputAndDescription<double>(
                        key: ValueKey(
                            'edit-hangs-dialog-added-weight-input-landscape-${selectedPastHang.currentHang}'),
                        enabled: true,
                        description:
                            '${selectedPastHang.weightUnit} added weight',
                        handleValueChanged: setAddedWeightInput,
                        initialValue: selectedPastHang.addedWeight,
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: LogMetricsCupertinoPicker(
                        canScroll: canScroll,
                        handleScrollAttempt: handleScrollAttempt,
                        pastHangs: pastHangs,
                        selectedPastHang: selectedPastHang,
                        setSelectedPastHang: setSelectedPastHang,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Button(
              width: 150,
              handleTap: handleDone,
              text: 'Done',
              small: true,
              displayBackground: false,
            ),
          ],
        )
      ],
    );
  }
}
