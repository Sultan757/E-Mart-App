import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/controllers/chatting_controller.dart';
import 'package:emart_app/models/message_model.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class ChatScreen extends StatefulWidget {
  final String currentUserId;
  final String receiverId;

  const ChatScreen(
      {super.key, required this.currentUserId, required this.receiverId});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _textEditingController = TextEditingController();
  late Stream<List<Message>> _messagesStream;
  ChatController controller = Get.put(ChatController());

  @override
  void initState() {
    super.initState();
    _messagesStream =
        controller.getMessages(widget.currentUserId, widget.receiverId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: 'Title'.text.semiBold.color(darkFontGrey).make(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder<List<Message>>(
                stream: _messagesStream,
                builder: (BuildContext context,
                    AsyncSnapshot<List<Message>> snapshot) {
                  if (snapshot.hasData) {
                    final List<Message> messages = snapshot.data!;
                    return LayoutBuilder(builder:
                        (BuildContext context, BoxConstraints constraints) {
                      return ListView.builder(
                        reverse: true,
                        itemCount: messages.length,
                        itemBuilder: (BuildContext context, int index) {
                          final Message message = messages[index];
                          final bool isSentByCurrentUser =
                              message.senderId == widget.currentUserId;
                          return Row(
                            mainAxisAlignment: isSentByCurrentUser
                                ? MainAxisAlignment.end
                                : MainAxisAlignment.start,
                            children: [
                              ListTile(
                                title: Container(
                                  constraints: BoxConstraints(
                                      maxWidth:
                                          MediaQuery.of(context).size.width *
                                              0.6),
                                  child: Text(
                                    snapshot.data![index].text,
                                    style: TextStyle(
                                        color: isSentByCurrentUser
                                            ? whiteColor
                                            : Colors.black),
                                  )
                                      .box
                                      .alignCenterRight
                                      .padding(const EdgeInsets.fromLTRB(
                                          13, 12, 10, 10))
                                      .color(isSentByCurrentUser
                                          ? redColor
                                          : darkFontGrey)
                                      .roundedLg
                                      .alignCenterLeft
                                      .make(),
                                ),
                                subtitle: Text(
                                        message.timestamp.toDate().toString(),
                                        style: const TextStyle(
                                            color: darkFontGrey, fontSize: 11))
                                    .box
                                    .alignCenterRight
                                    .padding(
                                        const EdgeInsets.fromLTRB(0, 2, 13, 0))
                                    .color(Colors.transparent)
                                    .make(),
                              ),
                            ],
                          );
                        },
                      );
                    });
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
            Row(children: [
              Expanded(
                  child: TextFormField(
                decoration:
                    const InputDecoration(hintText: "Type a messgae...."),
                controller: _textEditingController,
              )),
              IconButton(
                  onPressed: () {
                    //final String message = _textEditingController.text;
                   // if (message.isNotEmpty) {
                      controller.sendMessage(
                           widget.currentUserId, widget.receiverId , _textEditingController.text);
                      _textEditingController.clear();
                   // }
                  },
                  icon: const Icon(Icons.send),
                  color: redColor)
            ]).box.height(60).padding(const EdgeInsets.all(12)).make()
          ],
        ),
      ),
    );
  }
}
