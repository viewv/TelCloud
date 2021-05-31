// tdlib_ex.dart
import 'package:TelCloud_Core/tdlib.dart' as td;
//import ' tdlib/tdlib.dart' as td;
import 'tdlib_ex.reflectable.dart';

Future main() async {
  initializeReflectable();

  final client = td.TelegramClient('../core/tdlib');

  client.defineTdlibParams(
    // There are other parameters but these four are required!
    apiId: 1234567,
    apiHash: 'api hash',
    deviceModel: 'viewv phone',
    systemVersion: 'viewvOS 1.0',
  );

  try {
    // Get a stream to handle changes to the authorization state
    // Mind you, there are other authorization states and it's better to switch
    // over [state.runtimeType].
    client.authorizationState.listen((state) async {
      if (state is td.AuthorizationStateWaitTdlibParameters) {
        await client.send(td.SetTdlibParameters(client.tdlibParams));
      }
    });

    await for (final update in client.incoming()) {
      // Handle each incoming update
    }
  } finally {
    // Be sure to close the client
    await client.close();
  }
}
