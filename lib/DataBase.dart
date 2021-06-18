// import 'package:cloud_firestore/cloud_firestore.dart';

// class DataBase {
//   Future<void> addUserInfo(userData) async {
//     FirebaseFirestore.instance
//         .collection("users")
//         .add(userData)
//         .catchError((e) {
//       print(e.toString());
//     });
//   }

//   getUserInfo(String email) async {
//     return FirebaseFirestore.instance
//         .collection("users")
//         .where("userEmail", isEqualTo: email)
//         .get()
//         .catchError((e) {
//       print(e.toString());
//     });
//   }

//   getChats(String chatRoomId) async {
//     return FirebaseFirestore.instance
//         .collection("chatRoom")
//         .doc(chatRoomId)
//         .collection("chats")
//         .orderBy('time')
//         .snapshots();
//   }

//   Future<void> addMessage(String chatRoomId, chatMessageData) {
//     FirebaseFirestore.instance
//         .collection("chatRoom")
//         .doc(chatRoomId)
//         .collection("chats")
//         .add(chatMessageData)
//         .catchError((e) {
//       print(e.toString());
//     });
//   }

//   getUserChats(String itIsMyName) async {
//     return await FirebaseFirestore.instance
//         .collection("chatRoom")
//         .where('users', arrayContains: itIsMyName)
//         .snapshots();
//   }
// }
