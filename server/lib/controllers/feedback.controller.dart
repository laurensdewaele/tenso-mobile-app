import 'dart:async';

import 'package:aqueduct/aqueduct.dart';

class FeedbackController extends ResourceController {
  @Operation.post()
  Future<Response> writeFeedback(@Bind.body() Map<String, dynamic> body) async {
    print(body.runtimeType);
    print(body);
    return Response.ok(body);
  }
}
