import 'dart:math';
import 'package:flutter/material.dart';
import 'package:student_hub_flutter/keys.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:student_hub_flutter/client.dart' as client;

class VideoCallPage extends StatelessWidget {
  final String callId;

  const VideoCallPage({super.key, required this.callId});

  @override
  Widget build(BuildContext context) {
    return ZegoUIKitPrebuiltCall(
      appID: zegoAppId,
      appSign: zegoAppSign,
      userID: (client.user?.id ?? Random()).toString(),
      userName: client.user?.fullName ?? "Unknown",
      callID: callId,
      // You can also use groupVideo/groupVoice/oneOnOneVoice to make more types of calls.
      config: ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall(),
    );
  }
}
