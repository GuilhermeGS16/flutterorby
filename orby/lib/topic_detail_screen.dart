import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

const Color kPrimaryRed = Color(0xFFCD3232);

class TopicDetailScreen extends StatefulWidget {
  final String topicId;
  final String topicTitle;

  const TopicDetailScreen({
    super.key,
    required this.topicId,
    required this.topicTitle,
  });

  @override
  State<TopicDetailScreen> createState() => _TopicDetailScreenState();
}

class _TopicDetailScreenState extends State<TopicDetailScreen> {
  final TextEditingController _commentController = TextEditingController();

  Future<void> _addComment() async {
    final text = _commentController.text.trim();
    if (text.isEmpty) return;

    final user = FirebaseAuth.instance.currentUser;
    final authorName = user?.displayName ?? 'Anônimo';
    final authorPhoto = user?.photoURL ?? '';

    final commentsCol = FirebaseFirestore.instance
        .collection('topics')
        .doc(widget.topicId)
        .collection('comments');

    await commentsCol.add({
      'text': text,
      'timestamp': FieldValue.serverTimestamp(),
      'authorName': authorName,
      'authorPhoto': authorPhoto,
    });

    _commentController.clear();
    FocusScope.of(context).unfocus();
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final topicStream = FirebaseFirestore.instance
        .collection('topics')
        .doc(widget.topicId)
        .snapshots();

    final commentsStream = FirebaseFirestore.instance
        .collection('topics')
        .doc(widget.topicId)
        .collection('comments')
        .orderBy('timestamp')
        .snapshots();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.topicTitle),
        backgroundColor: kPrimaryRed,
      ),
      body: Column(
        children: [
          // Cabeçalho com autor e data de criação
          StreamBuilder<DocumentSnapshot>(
            stream: topicStream,
            builder: (context, snap) {
              if (!snap.hasData || snap.data!.data() == null) {
                return const SizedBox.shrink();
              }
              final data = snap.data!.data() as Map<String, dynamic>;

              final author = data['authorName'] is String
                  ? data['authorName'] as String
                  : 'Anônimo';
              final photoUrl = data['authorPhoto'] is String
                  ? data['authorPhoto'] as String
                  : '';
              String dateString = '';
              if (data['createdAt'] is Timestamp) {
                dateString = DateFormat('dd/MM/yyyy HH:mm')
                    .format((data['createdAt'] as Timestamp).toDate());
              }

              return ListTile(
                contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                leading: photoUrl.isNotEmpty
                    ? CircleAvatar(backgroundImage: NetworkImage(photoUrl))
                    : const CircleAvatar(child: Icon(Icons.person)),
                title: Text(author,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: dateString.isNotEmpty
                    ? Text(dateString,
                    style:
                    const TextStyle(fontSize: 12, color: Colors.grey))
                    : null,
              );
            },
          ),
          const Divider(height: 1),
          // Lista de comentários
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: commentsStream,
              builder: (context, snap) {
                if (snap.hasError) {
                  return Center(child: Text('Erro: ${snap.error}'));
                }
                if (!snap.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }
                final comments = snap.data!.docs;
                if (comments.isEmpty) {
                  return const Center(child: Text('Seja o primeiro a comentar!'));
                }
                return ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: comments.length,
                  separatorBuilder: (_, __) => const Divider(),
                  itemBuilder: (context, i) {
                    final doc = comments[i].data() as Map<String, dynamic>;
                    final text = doc['text'] as String? ?? '';
                    final author = doc['authorName'] as String? ?? 'Anônimo';
                    final photoUrl = doc['authorPhoto'] as String? ?? '';
                    String date = '';
                    if (doc['timestamp'] is Timestamp) {
                      date = DateFormat('dd/MM/yyyy HH:mm')
                          .format((doc['timestamp'] as Timestamp).toDate());
                    }
                    return ListTile(
                      leading: photoUrl.isNotEmpty
                          ? CircleAvatar(backgroundImage: NetworkImage(photoUrl))
                          : const CircleAvatar(child: Icon(Icons.person)),
                      title: Text(author,
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(text),
                          if (date.isNotEmpty)
                            Padding(
                              padding: const EdgeInsets.only(top: 4),
                              child: Text(date,
                                  style: const TextStyle(
                                      fontSize: 12, color: Colors.grey)),
                            ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
          // Input de novo comentário
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _commentController,
                    decoration: const InputDecoration(
                        hintText: 'Adicionar comentário...',
                        border: OutlineInputBorder()),
                    minLines: 1,
                    maxLines: 3,
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kPrimaryRed,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 14),
                  ),
                  onPressed: _addComment,
                  child: const Text('Enviar'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
