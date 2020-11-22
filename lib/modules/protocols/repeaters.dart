import 'package:flutter/cupertino.dart';
import 'package:tenso_app/modules/protocols/protocol_card.dart';
import 'package:tenso_app/styles/styles.dart' as styles;

const String _description =
    'This protocol was developed to try to mimic climbing as closely as possible. '
    '\n\nFor endurance, aim for a low intensity load. You should not get pumped at all.'
    '\n\nFor strength endurance aim for a high intensity load. You should aim to get really pumped on the last set.'
    '\n\nAdjust the load accordingly. To help you find the correct load, you can do a testing session where you find the maximum load you can hang for 7 seconds. '
    '\n\nFor endurance, aim for 40% of your max load.'
    '\n\nFor power endurance, aim for 60 - 80% of your max load.'
    '\n\nExample:'
    '\nI weigh 70kg and can hang an extra 30kg for 7s. '
    '\n\nTotal load = 100kg'
    '\n\n40%: remove 30kg with pulley system'
    '\n80%: add 10 kg with harness';

class RepeatersProtocol extends StatelessWidget {
  RepeatersProtocol({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProtocolCard(
        iconImageAsset: 'assets/images/icons/intermittent.png',
        iconBackground: styles.Colors.bgBlack,
        title: 'Repeaters\n(intermittent hangs)',
        function: 'Endurance or strength endurance',
        gain: 'Structural',
        volume: 'High',
        requirements: 'Weights + pulley system',
        popularizedBy: 'Dr. Michael Anderson, Mark Anderson',
        hangTime: '7s followed by 3s rest',
        description: _description,
        moreInfo: 'Article on strengthclimbing.com',
        moreInfoLink: 'https://strengthclimbing.com/hangboard-repeaters/');
  }
}
