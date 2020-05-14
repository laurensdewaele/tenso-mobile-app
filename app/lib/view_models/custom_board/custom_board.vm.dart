import 'package:app/data/custom_board.data.dart';
import 'package:app/models/custom_board_hold_image.model.dart';
import 'package:app/models/models.dart';
import 'package:app/services/error.service.dart';
import 'package:app/services/toast.service.dart';
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
  CustomBoardBuilder _customBoardBuilder;

  List<BoxState> _boxes;
  List<BoxState> get boxes => _boxes;
  List<BoxState> get selectedBoxes =>
      boxes.where((box) => box.visibility == BoxVisibility.selected).toList();
  bool get selectedBoxesIsTopRow => selectedBoxes?.first?.row == 1 || false;

  CustomBoardHoldImage _selectedBoardHoldImage;
  CustomBoardHoldImage get selectedBoardHoldImage => _selectedBoardHoldImage;
  List<CustomBoardHoldImage> _customBoardHoldImages;
  List<CustomBoardHoldImage> get customBoardHoldImages =>
      _customBoardHoldImages;
  List<BoardHold> _boardHolds;
  List<BoardHold> get boardHolds => _boardHolds;

  bool addHoldModalOpen;
  bool editDeleteModalOpen;

  CustomBoardViewModel() {
    _toastService = ToastService();
    _customBoardBuilder = CustomBoardBuilder();
    _generateBoxes();
    _customBoardHoldImages = [];
    _boardHolds = [];
    addHoldModalOpen = false;
    editDeleteModalOpen = false;
    notifyListeners();
  }

  void setAddHoldModalOpen(bool open) {
    addHoldModalOpen = open;
    notifyListeners();
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
    _customBoardBuilder.addBoardHoldAndImage(
        row: _row,
        column: _column,
        widthFactor: _widthFactor,
        type: type,
        depth: depth,
        supportedFingers: supportedFingers,
        sloperDegrees: sloperDegrees,
        positions: _positions);
    _customBoardHoldImages = _customBoardBuilder.customBoardHoldImages;
    _boardHolds = _customBoardBuilder.boardHolds;
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
    if (_selectedBoardHoldImage == customBoardHoldImage) {
      _selectedBoardHoldImage = null;
      editDeleteModalOpen = false;
    } else {
      _selectedBoardHoldImage = customBoardHoldImage;
      editDeleteModalOpen = true;
    }
    notifyListeners();
  }
}
