import 'package:flutter/cupertino.dart';
import 'package:tenso_app/models/models.dart';
import 'package:tenso_app/styles/styles.dart' as styles;
import 'package:tenso_app/widgets/card.dart';
import 'package:tenso_app/widgets/divider.dart';
import 'package:tenso_app/widgets/label_text_picker.dart';

class FilterLabelPickerCard extends StatelessWidget {
  const FilterLabelPickerCard({
    Key key,
    @required this.resetLabelPicker$,
    @required this.handleLabelChanged,
    @required this.labelsWithText,
    @required this.initialLabelWithText,
  });

  final Stream<bool> resetLabelPicker$;
  final void Function(Label label) handleLabelChanged;
  final List<LabelWithText> labelsWithText;
  final LabelWithText initialLabelWithText;

  @override
  Widget build(BuildContext context) {
    return Card(
      padding: EdgeInsets.all(styles.Measurements.m),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'label',
            style: styles.Staatliches.xlBlack,
          ),
          Divider(height: styles.Measurements.m),
          LabelWithTextPicker(
            reset$: resetLabelPicker$,
            handleLabelChanged: handleLabelChanged,
            labelsWithText: labelsWithText,
            initialLabelWithText: initialLabelWithText,
          ),
        ],
      ),
    );
  }
}
