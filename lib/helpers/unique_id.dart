import 'package:uuid/uuid.dart';

Uuid _uuid = Uuid();

String generateUniqueId() {
  return _uuid.v4();
}
