import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> salvarResposta({
    required String userId,
    required String pergunta,
    required String resposta,
    required bool apto,
  }) async {

    await _db.collection('usuarios').doc(userId).collection('respostas').add({
      'pergunta': pergunta,
      'resposta': resposta,
      'apto': apto,
      'timestamp': FieldValue.serverTimestamp(),
    });


    if (!apto) {
      await _db.collection('usuarios').doc(userId).update({
        'apto': false,
      });
    }
  }

  Future<bool> isUsuarioApto(String userId) async {
    final doc = await _db.collection('usuarios').doc(userId).get();
    final data = doc.data();

    if (data == null) return true;
    return data['apto'] != false;
  }

  Future<void> setDesejaNotificacao(String userId, bool desejaNotificar) async {
    await _db.collection('usuarios').doc(userId).update({
      'desejaNotificacao': desejaNotificar,
    });
  }

  Future<void> resetarQuestionario(String userId) async {
    final respostas = await _db
        .collection('usuarios')
        .doc(userId)
        .collection('respostas')
        .get();

    for (final doc in respostas.docs) {
      await doc.reference.delete();
    }

    await _db.collection('usuarios').doc(userId).update({
      'apto': true,
    });
  }
}
