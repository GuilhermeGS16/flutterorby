import 'package:flutter/material.dart';

const Color kPrimaryRed = Color(0xFFCD3232);

class PartnersScreen extends StatelessWidget {
  const PartnersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Patrocinadores'),
        backgroundColor: kPrimaryRed,
        foregroundColor: Colors.white,
        elevation: 0,
        leading: BackButton(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: ListView(
          children: const [
            Text(
              'A Fundação Centro de Hematologia e Hemoterapia do Estado de Minas Gerais é a fundação responsável pela saúde relacionada à hematologia e à hemoterapia em Minas Gerais.',
              style: TextStyle(
                fontSize: 16,
                height: 1.5,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'A Pontifícia Universidade Católica de Minas Gerais é uma instituição de ensino superior, privada e católica brasileira situada em Belo Horizonte, capital do estado de Minas Gerais.',
              style: TextStyle(
                fontSize: 16,
                height: 1.5,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 30),
            Text(
              'Banco de Sangue de Uberlândia – Hemominas: atende toda a região do Triângulo Mineiro e Alto Paranaíba.',
              style: TextStyle(
                fontSize: 16,
                height: 1.5,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Banco de Sangue de Juiz de Fora – Hemonúcleo: referência para doações na Zona da Mata Mineira.',
              style: TextStyle(
                fontSize: 16,
                height: 1.5,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Banco de Sangue de Montes Claros – Hemominas: atende o Norte de Minas com campanhas periódicas.',
              style: TextStyle(
                fontSize: 16,
                height: 1.5,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Banco de Sangue de Governador Valadares – HemoRegional: importante polo de coleta na região do Rio Doce.',
              style: TextStyle(
                fontSize: 16,
                height: 1.5,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Banco de Sangue de Poços de Caldas – Hemonúcleo: realiza doações em parceria com a Urcamp.',
              style: TextStyle(
                fontSize: 16,
                height: 1.5,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Banco de Sangue de Ipatinga – Hemominas: referência para o Vale do Aço e região.',
              style: TextStyle(
                fontSize: 16,
                height: 1.5,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
