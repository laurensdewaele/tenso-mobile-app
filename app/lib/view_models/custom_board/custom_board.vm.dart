import 'dart:async';

import 'package:app/data/custom_board.data.dart';
import 'package:app/models/custom_board_hold_image.model.dart';
import 'package:app/models/models.dart';
import 'package:app/services/error.service.dart';
import 'package:app/services/toast.service.dart';
import 'package:built_collection/built_collection.dart';
import 'package:flutter/cupertino.dart';

enum BoxVisibility { selected, deselected, hidden }

class BoxState {
  final BoxVisibility visibility;
  final int index;
  final int row;
  final int column;

  const BoxState({
    @required this.visibility,
    @required this.index,
    @required this.row,
    @required this.column,
  });

  BoxState copyWith({
    BoxVisibility visibility,
    int index,
    int row,
    int column,
  }) {
    return new BoxState(
      visibility: visibility ?? this.visibility,
      index: index ?? this.index,
      row: row ?? this.row,
      column: column ?? this.column,
    );
  }
}

class CustomBoardViewModel extends ChangeNotifier {
  ToastService _toastService;

  List<BoxState> _boxes;
  List<BoxState> get boxes => _boxes;
  List<BoxState> get selectedBoxes =>
      boxes.where((box) => box.visibility == BoxVisibility.selected).toList();
  bool get selectedBoxesIsTopRow => selectedBoxes?.first?.row == 1 || false;

  CustomBoardHoldImage _selectedCustomBoardHoldImage;
  CustomBoardHoldImage get selectedCustomBoardHoldImage =>
      _selectedCustomBoardHoldImage;
  List<CustomBoardHoldImage> _customBoardHoldImages;
  List<CustomBoardHoldImage> get customBoardHoldImages =>
      _customBoardHoldImages;
  List<BoardHold> _boardHolds;
  List<BoardHold> get boardHolds => _boardHolds;
  BoardHold get boardHoldForSelectedImage => _getBoardHoldForSelectedImage();

  bool addHoldModalOpen;
  bool editDeleteModalOpen;
  StreamController<bool> _closeBottomMenuDrawer$ = StreamController<bool>();
  Stream<bool> get closeBottomMenuDrawer$ => _closeBottomMenuDrawer$.stream;

  CustomBoardViewModel() {
    _toastService = ToastService();
    _generateBoxes();
    _customBoardHoldImages = [];
    _boardHolds = [];
    addHoldModalOpen = false;
    editDeleteModalOpen = false;
    notifyListeners();
  }

  @override
  void dispose() {
    _closeBottomMenuDrawer$.close();
    super.dispose();
  }

  void _generateBoxes() {
    _boxes = List.generate(4 * 4, (i) {
      final int _row = i ~/ 4 + 1;
      final int _column = _row == 1 ? i + 1 : i - (((_row - 1) * 4) - 1);
      return BoxState(
          index: i,
          visibility: BoxVisibility.deselected,
          row: _row,
          column: _column);
    });
  }

  void handleBoxTap(BoxState boxState) {
    _selectedCustomBoardHoldImage = null;
    editDeleteModalOpen = false;
    _closeBottomMenuDrawer$.add(true);

    if (boxState.visibility == BoxVisibility.deselected) {
      bool _isAdjacent =
          _isAdjacentSameRow(index: boxState.index, row: boxState.row);

      if (_isAdjacent == true) {
        _invertSelectedStateBox(boxState);
      } else {
        _toastService.add(ErrorMessages.customBoardNotAdjacent());
      }
    }

    if (boxState.visibility == BoxVisibility.selected) {
      bool _isInCenter =
          _isInCenterOfSelectedBoxes(index: boxState.index, row: boxState.row);

      if (_isInCenter == false) {
        _invertSelectedStateBox(boxState);
      } else {
        _toastService.add(ErrorMessages.customBoardDeselect());
      }
    }
  }

  bool _isAdjacentSameRow({int index, int row}) {
    bool _isAdjacentSameRow = false;

    if (selectedBoxes.length == 0) return true;

    try {
      if (boxes[index - 1].row == row &&
          boxes[index - 1].visibility == BoxVisibility.selected) {
        _isAdjacentSameRow = true;
      }
    } catch (_) {}

    try {
      if (boxes[index + 1].row == row &&
          boxes[index + 1].visibility == BoxVisibility.selected) {
        _isAdjacentSameRow = true;
      }
    } catch (_) {}

    return _isAdjacentSameRow;
  }

