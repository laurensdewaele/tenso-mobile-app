import 'package:app/styles/styles.dart' as styles;
import 'package:app/view_models/execution/edit_hangs_dialog.vm.dart';
import 'package:app/widgets/board/board_with_grips.dart';
import 'package:app/widgets/button.dart';
import 'package:app/widgets/divider.dart';
import 'package:app/widgets/number_input_and_description.dart';
import 'package:app/widgets/toast_provider.dart';
import 'package:flutter/cupertino.dart';

class EditHangsDialog extends StatefulWidget {
  EditHangsDialog(
      {Key key,
      @required this.editHangInfoList,
      @required this.nextHang,
      @required this.totalHangs,
      @required this.handleEditedHangs})
      : super(key: key);

  final List<EditHangInfo> editHangInfoList;
  final int nextHang;
  final int totalHangs;
  final void Function(List<EditedHang> editHangs) handleEditedHangs;

  @override
  _EditHangsDialogState createState() => _EditHangsDialogState();
}

class _EditHangsDialogState extends State<EditHangsDialog> {
  EditHangsDialogViewModel _viewModel;

  @override
  void initState() {
    _viewModel = EditHangsDialogViewModel(
        editHangInfoList: widget.editHangInfoList,
        nextHang: widget.nextHang,
        totalHangs: widget.totalHangs,
        handleEditedHangs: widget.handleEditedHangs);
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
    final String _hangText =
        'hang ${_viewModel.selectedHangInfo.currentHangPerSet}/${_viewModel.selectedHangInfo.totalHangsPerSet}';
    final String _setText =
        'set ${_viewModel.selectedHangInfo.currentSet}/${_viewModel.selectedHangInfo.totalSets}';

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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    _hangText,
                                    style: styles.Staatliches.xlBlack,
                                  ),
                                  if (_viewModel.selectedHangInfo.totalSets > 1)
                                    Text(
                                      _setText,
                                      style: styles.Staatliches.xlBlack,
                                    ),
                                ],
                              ),
                              Divider(height: styles.Measurements.l),
                              BoardWithGrips(
                                key: ValueKey(
                                    'edit-hangs-dialog-board-${_viewModel.selectedHang}'),
                                boardImageAssetWidth: _viewModel
                                    .selectedHangInfo.board.imageAssetWidth,
                                boardImageAsset: _viewModel
                                    .selectedHangInfo.board.imageAsset,
                                customBoardHoldImages: _viewModel
                                    .selectedHangInfo
                                    .board
                                    .customBoardHoldImages
                                    ?.toList(),
                                withFixedHeight: true,
                                handToBoardHeightRatio: _viewModel
                                    .selectedHangInfo
                                    .board
                                    .handToBoardHeightRatio,
                                boardAspectRatio: _viewModel
                                    .selectedHangInfo.board.aspectRatio,
                                rightGripBoardHold: _viewModel
                                    .selectedHangInfo.hold.rightGripBoardHold,
                                leftGripBoardHold: _viewModel
                                    .selectedHangInfo.hold.leftGripBoardHold,
                                leftGrip:
                                    _viewModel.selectedHangInfo.hold.leftGrip,
                                rightGrip:
                                    _viewModel.selectedHangInfo.hold.rightGrip,
                              ),
                              NumberInputAndDescription<int>(
                                key: ValueKey(
                                    'edit-hangs-dialog-duration-input-${_viewModel.selectedHang}'),
                                enabled: true,
                                description: _viewModel.isPastHang
                                    ? 'effective hung seconds'
                                    : 'hang time seconds',
                                handleValueChanged: _viewModel.setHangTime,
                                initialValue:
                                    _viewModel.selectedHangInfo.duration,
                              ),
                              Divider(
                                height: styles.Measurements.m,
                              ),
                              NumberInputAndDescription<double>(
                                key: ValueKey(
                                    'edit-hangs-dialog-added-weight-input-${_viewModel.selectedHang}'),
                                enabled: true,
                                description:
                                    '${_viewModel.selectedHangInfo.weightSystem.unit} added weight',
                                handleValueChanged: _viewModel.setAddedWeight,
                                initialValue: _viewModel
                                    .selectedHangInfo.hold.addedWeight,
                              ),
                            ],
                          ),
                          Divider(
                            height: styles.Measurements.l,
                          ),
                          Container(
                            height: 1,
                            width: double.infinity,
                            decoration:
                                BoxDecoration(color: styles.Colors.lighestGray),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                print('tapped');
                              },
                              onVerticalDragEnd: (DragEndDetails details) {
                                print('scrolling');
                              },
                              child: AbsorbPointer(
                                absorbing: false,
                                child: CupertinoPicker(
                                  scrollController: FixedExtentScrollController(
                                      initialItem: _viewModel.editHangInfoList
                                          .indexOf(
                                              _viewModel.selectedHangInfo)),
                                  useMagnifier: false,
                                  magnification: 1,
                                  backgroundColor: styles.Colors.bgWhite,
                                  onSelectedItemChanged:
                                      _viewModel.setSelectedHang,
                                  itemExtent: 40,
                                  children: <Widget>[
                                    ..._viewModel.editHangInfoList.map(
                                        (EditHangInfo editHangInfo) => HangRow(
                                              currentHangPerSet: editHangInfo
                                                  .currentHangPerSet,
                                              totalHangsPerSet:
                                                  editHangInfo.totalHangsPerSet,
                                              currentSet:
                                                  editHangInfo.currentSet,
                                              totalSets: editHangInfo.totalSets,
                                              isPastHang: _viewModel.nextHang >
                                                  editHangInfo.currentHang,
                                              isSelectedHang:
                                                  _viewModel.nextHang ==
                                                      editHangInfo.currentHang,
                                            ))
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: 1,
                            width: double.infinity,
                            decoration:
                                BoxDecoration(color: styles.Colors.lighestGray),
                          ),
                        ],
                      ),
                    ),
                    Button(
                      handleTap: _viewModel.handleDone,
                      text: 'Done',
                      small: true,
                      displayBackground: false,
                    )
                  ],
                );
              } else {
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
                                  LayoutBuilder(builder: (BuildContext context,
                                      BoxConstraints constraints) {
                                    return Container(
                                      width: constraints.maxWidth / 1.5,
                                      child: BoardWithGrips(
                                        key: ValueKey(
                                            'edit-hangs-dialog-board-${_viewModel.selectedHang}'),
                                        boardImageAssetWidth: _viewModel
                                            .selectedHangInfo
                                            .board
                                            .imageAssetWidth,
                                        boardImageAsset: _viewModel
                                            .selectedHangInfo.board.imageAsset,
                                        customBoardHoldImages: _viewModel
                                            .selectedHangInfo
                                            .board
                                            .customBoardHoldImages
                                            ?.toList(),
                                        withFixedHeight: true,
                                        handToBoardHeightRatio: _viewModel
                                            .selectedHangInfo
                                            .board
                                            .handToBoardHeightRatio,
                                        boardAspectRatio: _viewModel
                                            .selectedHangInfo.board.aspectRatio,
                                        rightGripBoardHold: _viewModel
                                            .selectedHangInfo
                                            .hold
                                            .rightGripBoardHold,
                                        leftGripBoardHold: _viewModel
                                            .selectedHangInfo
                                            .hold
                                            .leftGripBoardHold,
                                        leftGrip: _viewModel
                                            .selectedHangInfo.hold.leftGrip,
                                        rightGrip: _viewModel
                                            .selectedHangInfo.hold.rightGrip,
                                      ),
                                    );
                                  }),
                                  NumberInputAndDescription<int>(
                                    key: ValueKey(
                                        'edit-hangs-dialog-duration-input-landscape-${_viewModel.selectedHang}'),
                                    enabled: true,
                                    description: _viewModel.isPastHang
                                        ? 'effective hung seconds'
                                        : 'hang time seconds',
                                    handleValueChanged: _viewModel.setHangTime,
                                    initialValue:
                                        _viewModel.selectedHangInfo.duration,
                                  ),
                                  Divider(
                                    height: styles.Measurements.m,
                                  ),
                                  NumberInputAndDescription<double>(
                                    key: ValueKey(
                                        'edit-hangs-dialog-added-weight-input-landscape-${_viewModel.selectedHang}'),
                                    enabled: true,
                                    description:
                                        '${_viewModel.selectedHangInfo.weightSystem.unit} added weight',
                                    handleValueChanged:
                                        _viewModel.setAddedWeight,
                                    initialValue: _viewModel
                                        .selectedHangInfo.hold.addedWeight,
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
                                  child: CupertinoPicker(
                                    scrollController:
                                        FixedExtentScrollController(
                                            initialItem: _viewModel
                                                .editHangInfoList
                                                .indexOf(_viewModel
                                                    .selectedHangInfo)),
                                    useMagnifier: false,
                                    magnification: 1,
                                    backgroundColor: styles.Colors.bgWhite,
                                    onSelectedItemChanged:
                                        _viewModel.setSelectedHang,
                                    itemExtent: 40,
                                    children: <Widget>[
                                      ..._viewModel.editHangInfoList.map(
                                          (EditHangInfo editHangInfo) =>
                                              HangRow(
                                                currentHangPerSet: editHangInfo
                                                    .currentHangPerSet,
                                                totalHangsPerSet: editHangInfo
                                                    .totalHangsPerSet,
                                                currentSet:
                                                    editHangInfo.currentSet,
                                                totalSets:
                                                    editHangInfo.totalSets,
                                                isPastHang: _viewModel
                                                        .nextHang >
                                                    editHangInfo.currentHang,
                                                isSelectedHang: _viewModel
                                                        .nextHang ==
                                                    editHangInfo.currentHang,
                                              ))
                                    ],
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
                          handleTap: _viewModel.handleDone,
                          text: 'Done',
                          small: true,
                          displayBackground: false,
                        ),
                      ],
                    )
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }
}

