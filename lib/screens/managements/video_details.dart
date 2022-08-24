

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:qbox_admin/screens/managements/free_video_management.dart';
import 'package:video_player/video_player.dart';

import '../../models/free_videos_model.dart';


class VideoDetails extends StatefulWidget {
  static String routeName = 'videoDetails';
  final String title;
  final String imageUrl;
  // final String videoLink;
  // final String category;
  final int likes;
  final Map uploadDate;
  const VideoDetails({Key? key, required this.imageUrl, required this.title, required this.likes, required this.uploadDate}) : super(key: key);

  @override
  State<VideoDetails> createState() => _VideoDetailsState();
}

class _VideoDetailsState extends State<VideoDetails> {
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
                IconButton(onPressed: (){
                  Navigator.of(context).pop();
                }, icon: Icon(Icons.arrow_back, color: Colors.black,)),
                Spacer(),
                 Text(
                  'Free Videos',
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width / 32,
                  ),
            ),
            Spacer()
               ],
             ),
            const Divider(
              color: Colors.amberAccent,
            ),
            Expanded(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).size.width * (1 / 153.6),
          ),
          child: SingleChildScrollView(
            child: Container(
                        child: Row(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image(
          image: NetworkImage(widget.imageUrl),
          height: 170,
          width: 310,
          fit: BoxFit.cover,
          loadingBuilder: (context, child, loadingProgress) {
            return loadingProgress == null
                ? child
                : const LinearProgressIndicator();
          },
        ),
        
                              ],
                            ),
                          ],
                        ),

                      )
          ),
        ),
      ),
          ],
        ),
      ),
    );
  }
}