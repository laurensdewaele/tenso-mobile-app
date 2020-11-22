import 'package:flutter/cupertino.dart';
import 'package:tenso_app/modules/protocols/protocol_card.dart';
import 'package:tenso_app/styles/styles.dart' as styles;

const String _description =
    'Aim for a load where you don\'t quite reach failure at 10 seconds.'
    '\n\nThis typically involves adding weights with a harness.'
    '\n\n\This protocol promotes neurological changes, and as a result will produce the fastest strength gains. This does not mean you should be doing these exclusively.';

class MaxHangsProtocol extends StatelessWidget {
  MaxHangsProtocol({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProtocolCard(
        iconImageAsset: 'assets/images/icons/weights.png',
        iconBackground: styles.Colors.primary,
        title: 'Max hangs',
        function: 'Strength',
        gain: 'Neurological',
        volume: 'Low',
        requirements: 'Harness + weights',
        popularizedBy: 'Dr. Eva López',
        hangTime: '10 seconds',
        description: _description,
        moreInfo: 'Article on strengthclimbing.com',
        moreInfoLink: 'https://strengthclimbing.com/eva-lopez-maxhangs/');
  }
}
