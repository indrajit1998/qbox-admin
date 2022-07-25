import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class HomeDisplayScreen extends StatelessWidget {
  final String title;
  final String imageUrl;
  final String videoLink;
  final int likes;
  final Map uploadDate;
  const HomeDisplayScreen(
      {Key? key,
      required this.title,
      required this.imageUrl,
      required this.likes,
      required this.videoLink,
      required this.uploadDate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 310,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => VideoScreen(
                            title: title,
                            videoLink: videoLink,
                          )));
            },
            child: Image(
              image: NetworkImage(imageUrl),
              height: 170,
              width: 310,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                return loadingProgress == null
                    ? child
                    : const LinearProgressIndicator();
              },
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            title,
            textAlign: TextAlign.start,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 3,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(),
              const Text('Figma '),
              Text('$likes Likes'),
              Row(
                children: [
                  Text('${uploadDate['value']} ${uploadDate['string']} ago'),
                ],
              ),
              const SizedBox(),
            ],
          ),
        ],
      ),
    );
  }
}

class VideoScreen extends StatefulWidget {
  static const String routeName = '/videoScreen';
  final String title;
  final String videoLink;
  const VideoScreen({Key? key, required this.title, required this.videoLink})
      : super(key: key);

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  late VideoPlayerController videoPlayerController;
  ChewieController? chewieController;

  @override
  void initState() {
    super.initState();
    videoPlayerController = VideoPlayerController.network(widget.videoLink);
    chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      autoPlay: true,
      allowFullScreen: true,
    );
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    chewieController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Container(
        margin: const EdgeInsets.only(top: 20),
        alignment: Alignment.topRight,
        child: FloatingActionButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Icon(Icons.close)),
      ),
      body: Chewie(
        controller: chewieController!,
      ),
    );
  }
}
