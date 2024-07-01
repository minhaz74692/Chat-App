// ignore_for_file: prefer_const_constructors, prefer_is_empty

import 'package:chat_app/screens/apps_colors.dart';
import 'package:chat_app/screens/chat/chat_model.dart';
import 'package:chat_app/screens/chat/widgets/chat_app-bar.dart';
import 'package:chat_app/screens/chat/widgets/chat_box.dart';
import 'package:chat_app/screens/custom_text_field.dart';
import 'package:chat_app/utils/necessary_methods.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

// import 'package:web_socket_channel/status.dart' as status;

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();

  late final GenerativeModel _model;
  late final ChatSession _chat;
  // final ScrollController _scrollController = ScrollController();
  final FocusNode _textFieldFocus = FocusNode(debugLabel: 'TextField');
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _model = GenerativeModel(
      model: 'gemini-pro',
      apiKey: dotenv.env['APIKEY'] ?? '',
    );
    _chat = _model.startChat();
  }

  // void _scrollDown() {
  //   WidgetsBinding.instance.addPostFrameCallback(
  //     (_) => _scrollController.animateTo(
  //       _scrollController.position.maxScrollExtent,
  //       duration: const Duration(
  //         milliseconds: 750,
  //       ),
  //       curve: Curves.easeOutCirc,
  //     ),
  //   );
  // }

  final List<ChatModel> _messages = [];

  void _sendMessage() {
    // String generateRandomString(int length) {
    //   const characters =
    //       'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    //   Random random = Random();
    //   return String.fromCharCodes(Iterable.generate(
    //     length,
    //     (_) => characters.codeUnitAt(random.nextInt(characters.length)),
    //   ));
    // }

    // setState(() {
    //   _messages.insert(
    //     0,
    //     ChatModel(
    //       senderId: generateRandomString(10),
    //       senderName: "senderNmae",
    //       receiverId: generateRandomString(10),
    //       receiverName: "receiverName",
    //       sendDateTime: DateTime.now(),
    //       message: _controller.text,
    //     ),
    //   );
    // });

    _controller.clear();
  }

  @override
  void dispose() {
    // _channel?.sink.close(status.goingAway);
    _controller.dispose();
    super.dispose();
  }

  void _showError(String message) {
    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Something went wrong'),
          content: SingleChildScrollView(
            child: Text(message),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            )
          ],
        );
      },
    );
  }

  Future<void> _sendChatMessage(String message) async {
    setState(() {
      _loading = true;
    });
    _controller.clear();
    FocusScope.of(context).unfocus();

    try {
      final response = await _chat.sendMessage(
        Content.text(message),
      );
      final text = response.text;

      if (text == null) {
        _showError('Empty response.');
        return;
      } else {
        setState(() {
          _loading = false;
          // _scrollDown();
        });
      }
    } catch (e) {
      _showError(e.toString());
      setState(() {
        _loading = false;
      });
    } finally {
      _controller.clear();
      setState(() {
        _loading = false;
      });
      _textFieldFocus.requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    final chatHistory = _chat.history.toList().reversed.toList();
    return Scaffold(
      backgroundColor: AppColors.boxColor2,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: SizedBox.shrink(),
        flexibleSpace: FlexibleSpaceBar(
          title: ChatScreenAppBar(),
          titlePadding: EdgeInsets.all(0),
        ),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: CustomScrollView(
          slivers: [
            // SliverStickyHeader(
            //   sliver: SliverList(
            //     delegate: SliverChildBuilderDelegate(
            //       childCount: 1,
            //       (context, i) =>
            //     ),
            //   ),
            // ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: MediaQuery.of(context).size.height -
                    (160 + MediaQuery.of(context).padding.bottom),
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  itemCount: chatHistory.length,
                  reverse: true,
                  shrinkWrap: true,
                  // physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    bool showRight = index.isOdd;
                    // ChatModel message = _messages[index];
                    final text = chatHistory[index]
                        .parts
                        .whereType<TextPart>()
                        .map<String>((e) => e.text)
                        .join('');

                    return ChatBox(
                      showRight: showRight,
                      // message: message,
                      message: ChatModel(
                        senderId: "senderId",
                        senderName: "senderName",
                        receiverId: "receiverId",
                        receiverName: "receiverName",
                        sendDateTime: DateTime.now(),
                        message: text,
                      ),
                      // sameDate: false,
                      sameDate: index == _messages.length - 1
                          ? false
                          : NecessaryMethods.sameDateCheck(
                              // message.sendDateTime,
                              // _messages[index + 1].sendDateTime,
                              DateTime.now(),
                              DateTime.now(),
                            ),
                    );
                  },
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: _loading
                  ? Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                      child: ChatBox(
                        showRight: true,
                        sameDate: true,
                        message: ChatModel(
                            senderId: "senderId",
                            senderName: "senderName",
                            receiverId: "receiverId",
                            receiverName: "receiverName",
                            sendDateTime: DateTime.now(),
                            message: "Loading..."),
                      ),
                    )
                  : SizedBox.shrink(),
            ),
            SliverToBoxAdapter(
              child: Container(
                margin: EdgeInsets.only(
                  left: 12,
                  right: 12,
                  bottom: 5,
                  top: 5,
                ),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(60)),
                width: double.infinity,
                height: 60,
                // padding: EdgeInsets.symmetric(horizontal: 0),
                child: Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                        borderRadius: 60,
                        controller: _controller,
                        isShowBorder: false,
                        focusBorderColor: Colors.white,
                        enabledBorderColor: Colors.white,
                        fillColor: Colors.white,
                        hintText: "Type message",
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        // _sendMessage();
                        _sendChatMessage(_controller.text);
                      },
                      child: Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Icon(
                          Icons.send_rounded,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
