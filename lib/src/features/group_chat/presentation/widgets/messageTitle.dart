import 'package:flutter/material.dart';

class MessageTile extends StatefulWidget {
  const MessageTile(
      {super.key,
      required this.message,
      required this.sender,
      required this.sendbyMe});
  final String message;
  final bool sendbyMe;
  final String sender;
  @override
  State<MessageTile> createState() => _MessageTileState();
}

class _MessageTileState extends State<MessageTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          top: 4,
          bottom: 4,
          left: widget.sendbyMe ? 0 : 24,
          right: widget.sendbyMe ? 24 : 0),
      alignment: widget.sendbyMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
          margin: widget.sendbyMe
              ? const EdgeInsets.only(left: 30)
              : const EdgeInsets.only(right: 30),
          padding:
              const EdgeInsets.only(top: 17, bottom: 17, left: 20, right: 20),
          decoration: BoxDecoration(
              borderRadius: widget.sendbyMe
                  ? const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                    )
                  : const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                      bottomRight: Radius.circular(20)),
              color: widget.sendbyMe ? Colors.pinkAccent[400] : Colors.grey),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(widget.message,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16, color: Colors.white)),
            const SizedBox(height: 6),
            Text(
              widget.sender.toUpperCase(),
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: -0.2),
            ),
          ])),
    );
  }
}
