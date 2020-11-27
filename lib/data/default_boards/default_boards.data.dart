import 'package:tenso_app/data/default_boards/awesome_woodys_cliff_board_mini_back.data.dart';
import 'package:tenso_app/data/default_boards/awesome_woodys_cliff_board_mini_front.data.dart';
import 'package:tenso_app/data/default_boards/awesome_woodys_the_home_boy.data.dart';
import 'package:tenso_app/data/default_boards/beastmaker_1000.data.dart';
import 'package:tenso_app/data/default_boards/beastmaker_2000.data.dart';
import 'package:tenso_app/data/default_boards/defy_the_crux_the_log.data.dart';
import 'package:tenso_app/data/default_boards/grindstone_mk1.data.dart';
import 'package:tenso_app/data/default_boards/grindstone_mk2.data.dart';
import 'package:tenso_app/data/default_boards/metolius_simulator_3D.data.dart';
import 'package:tenso_app/data/default_boards/metolius_wood_grips_2_compact.data.dart';
import 'package:tenso_app/data/default_boards/trango_rock_prodigy_training_center.data.dart';
import 'package:tenso_app/data/default_boards/transgression.data.dart';
import 'package:tenso_app/models/models.dart';

final Boards defaultBoards = Boards((b) => b
  ..boards.addAll([
    beastmaker1000,
    beastmaker2000,
    grindstoneMk1,
    grindstoneMk2,
    awesomeWoodysTheHomeBoy,
    awesomeWoodysCliffBoardMiniFront,
    awesomeWoodysCliffBoardMiniBack,
    transgression,
    defyTheCruxTheLog,
    metoliusSimulator3D,
    metoliusWoodGrips2Compact,
    trangoRockProdigyTrainingCenter
  ]));