class HangRow extends StatelessWidget {
  const HangRow({
    @required this.isSelectedHang,
    @required this.isPastHang,
    @required this.currentSet,
    @required this.totalSets,
    @required this.currentHangPerSet,
    @required this.totalHangsPerSet,
  });

  final bool isSelectedHang;
  final bool isPastHang;
  final int currentSet;
  final int totalSets;
  final int totalHangsPerSet;
  final int currentHangPerSet;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            children: <Widget>[
              if (isPastHang == false)
                _Circle(
                  active: isSelectedHang,
                ),
              if (isPastHang == true) _CompletedCircle(active: isSelectedHang),
              Divider(
                width: styles.Measurements.xs,
              ),
              Text('Hang', style: styles.Staatliches.sBlack),
              Divider(
                width: styles.Measurements.xs,
              ),
              Column(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Divider(
                    height: 5,
                  ),
                  Text('$currentHangPerSet/$totalHangsPerSet',
                      style: styles.Lato.xsGray),
                ],
              ),
            ],
          ),
          Divider(
            width: styles.Measurements.m,
          ),
          if (totalSets > 1)
            Row(
              children: <Widget>[
                Text('set', style: styles.Staatliches.sBlack),
                Divider(
                  width: styles.Measurements.xs,
                ),
                Column(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Divider(
                      height: 5,
                    ),
                    Text('$currentSet/$totalSets', style: styles.Lato.xsGray),
                  ],
                ),
              ],
            )
        ],
      ),
    );
  }
}

class _Circle extends StatelessWidget {
  const _Circle({
    @required this.active,
  });

  final bool active;

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: active ? 1.5 : 1,
      child: Container(
        height: styles.Measurements.xs,
        width: styles.Measurements.xs,
        decoration: BoxDecoration(
            border: Border.all(width: 1, color: styles.Colors.primary),
            borderRadius: BorderRadius.all(Radius.circular(10))),
      ),
    );
  }
}

class _CompletedCircle extends StatelessWidget {
  const _CompletedCircle({
    @required this.active,
  });

  final bool active;

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: active ? 1.5 : 1,
      child: Container(
        height: styles.Measurements.xs,
        width: styles.Measurements.xs,
        decoration:
            BoxDecoration(color: styles.Colors.primary, shape: BoxShape.circle),
      ),
    );
  }
}
