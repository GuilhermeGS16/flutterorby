import 'package:flutter/material.dart';
import 'news_detail_screen.dart';

const Color kPrimaryRed = Color(0xFFCD3232);

class NewsScreen extends StatelessWidget {
  const NewsScreen({super.key});

  final List<Map<String, String>> news = const [
    {
      'title': 'Campanha de doação de sangue salva vidas em BH',
      'date': '20 de junho de 2025',
      'content': 'Mais de 500 bolsas de sangue foram coletadas durante a campanha promovida pela PUC Minas e hemocentros da cidade.'
    },
    {
      'title': 'Tecnologia aproxima doadores e hemocentros com o Orby',
      'date': '15 de junho de 2025',
      'content': 'O aplicativo Orby facilita o agendamento e acompanhamento da doação, além de incentivar com recompensas e rankings.'
    },
    {
      'title': 'Importância da doação em tempos de pandemia',
      'date': '10 de junho de 2025',
      'content': 'Mesmo com as dificuldades trazidas pela pandemia, os hemocentros reforçam o pedido para que os doadores mantenham as doações em dia.'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notícias'),
        backgroundColor: kPrimaryRed,
        foregroundColor: Colors.white,
        elevation: 0,
        leading: BackButton(color: Colors.white),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: news.length,
        itemBuilder: (context, index) {
          final item = news[index];
          return InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => NewsDetailScreen(
                    title: item['title']!,
                    date: item['date']!,
                    content: item['content']!,
                  ),
                ),
              );
            },
            child: Card(
              margin: const EdgeInsets.only(bottom: 16),
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item['title']!,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: kPrimaryRed,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      item['date']!,
                      style: const TextStyle(
                        fontSize: 14,
                        fontStyle: FontStyle.italic,
                        color: Colors.black54,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      item['content']!,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 15,
                        height: 1.4,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
