import 'package:flutter/material.dart';
import 'ineligibility_screen.dart';

class QuestionCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final List<String> topics;

  const QuestionCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.topics,
  });

  @override
  Widget build(BuildContext context) {
    final topicLabels = ['A', 'B', 'C', 'D', 'E'];
    const redColor = Color(0xFFCD3232);

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            subtitle,
            style: const TextStyle(
              fontSize: 14,
              color: redColor,
            ),
          ),
          const SizedBox(height: 16),
          ...List.generate(topics.length, (index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: RichText(
                text: TextSpan(
                  style: const TextStyle(color: Colors.black, fontSize: 15),
                  children: [
                    const TextSpan(
                      text: '',
                    ),
                    TextSpan(
                      text: '${topicLabels[index]} - ',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: redColor,
                      ),
                    ),
                    TextSpan(text: topics[index]),
                  ],
                ),
              ),
            );
          }),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
