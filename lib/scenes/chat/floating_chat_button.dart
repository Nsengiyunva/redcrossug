import 'package:flutter/material.dart';
import 'package:redcross/scenes/chat/conversation_list_screen.dart';
import 'package:redcross/utils/colors.dart';

class FloatingChatButton extends StatelessWidget {
  const FloatingChatButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 16,
      bottom: 16,
      child: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ConversationListScreen(),
            ),
          );
        },
        backgroundColor: AppColors.primaryRedColor,
        elevation: 6,
        child: const Icon(
          Icons.chat_bubble,
          color: Colors.white,
          size: 28,
        ),
      ),
    );
  }
}
