// import 'package:jitsi_meet_wrapper/jitsi_meet_wrapper.dart';
// import 'package:flutter/material.dart';

// class VideoConfig extends StatelessWidget {
//   const VideoConfig({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Jitsi Meet Demo'),
//       ),
//       body: Center(
//         child: ElevatedButton(
//           child: Text('Join Meeting'),
//           onPressed: () async {
//             final options = JitsiMeetingOptions(
//                 roomNameOrUrl: 'exapmle_rrom',
//                 serverUrl: 'https://your.jitsi.server',
//                 subject: 'Example Meeting',
//                 userDisplayName: 'John Doe',
//                 userEmail: 'johndoe@example.com',
//                 isVideoMuted: false);

//             await JitsiMeetWrapper.joinMeeting(options: options);
//           },
//         ),
//       ),
//     );
//   }
// }
