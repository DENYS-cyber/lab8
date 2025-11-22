import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final nameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();

  @override
  void dispose() {
    nameCtrl.dispose();
    emailCtrl.dispose();
    passCtrl.dispose();
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

  bool _isValidEmail(String s) {
    final emailRegex = RegExp(r"^[^\s@]+@[^\s@]+\.[^\s@]+$");
    return emailRegex.hasMatch(s);
  }

  void _onRegisterPressed() {
    final name = nameCtrl.text.trim();
    final email = emailCtrl.text.trim();
    final pass = passCtrl.text;

    if (name.isEmpty) {
      _showAlert('Помилка', 'Введіть імʼя користувача.');
      return;
    }
    if (email.isEmpty) {
      _showAlert('Помилка', 'Введіть email або логін.');
      return;
    }
    // Якщо хочеш обов'язково перевіряти формат email:
    if (!_isValidEmail(email)) {
      _showAlert('Помилка', 'Невірний формат email.');
      return;
    }
    if (pass.isEmpty) {
      _showAlert('Помилка', 'Введіть пароль.');
      return;
    }
    if (pass.length < 6) {
      _showAlert('Помилка', 'Пароль має містити принаймні 6 символів.');
      return;
    }

    // Успіх (демо)
    _showAlert('Успіх', 'Реєстрація пройшла успішно (приклад).')
        .then((_) {
      // після успіху повертаємось до екрану входу
      Navigator.of(context).pop();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Реєстрація'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            TextField(
              controller: nameCtrl,
              decoration: const InputDecoration(
                labelText: 'Імʼя користувача',
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: emailCtrl,
              decoration: const InputDecoration(
                labelText: 'Email',
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: passCtrl,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Пароль',
              ),
            ),
            const SizedBox(height: 25),
            ElevatedButton(
              onPressed: _onRegisterPressed,
              child: const Text('Зареєструватись'),
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
