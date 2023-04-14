import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/models/message_model.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {
  // Create a reference to the Firestore collection
  final CollectionReference messagesCollection =
      FirebaseFirestore.instance.collection('messages');

// Send a message to Firestore
  void sendMessage(
    String message,
    String senderId,
    String receiverId,
  ) {
    messagesCollection.add({
      'senderId': senderId,
      'receiverId': receiverId,
      'text': message,
      'timestamp': Timestamp.now(),
    });
  }

// Retrieve messages from Firestore
  Stream<List<Message>> getMessages(String currentUserId, String receiverId) {
    final userIDs = [currentUserId, receiverId];
    return messagesCollection
        .where('user', arrayContainsAny: [currentUserId, receiverId])
      
        //.orderBy('timestamp', descending: false)
        .snapshots()
        .map((QuerySnapshot querySnapshot) => querySnapshot.docs
            .map((QueryDocumentSnapshot documentSnapshot) =>
                Message.fromSnapshot(documentSnapshot))
            .toList());
  }
}
