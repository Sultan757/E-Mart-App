import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String text;
  final Timestamp timestamp;
  final String senderId;
  final String receiverId;

  Message({
    required this.senderId,
    required this.receiverId,
    required this.text,
    required this.timestamp,
  });

  Message.fromSnapshot(QueryDocumentSnapshot snapshot)
      : text = snapshot.get('text'),
        timestamp = snapshot.get('timestamp'),
        senderId = snapshot.get('senderId'),
      receiverId = snapshot.get('receiverId');
}
