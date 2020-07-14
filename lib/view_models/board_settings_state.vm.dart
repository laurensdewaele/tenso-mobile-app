import 'package:flutter/cupertino.dart';
import 'package:tenso_app/models/models.dart';

class BoardSettingsViewModelState {
  final List<Board> boards;
  final Board defaultBoard;

  const BoardSettingsViewModelState({
    @required this.boards,
    @required this.defaultBoard,
  });

  BoardSettingsViewModelState copyWith({
    List<Board> boards,
    Board defaultBoard,
  }) {
    return new BoardSettingsViewModelState(
      boards: boards ?? this.boards,
      defaultBoard: defaultBoard ?? this.defaultBoard,
    );
  }
}
