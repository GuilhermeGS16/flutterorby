import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'topic_detail_screen.dart';
import 'package:intl/intl.dart';

const Color kPrimaryRed = Color(0xFFCD3232);

class ForumScreen extends StatelessWidget {
  const ForumScreen({super.key});

  Future<void> _showNewTopicDialog(BuildContext context) async {
    final TextEditingController _titleController = TextEditingController();
    final TextEditingController _descController = TextEditingController();

    await showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Novo Tópico'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Título'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _descController,
              decoration: const InputDecoration(labelText: 'Descrição (opcional)'),
              maxLines: 3,
            ),
          ],
        ),
        actions: [
          TextButton(
            child: const Text('Cancelar'),
            onPressed: () => Navigator.of(ctx).pop(),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: kPrimaryRed),
            child: const Text('Criar'),
            onPressed: () async {
              final title = _titleController.text.trim();
              final desc = _descController.text.trim();
              if (title.isNotEmpty) {
                final user = FirebaseAuth.instance.currentUser;
                final authorName = user?.displayName ?? 'Anônimo';
                final authorPhoto = user?.photoURL ?? '';

                await FirebaseFirestore.instance.collection('topics').add({
                  'title': title,
                  'description': desc,
                  'authorName': authorName,
                  'authorPhoto': authorPhoto,
                  'createdAt': FieldValue.serverTimestamp(),
                });
                Navigator.of(ctx).pop();
              }
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fórum'),
        backgroundColor: kPrimaryRed,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('topics')
            .orderBy('createdAt', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) return Center(child: Text('Erro: ${snapshot.error}'));
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final topics = snapshot.data!.docs;
          if (topics.isEmpty) return const Center(child: Text('Nenhum tópico disponível.'));

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: topics.length,
            itemBuilder: (context, index) {
              final doc = topics[index];
              final topicId = doc.id;
              final title = (doc.data() as Map<String, dynamic>)['title'] as String? ?? 'Sem título';

              final data = doc.data() as Map<String, dynamic>;
              final author = data.containsKey('authorName') && data['authorName'] is String
                  ? data['authorName'] as String
                  : 'Anônimo';
              final photoUrl = data.containsKey('authorPhoto') && data['authorPhoto'] is String
                  ? data['authorPhoto'] as String
                  : '';
              String dateString = '';
              if (data.containsKey('createdAt') && data['createdAt'] is Timestamp) {
                final ts = data['createdAt'] as Timestamp;
                dateString = DateFormat('dd/MM/yyyy – HH:mm').format(ts.toDate());
              }

              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                elevation: 2,
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('topics')
                      .doc(topicId)
                      .collection('comments')
                      .snapshots(),
                  builder: (context, commSnap) {
                    final commentsCount = commSnap.hasData ? commSnap.data!.docs.length : 0;
                    return ListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      leading: photoUrl.isNotEmpty
                          ? CircleAvatar(backgroundImage: NetworkImage(photoUrl))
                          : const CircleAvatar(child: Icon(Icons.person)),
                      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('por $author'),
                          if (dateString.isNotEmpty)
                            Text(dateString, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                          Text('$commentsCount comentário${commentsCount == 1 ? '' : 's'}'),
                        ],
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => TopicDetailScreen(
                              topicId: topicId,
                              topicTitle: title,
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: kPrimaryRed,
        child: const Icon(Icons.add),
        onPressed: () => _showNewTopicDialog(context),
      ),
    );
  }
}
