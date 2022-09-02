// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
// import 'package:qbox_admin/screens/managements/free_video_management.dart';
// import 'package:video_player/video_player.dart';

// import '../../models/free_videos_model.dart';

class VideoDetails extends StatefulWidget {
  static String routeName = 'videoDetails';
  final String title;
  final String imageUrl;
  final String videoLink;
  final String category;
  final String subject;
  final String chapter;
  final String description;
  final int likes;
  final Map uploadDate;
  const VideoDetails(
      {Key? key,
      required this.imageUrl,
      required this.title,
      required this.likes,
      required this.uploadDate,
      required this.videoLink,
      required this.category,
      required this.subject,
      required this.chapter,
      required this.description})
      : super(key: key);

  @override
  State<VideoDetails> createState() => _VideoDetailsState();
}

class _VideoDetailsState extends State<VideoDetails> {
  File? imageFile;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding:
            EdgeInsets.all(MediaQuery.of(context).size.width * (1 / 153.6)),
        child: Column(
          children: [
            Row(
              // mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                    )),
                const Spacer(),
                Text(
                  'First Day - Details',
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width / 32,
                  ),
                ),
                const Spacer()
              ],
            ),
            const Divider(
              color: Colors.grey,
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                height: double.infinity,
                child: SingleChildScrollView(
                    child: Container(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => VideoScreen(
                                            title: widget.title,
                                            videoLink: widget.videoLink,
                                            description: widget.description,
                                          )));
                            },
                            child: Image(
                              image: Image.network(widget.imageUrl).image,
                              height: 180,
                              width: 310,
                              // fit: BoxFit.,
                              loadingBuilder:
                                  (context, child, loadingProgress) {
                                return loadingProgress == null
                                    ? child
                                    : const LinearProgressIndicator();
                              },
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Text(
                                    'Title',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 17,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  const SizedBox(
                                    width: 50,
                                  ),
                                  Text(widget.title),
                                  // Spacer(),
                                ],
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              Row(
                                children: [
                                  const Text(
                                    'Description',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 17,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  const SizedBox(
                                    width: 50,
                                  ),
                                  Text(widget.description),
                                ],
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              Row(
                                children: [
                                  const Text(
                                    'Chapter',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 17,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  const SizedBox(
                                    width: 50,
                                  ),
                                  Text(widget.chapter),
                                ],
                              )
                            ],
                          ),
                          Container(
                            width: 1,
                            height: 180,
                            color: Colors.grey,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Text(
                                    'Subject',
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 17,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  const SizedBox(
                                    width: 50,
                                  ),
                                  Text(widget.subject),
                                  // Spacer(),
                                ],
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              Row(
                                children: [
                                  const Text(
                                    'Course',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 17,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  const SizedBox(
                                    width: 50,
                                  ),
                                  Text(widget.category),
                                ],
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              Row(
                                children: [
                                  const Text(
                                    'Date',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 17,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  const SizedBox(
                                    width: 50,
                                  ),
                                  Text(widget.uploadDate.toString()),
                                ],
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              Row(
                                children: [
                                  const Text(
                                    'time',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 17,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  const SizedBox(
                                    width: 50,
                                  ),
                                  Text(widget.uploadDate.toString()),
                                ],
                              ),
                            ],
                          ),
                          Container(
                            width: 1,
                            height: 180,
                            color: Colors.grey,
                          ),
                          Column(
                            children: [
                              Row(
                                children: [
                                  const Text(
                                    'Download',
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 17,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  const SizedBox(
                                    width: 50,
                                  ),
                                  const Text('2.7k'),
                                ],
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              Row(
                                children: [
                                  const Text(
                                    'Likes',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 17,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  const SizedBox(
                                    width: 50,
                                  ),
                                  Text(widget.likes.toString()),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                      const Divider(
                        color: Colors.grey,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'Comments ',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 22,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                            ListTile(
                              leading: CircleAvatar(
                                backgroundColor: Colors.blue,
                                backgroundImage:
                                    Image.asset('assets/images/user.jpg').image,
                              ), //Image.asset('assets/images/user.jpg'),
                              title: const Text('Riya Patel'),
                              subtitle: const Text(
                                  'I want to know today weather report'),
                            ),
                            ListTile(
                              leading: CircleAvatar(
                                backgroundColor: Colors.blue,
                                backgroundImage:
                                    Image.asset('assets/images/user.jpg').image,
                              ), //Image.asset('assets/images/user.jpg'),
                              title: const Text('Praveen Kumar'),
                              subtitle: const Text(
                                  'I want to know today weather report'),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 60),
                              child: ListTile(
                                leading: CircleAvatar(
                                  backgroundColor: Colors.blue,
                                  backgroundImage:
                                      Image.asset('assets/images/user.jpg')
                                          .image,
                                ), //Image.asset('assets/images/user.jpg'),
                                title: const Text('sneha Verma'),
                                subtitle:
                                    const Text('I want to know today date'),
                              ),
                            ),
                            ListTile(
                              leading: CircleAvatar(
                                backgroundColor: Colors.blue,
                                backgroundImage:
                                    Image.asset('assets/images/user.jpg').image,
                              ), //Image.asset('assets/images/user.jpg'),
                              title: const Text('Chandan Verma'),
                              subtitle: const Text(
                                  'I want to know today weather report'),
                            ),
                            ListTile(
                              leading: CircleAvatar(
                                backgroundColor: Colors.blue,
                                backgroundImage:
                                    Image.asset('assets/images/user.jpg').image,
                              ), //Image.asset('assets/images/user.jpg'),
                              title: const Text('Mayank Nigam'),
                              subtitle: const Text(
                                  'I want to know today weather report'),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                )),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(18.0),
              child: TextField(
                decoration: InputDecoration(
                    fillColor: Colors.white,
                    label: const Text('You can reply any comment from here'),
                    suffix: Wrap(
                      children: [
                        IconButton(
                          onPressed: () {
                            setState(() {});
                            _getFromGallery();
                          },
                          icon: Icon(
                            Icons.image_outlined,
                            color: Colors.blue,
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.send_sharp,
                            color: Colors.blue,
                          ),
                        ),
                      ],
                    )),
              ),
            ),
            // IconButton(onPressed: (){

            // }, icon: Icon(Icons.send_sharp, color: Colors.blue,))
            //  Row(
            //             mainAxisAlignment: MainAxisAlignment.end,
            //             crossAxisAlignment: CrossAxisAlignment.end,
            //             children:  [ IconButton(onPressed: (){
            //               setState(() {

            //               });
            //               _getFromGallery();

            //             }, icon: Icon(Icons.image_outlined, color: Colors.blue,),),

            //               const SizedBox(width: 15,),
            //              IconButton(onPressed: (){}, icon: Icon(Icons.send_sharp, color: Colors.blue,),),
            //             ],
            //           )
          ],
        ),
      ),
    );
  }

  _getFromGallery() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
    }
  }
}

class VideoScreen extends StatefulWidget {
  static const String routeName = '/videoScreen';
  final String title;
  final String videoLink;
  final String description;
  const VideoScreen(
      {Key? key,
      required this.title,
      required this.videoLink,
      required this.description})
      : super(key: key);

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  // Initial Selected Value
  String dropdownvalue = '144p';

  // List of items in our dropdown menu
  var items = ['144p', '240p', '360p', '480p', '720p', '1080p'];
  late VideoPlayerController videoPlayerController;
  ChewieController? chewieController;
  Future<void> setVolume(double volume) async {
    await videoPlayerController.setVolume(volume);
  }

  @override
  void initState() {
    super.initState();
    videoPlayerController = VideoPlayerController.network(widget.videoLink);
    chewieController = ChewieController(
        videoPlayerController: videoPlayerController,
        allowMuting: true,
        showOptions: true,
        zoomAndPan: true,
        maxScale: 400,
        // aspectRatio: 16/9,
        autoPlay: true,
        allowFullScreen: true,
        looping: true,
        autoInitialize: true,
        errorBuilder: (context, errorMessage) {
          return Center(
            child: Text(
              errorMessage,
              style: TextStyle(color: Colors.white),
            ),
          );
        },
        subtitle: Subtitles([
          Subtitle(
            index: 0,
            start: Duration.zero,
            end: const Duration(seconds: 10),
            text: 'Hello from subtitles',
          ),
          Subtitle(
            index: 1,
            start: const Duration(seconds: 10),
            end: const Duration(seconds: 20),
            text: 'Whats up? :)',
          ),
        ]),
        subtitleBuilder: (context, subtitle) => Container(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                subtitle,
                style: const TextStyle(color: Colors.white),
              ),
            ),
        additionalOptions: (context) {
          return <OptionItem>[
            OptionItem(
                onTap: () => debugPrint('Press 1'),
                iconData: Icons.settings,
                title: 'Quality'),
            OptionItem(
                onTap: () => debugPrint('Press 2'),
                iconData: Icons.loop,
                title: 'Loop Video'),
          ];
        });
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
      body: Column(
        children: [
          Text(widget.title, 
            style: TextStyle(
                    fontSize: 22,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),),
          Container(
              height: 550,
              width: double.infinity,
              child: Chewie(controller: chewieController!)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                'video full details  descriptions ${widget.description}',
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              DropdownButton(
                dropdownColor: Colors.white,
                icon: Text('Quality (${dropdownvalue})'),
                // icon: Icon(
                //   Icons.more_vert,
                //   color: Theme.of(context).primaryIconTheme.color,
                // ),
                // value: dropdownvalue,
                items: items.map((String items) {
                  return DropdownMenuItem(
                    value: items,
                    child: Text(items),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownvalue = newValue!;
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
