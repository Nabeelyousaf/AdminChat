import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flashscreen/ChatScreen.dart';
import 'package:flutter/material.dart';

class UserChat extends StatelessWidget {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Users'),
        centerTitle: true,
        backgroundColor: Colors.grey,
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: _firestore.collection('User').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return ListView.builder(
                // reverse: true,
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot documentSnapshot = snapshot.data.docs[index];
                  var doc = snapshot.data.docs;
                  return ChatCard(
                    function: () {
                      // print(
                      //   documentSnapshot['name'],
                      // );
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ChatScreen(
                            // index: index,
                            details: doc[index],
                            // name: documentSnapshot['name'],
                          ),
                        ),
                      );
                    },
                    documentSnapshot: documentSnapshot,
                  );
                },
              );
            }
          }),
    );
  }
}

class ChatCard extends StatelessWidget {
  const ChatCard({
    @required this.function,
    @required this.documentSnapshot,
  });
  final DocumentSnapshot documentSnapshot;
  final Function function;
  // final String name;

  @override
  Widget build(BuildContext context) {
    String name = documentSnapshot['Name'];
    print(name);
    return GestureDetector(
      onTap: function,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        child: Container(
          decoration: BoxDecoration(
              // color: Colors.green,
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black,
                  offset: Offset(1, 1),
                  blurRadius: 2,
                ),
              ]),
          height: 100,
          width: double.infinity,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: CircleAvatar(
                  child: Text('${name[0]} '),
                  radius: 40,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: Text(
                  documentSnapshot['Name'],
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
