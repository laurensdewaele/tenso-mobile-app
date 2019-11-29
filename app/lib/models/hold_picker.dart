import 'package:app/models/grips.dart';

class HoldPickerValue {
  HoldPickerValue(
      {this.grip,
      this.pockets,
      this.twoHanded,
      this.oneHandLeft,
      this.oneHandRight});

  final Grips grip;
  final List<int> pockets;
  final bool twoHanded;
  final bool oneHandLeft;
  final bool oneHandRight;
}
