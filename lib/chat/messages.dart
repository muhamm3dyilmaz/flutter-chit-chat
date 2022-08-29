import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'message_bubble.dart';

class Messages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('chat')
          .orderBy('createdAt', descending: true)
          .snapshots(),
      builder: (ctx, chatSnapshot) {
        if (chatSnapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        final chatDocs = (chatSnapshot as AsyncSnapshot).data.docs;
        return ListView.builder(
          //reverse: true,
          itemCount: chatDocs.length,
          itemBuilder: (ctx, index) => MessageBubble(
            chatDocs[index].data()['text'],
            chatDocs[index].data()['username'] ?? 'Username Not Found!',
            chatDocs[index].data()['userImage'] ?? 'Image Not Found!',
            chatDocs[index].data()['userId'] ==
                FirebaseAuth.instance.currentUser.uid,
            // (futureSnapshot as dynamic).data!.uid,
            key: ValueKey(chatDocs[index].id),
          ),
        );
      },
    );
  }
}
