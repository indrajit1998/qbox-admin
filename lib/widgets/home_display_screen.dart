import 'package:chewie/chewie.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../models/free_videos_model.dart';
import '../screens/managements/video_details.dart';

class HomeDisplayScreen extends StatefulWidget {
  final String title;
  final String imageUrl;
  final String videoLink;
  final int likes;
  final Map uploadDate;
  const HomeDisplayScreen({
    Key? key,
    required this.title,
    required this.imageUrl,
    required this.likes,
    required this.videoLink,
    required this.uploadDate,
  }) : super(key: key);

  @override
  State<HomeDisplayScreen> createState() => _HomeDisplayScreenState();
}
List<FreeVideoModel> freeVideoModelList = [];
class _HomeDisplayScreenState extends State<HomeDisplayScreen> {
  // List<FreeVideoModel> freeVideoModelList = [];
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Expanded(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).size.width * (1 / 153.6),
          ),
          child: SingleChildScrollView(
            child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('videos')
                    .where("uploadedTeacherEmail",
                        isEqualTo:
                            FirebaseAuth.instance.currentUser!.email.toString())
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return const Text('Something went wrong!');
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    // alignment: WrapAlignment.center,
                    // runSpacing: 10,
                    // spacing: 10,
                    children:
                        snapshot.data!.docs.map((DocumentSnapshot document) {
                      Map<String, dynamic> data =
                          document.data()! as Map<String, dynamic>;
                      FreeVideoModel model = FreeVideoModel.fromJson(data);
                      freeVideoModelList.add(model);
                      return Container(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        child: Theme(
                            data: Theme.of(context)
                                .copyWith(dividerColor: Colors.white),
                            child: DataTable(
                              //border: TableBorder.symmetric(inside: BorderSide(width: 1.5,style: BorderStyle.solid,color: Colors.red)),
                              columns: [
                                DataColumn(label: Text('Title')),
                                DataColumn(label: Text('Description')),
                                DataColumn(label: Text('Likes')),
                                DataColumn(label: Text('Category')),
                                DataColumn(label: Text('Date')),
                                DataColumn(label: Text('Comment')),
                                DataColumn(label: Text('Download')),
                                DataColumn(label: Text('Subject')),
                                DataColumn(label: Text('Chapter')),
                              ],
                              rows: [
                                DataRow(
                                    color: MaterialStateColor.resolveWith(
                                        (states) => Colors.black12),
                                    cells: <DataCell>[
                                      DataCell(Text(model.title.toString())),
                                      DataCell(Text(model.course.toString())),
                                      DataCell(Text(model.likes.toString())),
                                      DataCell(Text(model.category.toString())),
                                      DataCell(
                                          Text(model.uploadDate.toString())),
                                      DataCell(Text('1.2k')),
                                      DataCell(Text('1.2k')),
                                      DataCell(Text(model.category.toString())),
                                      DataCell(Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(model.category.toString()),
                                          Spacer(),
                                          IconButton(
                                              onPressed: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) => VideoDetails(imageUrl: model.imageUrl.toString(),)
                                                          ),
                                                );
                                              },
                                              icon: Icon(
                                                Icons.arrow_right_alt,
                                                color: Colors.blue,
                                              ))
                                        ],
                                      )),
                                      // DataCell(Text('icon'))
                                    ])
                              ],
                            )),
                      );
                      // return HorizontalCard(
                      //   model: model,
                      // );
                    }).toList(),
                  );
                }),
          ),
        ),
      ),
      //child: Column(
      //crossAxisAlignment: CrossAxisAlignment.start,
      // children: [
      // GestureDetector(
      //   onTap: () {
      // Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //         builder: (context) => VideoScreen(
      //               title: title,
      //               videoLink: videoLink,
      //             )));
      //   },
      //   child: Image(
      //     image: NetworkImage(imageUrl),
      //     height: 170,
      //     width: 310,
      //     fit: BoxFit.cover,
      //     loadingBuilder: (context, child, loadingProgress) {
      //       return loadingProgress == null
      //           ? child
      //           : const LinearProgressIndicator();
      //     },
      //   ),
      // ),
      // const SizedBox(
      //   height: 5,
      // ),
      // Text(
      //   title,
      //   textAlign: TextAlign.start,
      //   style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      // ),
      // const SizedBox(
      //   height: 3,
      // ),
      // Row(
      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //   children: [
      //     const SizedBox(),
      //     const Text('Figma '),
      //     Text('$likes Likes'),
      //     Row(
      //       children: [
      //         Text('${uploadDate['value']} ${uploadDate['string']} ago'),
      //       ],
      //     ),
      //     const SizedBox(),
      //   ],
      // ),
      // ],
      // ),
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


