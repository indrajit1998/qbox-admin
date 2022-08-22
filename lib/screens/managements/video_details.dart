

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../../models/free_videos_model.dart';


class VideoDetails extends StatefulWidget {
  static String routeName = 'videoDetails';
  final String imageUrl;
  VideoDetails({Key? key, required this.imageUrl}) : super(key: key);

  @override
  State<VideoDetails> createState() => _VideoDetailsState();
}

class _VideoDetailsState extends State<VideoDetails> {
  List<FreeVideoModel> freeVideoModelList = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
         padding:
            EdgeInsets.all(MediaQuery.of(context).size.width * (1 / 153.6)),
        child: Column(
          children: [
             Text(
              'Free Videos',
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width / 32,
              ),
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
                        child: Column(
                          children: [
                            Image(
          image: NetworkImage(model.imageUrl.toString()),
          height: 170,
          width: 310,
          fit: BoxFit.cover,
          // loadingBuilder: (context, child, loadingProgress) {
          //   return loadingProgress == null
          //       ? child
          //       : const LinearProgressIndicator();
          // },
        ),
      
                          ],
                        ),

                      );
                      
                    }).toList(),
                  );
                }),
          ),
        ),
      ),
          ],
        ),
      ),
    );
  }
}