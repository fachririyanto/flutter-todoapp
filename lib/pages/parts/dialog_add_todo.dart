import 'package:flutter/material.dart';
import '../../utils/colors.dart';
import '../../widgets/textbox.dart';
import '../../widgets/button.dart';

class DialogAddTodo extends StatelessWidget {
  final TextEditingController todoNameController;
  final VoidCallback? onSave;
  final VoidCallback? onCancel;

  const DialogAddTodo({
    super.key,
    required this.todoNameController,
    required this.onSave,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Center(child: Text('Add Todo')),
      titleTextStyle: const TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        color: Colors.black,
      ),
      backgroundColor: Colors.white,
      elevation: 0,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(12),
        ),
      ),
      content: SizedBox(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 16),
              child: Textbox(
                controller: todoNameController,
                hintText: 'Todo name',
              ),
            ),
            Button(
              width: double.infinity,
              height: 48,
              text: 'Save',
              backgroundColor: AppColors.primary,
              textColor: AppColors.white,
              onPressed: onSave,
            ),
            Container(
              margin: const EdgeInsets.only(top: 8),
              child: Button(
                width: double.infinity,
                height: 48,
                text: 'Cancel',
                backgroundColor: AppColors.white,
                textColor: AppColors.primary,
                onPressed: onCancel,
              ),
            ),
          ],
        ),
      ),
      insetPadding: const EdgeInsets.all(0),
      titlePadding: const EdgeInsets.only(top: 40, bottom: 24),
      contentPadding: const EdgeInsets.only(left: 24, right: 24, bottom: 40),
    );
  }
}
