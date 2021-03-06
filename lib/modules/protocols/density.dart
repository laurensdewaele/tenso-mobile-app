import 'package:flutter/cupertino.dart';
import 'package:tenso_app/modules/protocols/protocol_card.dart';
import 'package:tenso_app/styles/styles.dart' as styles;

const String _description =
    'Find an edge depth where you can hold on for 20 to 40 seconds. The goal here is to hang until muscular failure.'
    '\n\nThis protocol is perfect for beginners. It does not require additional weight, nor a pulley system to reduce weight.'
    '\n\nThis protocol with its longer hang times and reduced intensity, is focused on tendon health and hypertrophy.';

class DensityProtocol extends StatelessWidget {
  DensityProtocol({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProtocolCard(
        iconImageAsset: 'assets/images/icons/tendon_add.png',
        iconBackground: styles.Colors.purple,
        title: 'Density',
        function: 'Strength endurance',
        gain: 'Structural',
        volume: 'High',
        requirements: 'None',
        popularizedBy: 'Dr. Tyler Nelson',
        hangTime: '20 to 40 seconds',
        description: _description,
        moreInfo: 'Article on trainingbeta.com',
        moreInfoLink:
            'https://www.trainingbeta.com/the-simplest-finger-training-program/');
  }
}
