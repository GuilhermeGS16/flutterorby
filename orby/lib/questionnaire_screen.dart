import 'package:flutter/material.dart';
import 'questioncard_screen.dart';
import 'ineligibility_screen.dart';

const Color kPrimaryRed = Color(0xFFCD3232);

class QuestionnaireScreen extends StatelessWidget {
  const QuestionnaireScreen({super.key});

  Future<void> salvarRespostaFirestore({
    required String userId,
    required String pergunta,
    required String resposta,
    required bool apto,
  }) async {
    // tenho que implementar a parte de salvar o questionario no firebase
  }

  @override
  Widget build(BuildContext context) {
    const usuarioId = 'exemploDeID';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Questionário de aptidão'),
        backgroundColor: kPrimaryRed,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              QuestionCard(
                title: '1- Questionário exclusivo',
                subtitle: 'Algum destes tópicos se encaixa a você?',
                topics: const [
                  'Hepatite após os 11 anos de idade',
                  'Hepatites B e C, AIDS (vírus HIV), doenças associadas ao vírus HTLV 1 e 2 e Doença de Chagas',
                  'Uso de drogas ilícitas injetáveis',
                  'Malária',
                  'Doença de Parkinson',
                ],
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      await salvarRespostaFirestore(
                        userId: usuarioId,
                        pergunta: '1- Questionário exclusivo',
                        resposta: 'Sim',
                        apto: false,
                      );

                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => IneligibilityScreen(
                            onBackToHome: () => Navigator.pushNamedAndRemoveUntil(
                              context,
                              '/home',
                                  (route) => false,
                            ),
                            onNotifyYes: () {
                              // caso a pessoa queira receber notificações seguir
                            },
                            onNotifyNo: () {},
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kPrimaryRed,
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text(
                      'Sim',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  ),
                  const SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: () async {
                      await salvarRespostaFirestore(
                        userId: usuarioId,
                        pergunta: '1- Questionário exclusivo',
                        resposta: 'Não',
                        apto: true,
                      );

                      // Seguir com as proximas perguntas caso for necessário
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kPrimaryRed,
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text(
                      'Não',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
