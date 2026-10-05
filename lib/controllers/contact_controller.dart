import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../core/constants/app_strings.dart';
import '../core/theme/app_colors.dart';

class ContactController extends GetxController {
  final formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final messageController = TextEditingController();

  final isLoading = false.obs;
  final isSuccess = false.obs;
  final errorMessage = ''.obs;

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    messageController.dispose();
    super.onClose();
  }

  Future<void> submitContactForm() async {
    final name = nameController.text.trim();
    final email = emailController.text.trim();
    final message = messageController.text.trim();

    if (name.isEmpty) {
      _showSnackbar(
        AppStrings.requiredField,
        AppStrings.enterNameError,
        isError: true,
      );
      return;
    }

    if (email.isEmpty || !GetUtils.isEmail(email)) {
      _showSnackbar(
        AppStrings.invalidEmailTitle,
        AppStrings.enterValidEmailError,
        isError: true,
      );
      return;
    }

    if (message.isEmpty) {
      _showSnackbar(
        AppStrings.requiredField,
        AppStrings.enterMessageError,
        isError: true,
      );
      return;
    }

    isLoading.value = true;
    errorMessage.value = '';
    isSuccess.value = false;

    try {
      await FirebaseFirestore.instance.collection('contacts').add({
        'name': name,
        'email': email,
        'message': message,
        'timestamp': FieldValue.serverTimestamp(),
        'createdAt': DateTime.now().toIso8601String(),
      });

      isSuccess.value = true;
      nameController.clear();
      emailController.clear();
      messageController.clear();

      _showSnackbar(
        AppStrings.success,
        AppStrings.contactSuccessMessage,
        isError: false,
      );
    } catch (e) {
      debugPrint('Firestore submission error: $e');
      errorMessage.value = e.toString();

      String userFriendlyMessage = e.toString();
      if (e.toString().contains('permission-denied')) {
        userFriendlyMessage = AppStrings.permissionDeniedError;
      } else if (e.toString().contains('API key') ||
          e.toString().contains('api-key') ||
          e.toString().contains('unauthorized') ||
          e.toString().contains('YourWebApiKeyPlaceholder')) {
        userFriendlyMessage = AppStrings.invalidApiKeyError;
      }

      _showSnackbar(
        AppStrings.submissionErrorTitle,
        userFriendlyMessage,
        isError: true,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void _showSnackbar(String title, String message, {required bool isError}) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: isError
          ? AppColors.redAccent.withValues(alpha: 0.9)
          : AppColors.green.withValues(alpha: 0.9),
      colorText: AppColors.white,
      margin: const EdgeInsets.all(16),
      borderRadius: 10,
      duration: const Duration(seconds: 5),
    );
  }
}
