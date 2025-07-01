import 'package:flutter/material.dart';

class FAQScreen extends StatelessWidget {
  const FAQScreen({super.key});

  final List<Map<String, String>> faqs = const [
    {
      'question': 'Como faço para doar sangue?',
      'answer':
      'Você pode ir até o banco de sangue mais próximo com um documento com foto e estar dentro dos critérios de doação.'
    },
    {
      'question': 'Com que frequência posso doar?',
      'answer':
      'Homens podem doar a cada 2 meses (máximo 4 vezes por ano), e mulheres a cada 3 meses (máximo 3 vezes por ano).'
    },
    {
      'question': 'Preciso estar em jejum?',
      'answer':
      'Não. É recomendado estar alimentado, evitando alimentos gordurosos nas 3 horas anteriores à doação.'
    },
    {
      'question': 'Menores de idade podem doar?',
      'answer': 'Sim, a partir de 16 anos, com autorização dos responsáveis.'
    },
    {
      'question': 'Quais documentos devo levar?',
      'answer': 'Um documento oficial com foto, como RG ou CNH.'
    },
    {
      'question': 'Doar sangue dói?',
      'answer':
      'A picada pode causar um pequeno desconforto, mas o processo é rápido e seguro.'
    },
    {
      'question': 'Quanto tempo dura a doação?',
      'answer':
      'A doação em si leva de 8 a 12 minutos. Todo o processo, incluindo triagem, dura cerca de 40 minutos a 1 hora.'
    },
    {
      'question': 'Quais são os impedimentos temporários para doar?',
      'answer':
      'Estar gripado, fazer tatuagem ou piercing recente, cirurgias recentes, entre outros. Consulte o banco de sangue.'
    },
    {
      'question': 'Posso doar se estiver amamentando?',
      'answer':
      'Não, mulheres que estão amamentando devem aguardar até 12 meses após o parto para doar.'
    },
  ];

  @override
  Widget build(BuildContext context) {
    const Color redBackground = Color(0xFFCD3232);

    return Scaffold(
      backgroundColor: redBackground,
      appBar: AppBar(
        backgroundColor: redBackground,
        title: const Text(
          'Dúvidas Frequentes',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Container(
        color: Colors.white,
        child: ListView.builder(
          itemCount: faqs.length,
          itemBuilder: (context, index) {
            return ExpansionTile(
              title: Text(
                faqs[index]['question']!,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(faqs[index]['answer']!),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