  bool _isInCenterOfSelectedBoxes({int index, int row}) {
    bool _isInCenter = false;

    try {
      if (boxes[index - 1].row == row &&
          boxes[index - 1].visibility == BoxVisibility.selected &&
          boxes[index + 1].row == row &&
          boxes[index + 1].visibility == BoxVisibility.selected) {
        _isInCenter = true;
      }
    } catch (_) {}

    return _isInCenter;
  }

  void _invertSelectedStateBox(BoxState boxState) {
    final List<BoxState> _newBoxes = []..addAll(boxes);
    _newBoxes[boxState.index] = boxState.copyWith(
        visibility: boxState.visibility == BoxVisibility.selected
            ? BoxVisibility.deselected
            : BoxVisibility.selected);
    _boxes = _newBoxes;
    addHoldModalOpen = selectedBoxes.length > 0;
    notifyListeners();
  }

  void _addCustomBoardHoldsAndImage(
      {@required HoldType type,
      double depth,
      int supportedFingers,
      double sloperDegrees}) {
    final _widthFactor = selectedBoxes.length;
    final _row = selectedBoxes.first.row;
    final _column = selectedBoxes.first.column;
    final _positions = selectedBoxes.map((box) => box.index + 1).toList();
    final _CustomBoardHolds _customBoardHolds = _getCustomBoardHolds(
        row: _row,
        column: _column,
        widthFactor: _widthFactor,
        type: type,
        depth: depth,
        supportedFingers: supportedFingers,
        sloperDegrees: sloperDegrees,
        positions: _positions);
    _customBoardHoldImages.add(_customBoardHolds.customBoardHoldImage);
    _boardHolds.addAll(_customBoardHolds.boardHolds);
  }

  void _hideSelectedBoxesCloseModalAndNotify() {
    _boxes = _boxes.map((BoxState boxState) {
      if (boxState.visibility == BoxVisibility.selected) {
        return boxState.copyWith(visibility: BoxVisibility.hidden);
      } else {
        return boxState;
      }
    }).toList();
    addHoldModalOpen = false;
    notifyListeners();
  }

  void _deselectBoxes() {
    _boxes = _boxes.map((BoxState boxState) {
      if (boxState.visibility == BoxVisibility.selected) {
        return boxState.copyWith(visibility: BoxVisibility.deselected);
      } else {
        return boxState;
      }
    }).toList();
  }

  void handlePinchBlockInput() {
    _addCustomBoardHoldsAndImage(type: HoldType.pinchBlock);
    _hideSelectedBoxesCloseModalAndNotify();
  }

  void handleJugInput() {
    _addCustomBoardHoldsAndImage(type: HoldType.jug);
    _hideSelectedBoxesCloseModalAndNotify();
  }

  void handleSloperInput({double sloperDegrees}) {
    _addCustomBoardHoldsAndImage(
        type: HoldType.sloper, sloperDegrees: sloperDegrees);
    _hideSelectedBoxesCloseModalAndNotify();
  }

  void handlePocketInput({double depth, int supportedFingers}) {
    _addCustomBoardHoldsAndImage(
        type: HoldType.pocket,
        depth: depth,
        supportedFingers: supportedFingers);
    _hideSelectedBoxesCloseModalAndNotify();
  }

  void handleEdgeInput({double depth}) {
    _addCustomBoardHoldsAndImage(type: HoldType.edge, depth: depth);
    _hideSelectedBoxesCloseModalAndNotify();
  }

  bool checkBoardHoldAmount() {
    if (_boardHolds.length >= 2) {
      return true;
    } else {
      ToastService().add(ErrorMessages.minimumTwoBoardHolds());
      return false;
    }
  }

  void handleCustomBoardHoldImageTap(
      CustomBoardHoldImage customBoardHoldImage) {
    if (_selectedCustomBoardHoldImage == customBoardHoldImage) {
      _selectedCustomBoardHoldImage = null;
      editDeleteModalOpen = false;
    } else {
      _selectedCustomBoardHoldImage = customBoardHoldImage;
      _deselectBoxes();
      editDeleteModalOpen = true;
    }
    _closeBottomMenuDrawer$.add(true);
    addHoldModalOpen = false;
    notifyListeners();
  }

