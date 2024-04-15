import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:google_generative_ai_demo/api_key.dart';
import 'package:google_generative_ai_demo/chat_uis.dart';

class ChatController extends GetxController {
  final model = GenerativeModel(model: 'gemini-pro', apiKey: apiKey);
  final RxList<ChatMessage> _chatMessages = RxList([
    ChatMessage(
      messageContent: "Hey! What's up ask me smth.",
      messageType: MessageType.receiver,
    ),
  ]);
  TextEditingController textEditingController = TextEditingController();

  List<ChatMessage> get chatMessages => _chatMessages.reversed.toList();

  sendMessage(String query) async {
    if (query.isNotEmpty) {
      textEditingController.clear();
      ChatMessage senderMessage =
          ChatMessage(messageContent: query, messageType: MessageType.sender);
      _chatMessages.add(senderMessage);
      await askModel(query);
    }
  }

  var isLoading = false.obs;
  askModel(String query) async {
    addLoadingMessage();
    try {
      final prompt = query;
      final content = [Content.text(prompt)];
      final response = await model.generateContent(content,
          generationConfig: GenerationConfig());
      if (response.text != null && response.text!.isNotEmpty) {
        _chatMessages.add(
          ChatMessage(
            messageContent: response.text!,
            messageType: MessageType.receiver,
          ),
        );
      }
      removeLoadingMessage();
    } catch (e) {
      removeLoadingMessage();
    }
  }

  removeLoadingMessage() {
    _chatMessages.removeWhere(
        (element) => element.messageType == MessageType.receiverLoading);
  }

  addLoadingMessage() {
    _chatMessages.add(
      ChatMessage(
        messageContent: "messageContent",
        messageType: MessageType.receiverLoading,
      ),
    );
  }
}
