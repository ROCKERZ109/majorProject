import 'package:web_socket_channel/web_socket_channel.dart';

import '../Helper/HelperVariables.dart';

class PilotPassengerCommonMethods
{
  int connectionAttempts = 0;
  final int maxConnectionAttempts = 5;
  final Duration retryDelay = const Duration(seconds: 2);
  WebSocketChannel? channel;
  Future<WebSocketChannel> initializeWebsocket({var phone,var port}) async {
    while (connectionAttempts < maxConnectionAttempts) {
      try {
        channel = WebSocketChannel.connect(
            Uri.parse('ws://209.38.239.190:$port?phone=$phone'));
        // Connection successful, break out of the loop
        break;
      } catch (e) {
        print('WebSocket connection error: $e');
        // Increment connection attempts
        connectionAttempts++;
        // Delay before retrying
        await Future.delayed(retryDelay);
      }
    }
    if (channel == null) {
      print('Failed to establish websocket connection after $maxConnectionAttempts attempts');
      return  channel!;
    } else {

        return channel!;

    }
  }


}