  BoardHold _getBoardHoldForSelectedImage() {
    if (_boardHolds != null && _selectedCustomBoardHoldImage != null) {
      return boardHolds.firstWhere(
          (boardHold) =>
              boardHold.position == selectedCustomBoardHoldImage.positions[0],
          orElse: () => null);
    } else {
      return null;
    }
  }

  void deleteSelectedCustomBoardHoldImage() {
    _boardHolds = boardHolds
        .where((boardHold) => !selectedCustomBoardHoldImage.positions
            .contains(boardHold.position))
        .toList();
    _customBoardHoldImages = customBoardHoldImages
        .where((customBoardHoldImage) =>
            customBoardHoldImage != selectedCustomBoardHoldImage)
        .toList();
    _boxes = boxes.map((box) {
      if (selectedCustomBoardHoldImage.positions.contains(box.index + 1)) {
        return box.copyWith(visibility: BoxVisibility.deselected);
      }
      return box;
    }).toList();
    _selectedCustomBoardHoldImage = null;
    editDeleteModalOpen = false;
    notifyListeners();
  }
}

class _CustomBoardHolds {
  const _CustomBoardHolds({
    @required this.customBoardHoldImage,
    @required this.boardHolds,
  });

  final CustomBoardHoldImage customBoardHoldImage;
  final List<BoardHold> boardHolds;
}

