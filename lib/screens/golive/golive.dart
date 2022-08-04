import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jitsi_meet/jitsi_meet.dart';
import 'package:webviewx/webviewx.dart';

class JoinMeeting extends StatefulWidget {
  final String roomText, subjectText, nameText;
  const JoinMeeting(
      {Key? key,
      required this.roomText,
      required this.subjectText,
      required this.nameText})
      : super(key: key);

  @override
  State<JoinMeeting> createState() => JoinMeetingState();
}

class JoinMeetingState extends State<JoinMeeting> {
  String serverText = "";

  String roomText = "";
  String subjectText = "";

  String nameText = "";
  String emailText = "";

  bool? isAudioOnly = false;
  bool? isAudioMuted = true;
  bool? isVideoMuted = true;


  void initialize() {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        roomText = widget.roomText;
        subjectText = widget.subjectText;
        nameText = widget.nameText;
        emailText = user.email!;
      });
    }
  
  }

  @override
  void initState() {
    super.initState();
    initialize();
   
  }


  bool isJoined = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Meeting"),
      ),
      body: WebViewX(
        height: MediaQuery.of(context).size.height,
        initialContent: """
      <!DOCTYPE html>
      <body style="margin: 0;">
          <div id="meet"></div>
         <script src="https://meet.jit.si/external_api.js"></script>
          <script>
              const domain = 'meet.jit.si';
              const options = {
                  roomName: '$roomText',
                  userInfo: {
                    displayName: '$nameText'
                  },
                  width: '100%',
                  height: 750,
                  parentNode: document.querySelector('#meet')
              };
              const api = new JitsiMeetExternalAPI(domain, options);
          </script>
      </body>
      </html>""",
        initialSourceType: SourceType.html,
        width: MediaQuery.of(context).size.width,
      ),
      
     
    );
  }
}
