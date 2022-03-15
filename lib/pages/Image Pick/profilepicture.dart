// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';

// class ProfilePicture extends StatefulWidget {
//   const ProfilePicture({Key? key}) : super(key: key);

//   @override
//   State<ProfilePicture> createState() => _ProfilePictureState();
// }

// class _ProfilePictureState extends State<ProfilePicture> {
//   @override
//   Widget build(BuildContext context) {
//     // final imagePicker = ImagePicker();
//     // PickedFile _imageFile;
//     // selectPhoto(ImageSource source) async {
//     //   XFile? image = await imagePicker.pickImage(
//     //     source: source,
//     //     imageQuality: 50,
//     //     preferredCameraDevice: CameraDevice.front,
//     //   );
//     //   setState(() {
//     //     _imageFile = image as PickedFile;
//     //   });
//     // }

//     return Stack(
//       children: [
//         const Padding(
//           padding: EdgeInsets.all(8.0),
//           child: CircleAvatar(
//             radius: 80,
//             //  backgroundImage: ,
//           ),
//         ),
//         Positioned(
//           bottom: 15,
//           right: 15,
//           child: Container(
//             width: 40,
//             height: 40,
//             decoration: const BoxDecoration(
//               shape: BoxShape.circle,
//               color: Colors.blue,
//             ),
//             child: IconButton(
//               onPressed: () {
//                 showDialog(
//                   context: context,
//                   builder: (BuildContext context) {
//                     return AlertDialog(
//                       title: const Text('Select profile picture'),
//                       content: Column(
//                         mainAxisSize: MainAxisSize.min,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: <Widget>[
//                           TextButton(
//                             onPressed: () {
//                               selectPhoto(ImageSource.camera);
//                             },
//                             child: const ListTile(
//                               leading: Icon(Icons.camera),
//                               title: Text("Take Photo"),
//                             ),
//                           ),
//                           TextButton(
//                             onPressed: () {
//                               selectPhoto(ImageSource.gallery);
//                             },
//                             child: const ListTile(
//                               leading: Icon(Icons.image),
//                               title: Text("Choose Photo"),
//                             ),
//                           ),
//                         ],
//                       ),
//                     );
//                   },
//                 );
//               },
//               icon: const Icon(
//                 Icons.edit,
//                 size: 24,
//                 color: Colors.white,
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
