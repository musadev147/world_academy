import 'package:get/get.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../../../networks/repositories/discuss_repository.dart';
import 'package:flutter/material.dart';

class DiscussController extends GetxController {
  final DiscussRepository _repository = DiscussRepository();
  
  var isSending = false.obs;
  final TextEditingController messageController = TextEditingController();
  
  // Adding a reactive list of discussions to mimic real chat
  var discussions = <Map<String, dynamic>>[
    {
      'author': 'Student Name',
      'time': '2 hours ago',
      'content': 'Can someone explain the bullwhip effect again?',
      'replies': 3,
    },
    {
      'author': 'Instructor',
      'time': '5 hours ago',
      'content': 'Sure, it refers to the amplification of demand variability...',
      'replies': 1,
    },
  ].obs;

  Future<void> sendSms() async {
    final text = messageController.text.trim();
    if (text.isEmpty) return;

    isSending(true);
    // Hardcoded number based on the Postman collection
    final success = await _repository.sendSms('01796010084', text);
    
    if (success) {
      EasyLoading.showSuccess('Message Sent!');
      // Optimistically add it to the UI
      discussions.add({
        'author': 'Me',
        'time': 'Just now',
        'content': text,
        'replies': 0,
      });
      messageController.clear();
    } else {
      EasyLoading.showError('Failed to send message');
    }
    
    isSending(false);
  }

  @override
  void onClose() {
    messageController.dispose();
    super.onClose();
  }
}
