import 'package:flutter/material.dart';
import 'package:flutter_ion/flutter_ion.dart' as ion;
import 'package:flutter_ion/flutter_ion.dart';
import 'package:uuid/uuid.dart';
import 'package:webrtc/webrtc.dart';

class GoLive extends StatefulWidget {
  const GoLive({Key? key}) : super(key: key);

  @override
  State<GoLive> createState() => _GoLiveState();
}

class _GoLiveState extends State<GoLive> {
  final _localRenderer = RTCVideoRenderer();
  final List<RTCVideoRenderer> _remoteRenderers = <RTCVideoRenderer>[];
  final Connector _connector = Connector('http://127.0.0.1:5551');
  final _room = 'ion';
  final _uid = const Uuid().v4();
  late RTC _rtc;
  @override
  void initState() {
    super.initState();
    connect();
  }

  void connect() async {
    _rtc = RTC(_connector);
    _rtc.onspeaker = (Map<String, dynamic> list) {
      print('onspeaker: $list');
    };

    _rtc.ontrack = (track, RemoteStream remoteStream) async {
      print('onTrack: remote stream => ${remoteStream.id}');
      if (track.kind == 'video') {
        var renderer = RTCVideoRenderer();
        await renderer.initialize();
        renderer.srcObject = remoteStream.stream as MediaStream;
        setState(() {
          _remoteRenderers.add(renderer);
        });
      }
    };

    _rtc.ontrackevent = (ion.TrackEvent event) {
      print(
          'ontrackevent state = ${event.state},  uid = ${event.uid},  tracks = ${event.tracks}');
      if (event.state == TrackState.REMOVE) {
        setState(() {
          // _remoteRenderers.removeWhere(
          //     (element) => element.srcObject == event.tracks[0].stream_id);
        });
      }
    };

    await _rtc.connect();
    await _rtc.join(_room, _uid, JoinConfig());

    await _localRenderer.initialize();
    // publish LocalStream
    var localStream =
        await LocalStream.getUserMedia(constraints: Constraints.defaults);
    await _rtc.publish(localStream);
    setState(() {
      _localRenderer.srcObject = localStream.stream as MediaStream;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Go Live'),
        ),
        body: OrientationBuilder(builder: (context, orientation) {
          return Column(
            children: [
              Row(
                children: [Text('Local Video')],
              ),
              Expanded(
                child: Row(
                  children: [
                    SizedBox(
                        width: 160,
                        height: 120,
                        child: RTCVideoView(_localRenderer))
                  ],
                ),
              ),
              Row(
                children: [Text('Remote Video')],
              ),
              Expanded(
                child: Row(
                  children: [
                    ..._remoteRenderers.map((remoteRenderer) {
                      return SizedBox(
                          width: 160,
                          height: 120,
                          child: RTCVideoView(remoteRenderer));
                    }).toList(),
                  ],
                ),
              ),
            ],
          );
        }));
  }
}
