import 'package:flutter/cupertino.dart';

import 'package:app/services/error.dart';
import 'package:app/services/toast.dart';

class BoxState {
  final bool selected;
  final int index;
  final int row;

  const BoxState({
    @required this.selected,
    @required this.index,
    @required this.row,
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
    );
  }
}

class CustomBoardViewModel extends ChangeNotifier {
  List<BoxState> boxes;
  List<BoxState> get selectedBoxes =>
      boxes.where((box) => box.selected == true).toList();
  ToastService _toastService;

  bool modalOpen;

  CustomBoardViewModel() {
    _toastService = ToastService();
    boxes = List.generate(
        4 * 4, (i) => BoxState(index: i, selected: false, row: i ~/ 4));
    modalOpen = false;
    notifyListeners();
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

    if (selectedBoxes.length == 0) return true;

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
    modalOpen = selectedBoxes.length > 0;
  }

  void _invertSelectedStateBox(BoxState boxState) {
    final List<BoxState> _newBoxes = []..addAll(boxes);
    _newBoxes[boxState.index] = boxState.copyWith(selected: !boxState.selected);
    boxes = _newBoxes;
    _determineModalState();
    notifyListeners();
  }
}
