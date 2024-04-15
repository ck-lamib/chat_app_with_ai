import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:google_generative_ai_demo/chat_uis.dart';
import 'package:google_generative_ai_demo/controller/chat_controller.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyAppView(),
    );
  }
}

class MyAppView extends StatelessWidget {
  MyAppView({super.key});
  final ChatController c = Get.put(ChatController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text("This is demo ai app"),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Obx(
              () => ListView.builder(
                itemCount: c.chatMessages.length,
                shrinkWrap: true,
                reverse: true,
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                physics: const AlwaysScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Container(
                    padding: const EdgeInsets.only(
                        left: 14, right: 14, top: 10, bottom: 10),
                    child: Align(
                      alignment: (c.chatMessages[index].messageType ==
                                  MessageType.receiver ||
                              c.chatMessages[index].messageType ==
                                  MessageType.receiverLoading
                          ? Alignment.topLeft
                          : Alignment.topRight),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: (c.chatMessages[index].messageType ==
                                      MessageType.receiver ||
                                  c.chatMessages[index].messageType ==
                                      MessageType.receiverLoading
                              ? Colors.grey.shade200
                              : Colors.blue[200]),
                        ),
                        padding: const EdgeInsets.all(16),
                        child: c.chatMessages[index].messageType ==
                                MessageType.receiverLoading
                            ? LoadingAnimationWidget.staggeredDotsWave(
                                color: const Color(0xFF1A1A3F),
                                size: 20,
                              )
                            : Text(
                                c.chatMessages[index].messageContent,
                                style: const TextStyle(fontSize: 15),
                              ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(360),
            clipBehavior: Clip.antiAlias,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.2),
                borderRadius: BorderRadius.circular(360),
              ),
              clipBehavior: Clip.antiAlias,
              margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              padding: const EdgeInsets.only(
                left: 10,
                right: 5,
              ),
              child: Row(
                children: <Widget>[
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        color: Colors.lightBlue,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: TextField(
                      controller: c.textEditingController,
                      decoration: InputDecoration(
                        hintText: "Write message...",
                        hintStyle: TextStyle(color: Colors.black54),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  SizedBox(
                    height: 40,
                    width: 40,
                    child: FloatingActionButton(
                      shape: const CircleBorder(),
                      onPressed: () {
                        c.sendMessage(c.textEditingController.text);
                      },
                      backgroundColor: Colors.blue,
                      elevation: 0,
                      child: const Icon(
                        Icons.send,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
