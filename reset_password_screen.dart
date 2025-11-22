import 'package:flutter/material.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final emailCtrl = TextEditingController();

  @override
  void dispose() {
    emailCtrl.dispose();
    super.dispose();
  }

  Future<void> _showAlert(String title, String message) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext ctx) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: () => Navigator.of(ctx).pop(),
            )
          ],
        );
      },
    );
  }

  void _onSendPressed() {
    final email = emailCtrl.text.trim();

    if (email.isEmpty) {
      _showAlert('Помилка', 'Введіть логін або email.');
      return;
    }

    // Демонстраційна поведінка: показуємо діалог і повертаємось.
    _showAlert('Інструкція відправлена', 'На вказаний email надіслано інструкції з відновлення пароля (приклад).')
        .then((_) => Navigator.of(context).pop());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Відновлення паролю'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            TextField(
              controller: emailCtrl,
              decoration: const InputDecoration(
                labelText: 'Логін або Email',
              ),
            ),
            const SizedBox(height: 25),
            ElevatedButton(
              onPressed: _onSendPressed,
              child: const Text('Надіслати інструкцію'),
            ),
            const SizedBox(height: 8),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Повернутись до входу'),
            ),
          ],
        ),
      ),
    );
  }
}
