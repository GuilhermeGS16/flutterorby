import 'package:flutter/material.dart';

class IneligibilityScreen extends StatelessWidget {
  final VoidCallback? onBackToHome;
  final VoidCallback? onNotifyYes;
  final VoidCallback? onNotifyNo;

  const IneligibilityScreen({
    super.key,
    this.onBackToHome,
    this.onNotifyYes,
    this.onNotifyNo,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/sad.png', height: 120),
                const SizedBox(height: 16),
                const Icon(Icons.close, color: Colors.white, size: 48),
                const SizedBox(height: 16),
                const Text(
                  'Vishh, que pena! Infelizmente você não está apto a doar sangue no momento.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Gostaria de ser notificado quando estiver apto a realizar a doação?',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: onNotifyYes,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                      ),
                      child: const Text('Sim'),
                    ),
                    const SizedBox(width: 16),
                    ElevatedButton(
                      onPressed: onNotifyNo,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                      ),
                      child: const Text('Não'),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                TextButton(
                  onPressed: onBackToHome,
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.grey.shade800,
                    backgroundColor: Colors.grey.shade300,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
                  child: const Text('Voltar para o início'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
