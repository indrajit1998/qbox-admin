// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:qbox_admin/screens/managements/free_video_management.dart';
// import 'package:video_player/video_player.dart';

// import '../../models/free_videos_model.dart';

class VideoDetails extends StatefulWidget {
  static String routeName = 'videoDetails';
  final String title;
  final String imageUrl;
  // final String videoLink;
  // final String category;
  final int likes;
  final Map uploadDate;
  const VideoDetails(
      {Key? key,
      required this.imageUrl,
      required this.title,
      required this.likes,
      required this.uploadDate})
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
                // margin: EdgeInsets.only(
                //   bottom: MediaQuery.of(context).size.width * (1 / 153.6),
                // ),
                child: SingleChildScrollView(
                    child: Container(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image(
                            image: NetworkImage(widget.imageUrl),
                            height: 180,
                            width: 310,
                            fit: BoxFit.cover,
                            loadingBuilder: (context, child, loadingProgress) {
                              return loadingProgress == null
                                  ? child
                                  : const LinearProgressIndicator();
                            },
                          ),
                          // Table(
                          //   children: const <TableRow>[
                          //     TableRow(children: [
                          //       Text('data'),
                          //       Text('data1'),
                          //     ])
                          //   ],
                          // )

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
                                  const Text('fdukgh n djhjdhfe'),
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
                                  const Text('Physics'),
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
                                  const Text('physics'),
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
                                  const Text('physics'),
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
                              subtitle:
                                  const Text('I want to know today weather report'),
                            ),
                            ListTile(
                              leading: CircleAvatar(
                                backgroundColor: Colors.blue,
                                backgroundImage:
                                    Image.asset('assets/images/user.jpg').image,
                              ), //Image.asset('assets/images/user.jpg'),
                              title: const Text('Praveen Kumar'),
                              subtitle:
                                  const Text('I want to know today weather report'),
                            ), 
                            Padding(
                              padding: const EdgeInsets.only(left: 60),
                              child: ListTile(
                                leading: CircleAvatar(
                                  backgroundColor: Colors.blue,
                                  backgroundImage:
                                      Image.asset('assets/images/user.jpg').image,
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
                              subtitle:
                                  const Text('I want to know today weather report'),
                            ),
                            ListTile(
                              leading: CircleAvatar(
                                backgroundColor: Colors.blue,
                                backgroundImage:
                                    Image.asset('assets/images/user.jpg').image,
                              ), //Image.asset('assets/images/user.jpg'),
                              title: const Text('Mayank Nigam'),
                              subtitle:
                                  const Text('I want to know today weather report'),
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
IconButton(onPressed: (){
                          setState(() {
                            
                          });
                          _getFromGallery();

                        }, icon: Icon(Icons.image_outlined, color: Colors.blue,),),
                          
                          const SizedBox(width: 15,),
                         IconButton(onPressed: (){}, icon: Icon(Icons.send_sharp, color: Colors.blue,),),
                        ],
                      )
                    ),
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
