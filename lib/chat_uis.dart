import 'package:flutter/material.dart';

enum MessageType { receiver, sender, receiverLoading }

class ChatMessage {
  String messageContent;
  MessageType messageType;
  ChatMessage({
    required this.messageContent,
    required this.messageType,
  });
}

List<ChatMessage> messages = [
  ChatMessage(messageContent: "Hello, Will", messageType: MessageType.receiver),
  ChatMessage(
      messageContent: "How have you been?", messageType: MessageType.receiver),
  ChatMessage(
      messageContent: "Hey Kriss, I am doing fine dude. wbu?",
      messageType: MessageType.sender),
  ChatMessage(
      messageContent: "ehhhh, doing OK.", messageType: MessageType.receiver),
].reversed.toList();
