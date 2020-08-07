import 'package:tenso_app/data/default_boards/beastmaker_1000.data.dart';
import 'package:tenso_app/data/default_boards/beastmaker_2000.data.dart';
import 'package:tenso_app/models/models.dart';

final Boards defaultBoards =
    Boards((b) => b..boards.addAll([beastmaker1000, beastmaker2000]));
