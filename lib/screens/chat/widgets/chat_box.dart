// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:chat_app/screens/apps_colors.dart';
import 'package:chat_app/screens/chat/chat_model.dart';
import 'package:chat_app/screens/text.style.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChatBox extends StatefulWidget {
  const ChatBox({
    super.key,
    required this.showRight,
    required this.message,
    required this.sameDate,
  });

  final bool showRight;
  final ChatModel message;
  final bool sameDate;

  @override
  State<ChatBox> createState() => _ChatBoxState();
}

class _ChatBoxState extends State<ChatBox> {
  bool clicked = false;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment:
          widget.showRight ? Alignment.centerRight : Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          crossAxisAlignment: widget.showRight
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
          children: [
            Visibility(
              visible: !widget.sameDate,
              child: Center(
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 12),
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                  constraints: BoxConstraints(
                    maxWidth: 140,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x0C11111A),
                        blurRadius: 32,
                        offset: Offset(0, 8),
                        spreadRadius: 0,
                      ),
                      BoxShadow(
                        color: Color(0x0C11111A),
                        blurRadius: 16,
                        offset: Offset(0, 4),
                        spreadRadius: 0,
                      )
                    ],
                  ),
                  child: Text(
                    DateFormat('d MMMM').format(widget.message.sendDateTime),
                  ),
                ),
              ),
            ),
            Text(
              DateFormat.jm().format(widget.message.sendDateTime),
              // "${widget.message.sendDateTime}",
            ),
            Container(
              constraints: BoxConstraints(maxWidth: 280),
              padding: EdgeInsets.symmetric(vertical: 12.5, horizontal: 16),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Color(0x0C11111A),
                    blurRadius: 32,
                    offset: Offset(0, 8),
                    spreadRadius: 0,
                  ),
                  BoxShadow(
                    color: Color(0x0C11111A),
                    blurRadius: 16,
                    offset: Offset(0, 4),
                    spreadRadius: 0,
                  )
                ],
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(24),
                  topLeft: Radius.circular(widget.showRight ? 24 : 0),
                  bottomRight: Radius.circular(widget.showRight ? 0 : 24),
                  bottomLeft: Radius.circular(24),
                ),
                color: widget.showRight ? AppColors.primaryColor : Colors.white,
              ),
              child: Text(
                widget.message.message,
                style: interStyle16_400.copyWith(
                  color: widget.showRight ? Colors.white : null,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
