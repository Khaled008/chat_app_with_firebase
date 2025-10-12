import 'package:chat_app_with_firebase/widgets/chat_messages.dart';
import 'package:chat_app_with_firebase/widgets/new_messages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  // Function to setup Push Notifications (messages)
  void setupupPushNotifications() async {
    final fcm = FirebaseMessaging.instance;
    await fcm.requestPermission();

    fcm.subscribeToTopic('chat');

    // you can send this token (via HTTP or the firebase sdk) to a backend
  }

  @override
  void initState() {
    super.initState();
    final fcm = FirebaseMessaging.instance;
    fcm.requestPermission();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Flutter Chat'),
        actions: [
          IconButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
            icon: Icon(
              Icons.exit_to_app,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ],
      ),
      body: Column(
        children: const [
          Expanded(
            child: ChatMessages(),
          ),
          NewMessages(),
        ],
      ),
    );
  }
}
