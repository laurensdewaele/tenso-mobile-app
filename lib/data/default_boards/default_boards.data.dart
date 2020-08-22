import 'package:tenso_app/data/default_boards/awesome_woodys_cliff_board_mini_back.dart';
import 'package:tenso_app/data/default_boards/awesome_woodys_cliff_board_mini_front.dart';
import 'package:tenso_app/data/default_boards/awesome_woodys_the_home_boy.dart';
import 'package:tenso_app/data/default_boards/beastmaker_1000.data.dart';
import 'package:tenso_app/data/default_boards/beastmaker_2000.data.dart';
import 'package:tenso_app/data/default_boards/grindstone_mk2.data.dart';
import 'package:tenso_app/data/default_boards/transgression.data.dart';
import 'package:tenso_app/models/models.dart';

final Boards defaultBoards = Boards((b) => b
  ..boards.addAll([
    beastmaker1000,
    beastmaker2000,
    grindstoneMk2,
    awesomeWoodysTheHomeBoy,
    awesomeWoodysCliffBoardMiniFront,
    awesomeWoodysCliffBoardMiniBack,
    transgression,
  ]));
