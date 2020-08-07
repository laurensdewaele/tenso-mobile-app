import 'package:rxdart/rxdart.dart';
import 'package:tenso_app/data/default_boards.data.dart';
import 'package:tenso_app/models/models.dart';
import 'package:tenso_app/services/persistence.service.dart';

class BoardsState {
  BoardsState._();
  static final BoardsState _boardsState = BoardsState._();
  factory BoardsState() => _boardsState;

  PersistenceService _persistenceService = PersistenceService();

  BehaviorSubject<Boards> _boards$;
  Stream<Boards> get boards$ => _boards$.stream;
  Boards get boards => _boards$.value;
  List<Board> get boardsList => _boards$.value.boards.toList();

  Future<void> init() async {
    final Boards _persistedBoards = await _getBoards();
    _boards$ = BehaviorSubject.seeded(_addDefaultBoards(_persistedBoards));
    return Future.value();
  }

  Boards _addDefaultBoards(Boards _persistedBoards) {
    if (_persistedBoards == null) {
      return defaultBoards;
    }

    final List<Board> _persistedBoardsList = _persistedBoards.boards.toList();
    final List<Board> _defaultBoardsList = defaultBoards.boards.toList();
    final List<String> _defaultBoardsIDs = _defaultBoardsList
        .map((Board _defaultBoard) => _defaultBoard.id)
        .toList();

    _persistedBoardsList.removeWhere((Board _persistedBoard) =>
        _defaultBoardsIDs.contains(_persistedBoard.id));
    _persistedBoardsList.addAll(_defaultBoardsList);

    return Boards((b) => b.boards.addAll(_persistedBoardsList));
  }

  Future<Boards> _getBoards() async {
    final Boards _boards = await _persistenceService.getBoards();
    return _boards;
  }

  void _saveBoards(Boards boards) {
    _persistenceService.saveBoards(boards);
  }

  void _setAndSaveBoardList(List<Board> newBoardList) {
    final Boards _newBoards =
        _boards$.value.rebuild((b) => b..boards.replace(newBoardList));
    _boards$.add(_newBoards);
    _saveBoards(_newBoards);
  }

  void addBoard(Board board) {
    final List<Board> _newBoardList = []
      ..addAll(boardsList)
      ..add(board);
    _setAndSaveBoardList(_newBoardList);
  }

  void editBoard({String boardId, Board updatedBoard}) {
    final int _boardIndex =
        boardsList.indexWhere((Board board) => board.id == boardId);
    final List<Board> _newBoardList = []..addAll(boardsList);
    _newBoardList[_boardIndex] = updatedBoard;
    _setAndSaveBoardList(_newBoardList);
  }

  void deleteBoard(Board board) {
    final List<Board> _newBoardList = []
      ..addAll(boardsList.where((Board b) => b.id != board.id));
    _setAndSaveBoardList(_newBoardList);
  }

  dispose() {
    _boards$.close();
  }
}
