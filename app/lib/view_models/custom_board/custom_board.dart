import 'package:app/data/custom_board_hold_images.dart';
import 'package:app/models/custom_board_hold_image.dart';
import 'package:app/models/models.dart';
import 'package:app/services/error.dart';
import 'package:app/services/toast.dart';
import 'package:flutter/cupertino.dart';

class BoxState {
  final bool selected;
  final int index;
  final int row;
  final int column;

  const BoxState({
    @required this.selected,
    @required this.index,
    @required this.row,
    @required this.column,
  });

  BoxState copyWith({
    bool selected,
    int index,
    int row,
  }) {
    return new BoxState(
      selected: selected ?? this.selected,
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
  List<BoxState> get _selectedBoxes =>
      boxes.where((box) => box.selected == true).toList();
  bool get selectedBoxesIsTopRow => _selectedBoxes.first?.row == 1 || false;
  bool get selectedBoxesIsBottomRow => !selectedBoxesIsTopRow;

  List<CustomBoardHoldImage> _images;
  List<CustomBoardHoldImage> get images => _images;

  bool addHoldModalOpen;

  CustomBoardViewModel() {
    _toastService = ToastService();
    _resetBoxes();
    _images = [];
    addHoldModalOpen = false;
    notifyListeners();
  }

  void _resetBoxes() {
    _boxes = List.generate(4 * 4, (i) {
      final int _row = i ~/ 4 + 1;
      final int _column = _row == 1 ? i + 1 : i - (((_row - 1) * 4) - 1);
      return BoxState(index: i, selected: false, row: _row, column: _column);
    });
  }

  void handleBoxTap(BoxState boxState) {
    if (boxState.selected == false) {
      bool _isAdjacent =
          _isAdjacentSameRow(index: boxState.index, row: boxState.row);

      if (_isAdjacent == true) {
        _invertSelectedStateBox(boxState);
      } else {
        _toastService.add(ErrorMessages.customBoardNotAdjacent());
      }
    }

    if (boxState.selected == true) {
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

    if (_selectedBoxes.length == 0) return true;

    try {
      if (boxes[index - 1].row == row && boxes[index - 1].selected == true) {
        _isAdjacentSameRow = true;
      }
    } catch (_) {}

    try {
      if (boxes[index + 1].row == row && boxes[index + 1].selected == true) {
        _isAdjacentSameRow = true;
      }
    } catch (_) {}

    return _isAdjacentSameRow;
  }

  bool _isInCenterOfSelectedBoxes({int index, int row}) {
    bool _isInCenter = false;

    try {
      if (boxes[index - 1].row == row &&
          boxes[index - 1].selected == true &&
          boxes[index + 1].row == row &&
          boxes[index + 1].selected == true) {
        _isInCenter = true;
      }
    } catch (_) {}

    return _isInCenter;
  }

  void _determineModalState() {
    addHoldModalOpen = _selectedBoxes.length > 0;
  }

  void _invertSelectedStateBox(BoxState boxState) {
    final List<BoxState> _newBoxes = []..addAll(boxes);
    _newBoxes[boxState.index] = boxState.copyWith(selected: !boxState.selected);
    _boxes = _newBoxes;
    _determineModalState();
    notifyListeners();
  }

  CustomBoardHoldImage _getImage(HoldType type) {
    final _widthFactor = _selectedBoxes.length;
    final _row = _selectedBoxes.first.row;
    final _column = _selectedBoxes.first.column;
    return getCustomBoardHoldImage(
        row: _row, column: _column, widthFactor: _widthFactor, type: type);
  }

  void handlePinchBlockInput() {
    final CustomBoardHoldImage _image = _getImage(HoldType.pinchBlock);
    _resetBoxes();
    notifyListeners();
  }

  void handleJugInput() {
    final CustomBoardHoldImage _image = _getImage(HoldType.jug);
    _resetBoxes();
    notifyListeners();
  }

  void handleSloperInput({double degrees}) {
    final CustomBoardHoldImage _image = _getImage(HoldType.sloper);
    _resetBoxes();
    notifyListeners();
  }

  void handlePocketInput({double depth, int supportedFingers}) {
    final CustomBoardHoldImage _image = _getImage(HoldType.pocket);
    _resetBoxes();
    notifyListeners();
  }

  void handleEdgeInput({double depth}) {
    final CustomBoardHoldImage _image = _getImage(HoldType.edge);
    _resetBoxes();
    notifyListeners();
  }
}