_CustomBoardHolds _getCustomBoardHolds({
  @required int row,
  @required int column,
  @required int widthFactor,
  @required HoldType type,
  @required List<int> positions,
  double sloperDegrees,
  double depth,
  int supportedFingers,
}) {
  CustomBoardHoldImage _customBoardHoldImage;
  List<BoardHold> _boardHolds = [];

  switch (type) {
    case HoldType.pinchBlock:
      _customBoardHoldImage = CustomBoardHoldImage((b) => b
        ..positions = ListBuilder<int>(positions)
        ..holdType = HoldType.pinchBlock
        ..scale = kPinchBlockJugScale
        ..heightPercent = kPinchBlockJugHeightPercent
        ..widthPercent = kWidthPercents[widthFactor]
        ..leftPercent = kLeftPercents[column]
        ..topPercent = kPinchBlockJugTopPercent
        ..imageAsset =
            'assets/images/custom_board/pinch_block_$widthFactor.png');
      List.generate(widthFactor, (i) {
        _boardHolds.add(BoardHold((b) => b
          ..position = positions[i]
          ..holdType = HoldType.pinchBlock
          ..topPercent = kPinchBlockJugTopPercent - kOnePixelHeightPercent * 2
          ..leftPercent = kLeftPercents[column + i] - kOnePixelWidthPercent
          ..widthPercent = kWidthPercents[1] + kOnePixelWidthPercent * 2
          ..heightPercent = kPinchBlockJugHeightPercent + kOnePixelHeightPercent
          ..anchorLeftPercent =
              kLeftPercents[column + i] + kWidthPercents[1] / 2
          ..anchorTopPercent = kPinchBlockJugTopPercent));
      });
      break;
    case HoldType.jug:
      _customBoardHoldImage = CustomBoardHoldImage((b) => b
        ..positions = ListBuilder<int>(positions)
        ..holdType = HoldType.jug
        ..scale = kPinchBlockJugScale
        ..heightPercent = kPinchBlockJugHeightPercent
        ..widthPercent = kWidthPercents[widthFactor]
        ..leftPercent = kLeftPercents[column]
        ..topPercent = kPinchBlockJugTopPercent
        ..imageAsset = 'assets/images/custom_board/jug_$widthFactor.png');
      List.generate(widthFactor, (i) {
        _boardHolds.add(BoardHold((b) => b
          ..position = positions[i]
          ..holdType = HoldType.jug
          ..topPercent = kPinchBlockJugTopPercent - kOnePixelHeightPercent * 2
          ..leftPercent = kLeftPercents[column + i] - kOnePixelWidthPercent
          ..widthPercent = kWidthPercents[1] + kOnePixelWidthPercent * 2
          ..heightPercent = kPinchBlockJugHeightPercent + kOnePixelHeightPercent
          ..anchorLeftPercent =
              kLeftPercents[column + i] + kWidthPercents[1] / 2
          ..anchorTopPercent = kPinchBlockJugTopPercent));
      });
      break;
    case HoldType.sloper:
      _customBoardHoldImage = CustomBoardHoldImage((b) => b
        ..positions = ListBuilder<int>(positions)
        ..holdType = HoldType.sloper
        ..scale = 1
        ..heightPercent = kSloperHeightPercent
        ..widthPercent = kWidthPercents[widthFactor]
        ..leftPercent = kLeftPercents[column]
        ..topPercent = 0
        ..imageAsset = 'assets/images/custom_board/sloper_$widthFactor.png');
      List.generate(widthFactor, (i) {
        _boardHolds.add(BoardHold((b) => b
          ..position = positions[i]
          ..holdType = HoldType.sloper
          ..topPercent = 0 - kOnePixelHeightPercent
          ..leftPercent = kLeftPercents[column + i] - kOnePixelWidthPercent
          ..widthPercent = kWidthPercents[1] + kOnePixelWidthPercent * 2
          ..heightPercent = kSloperHeightPercent + kOnePixelHeightPercent * 2
          ..sloperDegrees = sloperDegrees
          ..anchorLeftPercent =
              kLeftPercents[column + i] + kWidthPercents[1] / 2
          ..anchorTopPercent = kSloperHeightPercent / 3));
      });
      break;
    case HoldType.pocket:
      _customBoardHoldImage = CustomBoardHoldImage((b) => b
        ..positions = ListBuilder<int>(positions)
        ..holdType = HoldType.pocket
        ..scale = 1
        ..heightPercent = kPocketHeightPercent
        ..widthPercent = widthFactor == 1
            ? kWidthPercentPocketFingers[supportedFingers]
            : kWidthPercents[widthFactor]
        ..leftPercent = widthFactor == 1
            ? kLeftPercents[column] +
                ((kWidthPercents[1] -
                        kWidthPercentPocketFingers[supportedFingers]) /
                    2)
            : kLeftPercents[column]
        ..topPercent = kTopPercents[row] - kPocketEdgeDifference
        ..imageAsset = widthFactor == 1
            ? 'assets/images/custom_board/pocket_1_${supportedFingers}f.png'
            : 'assets/images/custom_board/pocket_$widthFactor.png');
      List.generate(widthFactor, (i) {
        _boardHolds.add(BoardHold((b) => b
          ..position = positions[i]
          ..holdType = HoldType.pocket
          ..topPercent =
              kTopPercents[row] - kPocketEdgeDifference - kOnePixelHeightPercent
          ..leftPercent = kLeftPercents[column + i] - kOnePixelWidthPercent
          ..widthPercent = kWidthPercents[1] + kOnePixelWidthPercent * 2
          ..heightPercent = kPocketHeightPercent + kOnePixelHeightPercent * 2
          ..depth = depth
          ..supportedFingers = supportedFingers
          ..anchorLeftPercent =
              kLeftPercents[column + i] + kWidthPercents[1] / 2
          ..anchorTopPercent = kTopPercents[row] -
              kPocketEdgeDifference +
              kPocketHeightPercent));
      });
      break;
    case HoldType.edge:
      _customBoardHoldImage = CustomBoardHoldImage((b) => b
        ..positions = ListBuilder<int>(positions)
        ..holdType = HoldType.edge
        ..scale = kEdgeScale
        ..heightPercent = kEdgeHeightPercent
        ..widthPercent = kWidthPercents[widthFactor]
        ..leftPercent = kLeftPercents[column]
        ..topPercent = kTopPercents[row]
        ..imageAsset = 'assets/images/custom_board/edge_$widthFactor.png');
      List.generate(widthFactor, (i) {
        _boardHolds.add(BoardHold((b) => b
          ..position = positions[i]
          ..holdType = HoldType.edge
          ..topPercent =
              kTopPercents[row] - kPocketEdgeDifference - kOnePixelHeightPercent
          ..leftPercent = kLeftPercents[column + i] - kOnePixelWidthPercent
          ..widthPercent = kWidthPercents[1] + kOnePixelWidthPercent * 2
          ..heightPercent = kPocketHeightPercent + kOnePixelHeightPercent * 2
          ..depth = depth
          ..anchorLeftPercent =
              kLeftPercents[column + i] + kWidthPercents[1] / 2
          ..anchorTopPercent = kTopPercents[row]));
      });
      break;
  }

  return _CustomBoardHolds(
      customBoardHoldImage: _customBoardHoldImage, boardHolds: _boardHolds);
}
