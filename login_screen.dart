import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final loginCtrl = TextEditingController();
  final passCtrl = TextEditingController();

  @override
  void dispose() {
    loginCtrl.dispose();
    passCtrl.dispose();
    super.dispose();
  }

  Future<void> _showAlert(String title, String message) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // щоб натискання поза діалогом не закривало
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }

  void _onLoginPressed() {
    final login = loginCtrl.text.trim();
    final pass = passCtrl.text;

    if (login.isEmpty) {
      _showAlert('Помилка', 'Введіть логін.');
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

    // У реальному додатку тут виклик авторизації. Для лабораторної — показуємо підтвердження.
    _showAlert('Успіх', 'Вхід успішний (приклад).')
        .then((_) {
      // після підтвердження можна очистити поля
      loginCtrl.clear();
      passCtrl.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Авторизація'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Логотип / картинка за бажанням
            SizedBox(
              height: 140,
              child: Center(
                child: Image.asset(
                  'assets/flutter_logo.png',
                  width: 120,
                  height: 120,
                  fit: BoxFit.contain,
                  // Якщо не маєш картинки — додай placeholder або видали цей блок
                ),
              ),
            ),

            const SizedBox(height: 8),

            TextField(
              controller: loginCtrl,
              decoration: const InputDecoration(
                labelText: 'Логін або email',
              ),
            ),
            const SizedBox(height: 16),

            TextField(
              controller: passCtrl,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Пароль',
              ),
            ),
            const SizedBox(height: 24),

            ElevatedButton(
              onPressed: _onLoginPressed,
              child: const Text('Увійти'),
            ),

            const SizedBox(height: 12),

            OutlinedButton(
              onPressed: () => Navigator.of(context).pushNamed('/register'),
              child: const Text('Реєстрація'),
            ),

            const SizedBox(height: 8),

            TextButton(
              onPressed: () => Navigator.of(context).pushNamed('/reset'),
              child: const Text('Відновлення паролю'),
            ),
          ],
        ),
      ),
    );
  }
}
