import 'package:app/data/basic_boards.dart';
import 'package:app/models/models.dart';
import 'package:app/services/persistence.service.dart';
import 'package:rxdart/rxdart.dart';

class BoardsState {
  BoardsState._();
  static final BoardsState _boardsState = BoardsState._();
  factory BoardsState() => _boardsState;

  PersistenceService _persistenceService = PersistenceService();

  BehaviorSubject<Boards> _boards$;
  List<Board> get boardList => _boards$.value.boards.toList();
  Stream<List<Board>> get boardList$ =>
      _boards$.stream.map((Boards b) => b.boards.toList());
  Board get defaultBoard => _boards$.value.defaultBoard;
  Stream<Board> get defaultBoard$ =>
      _boards$.stream.map((Boards b) => b.defaultBoard);

  Future<void> init() async {
    final Boards _boards = await _getBoards();
    _boards$ = BehaviorSubject.seeded(_boards ?? basicBoards);
    return Future.value();
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
      ..addAll(boardList)
      ..add(board);
    _setAndSaveBoardList(_newBoardList);
  }

  dispose() {
    _boards$.close();
  }
}
