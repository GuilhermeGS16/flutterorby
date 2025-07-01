import 'package:flutter/material.dart';

const Color kPrimaryRed = Color(0xFFCD3232);

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: kPrimaryRed),
        title: Row(
          children: [
            const Text(
              'ORBY',
              style: TextStyle(
                color: kPrimaryRed,
                fontWeight: FontWeight.bold,
                fontSize: 20,
                letterSpacing: 2,
              ),
            ),
            const SizedBox(width: 5),
            Image.asset(
              'assets/images/orby_logo.png',
              height: 24,
            ),
          ],
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          children: const [
            SizedBox(height: 10),
            Text(
              'Sobre nós',
              style: TextStyle(
                fontSize: 18,
                color: kPrimaryRed,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 15),
            Text(
              'Bem-vindo ao Orby, uma iniciativa movida pela paixão por salvar vidas através da doação de sangue e da conexão humana. Somos um grupo universitário da PUC Minas em Belo Horizonte que compartilha um único objetivo: aumentar o número de doações de sangue e incentivar positivamente todos os envolvidos.',
              style: TextStyle(height: 1.5),
            ),
            SizedBox(height: 15),
            Text(
              'Nossa história começa com a crença de que cada doação de sangue tem o poder de salvar vidas. A ideia surgiu em meio a um cenário preocupante de baixos estoques nos hemocentros e da falta de informação e conscientização. Nós nos unimos com o sentimento de solidariedade e com o desejo de fazer a diferença. O Orby nasceu como uma ferramenta prática e envolvente, com o compromisso de ajudar os hemocentros a se comunicarem melhor com os doadores e criar uma experiência acolhedora e eficiente.',
              style: TextStyle(height: 1.5),
            ),
            SizedBox(height: 15),
            Text(
              'Com o Orby, nossa missão é tornar a doação de sangue uma experiência acessível e significativa. Desenvolvemos um aplicativo que conecta doadores e hemocentros, oferece recompensas, rankings, fóruns de ajuda e permite criar um perfil de doador, criando uma rede ativa e solidária. O Orby é uma extensão do espírito universitário, da vontade de ajudar e de usar a tecnologia como ponte para transformar realidades. Nosso desejo é que você também faça parte dessa história e se junte à comunidade Orby em favor da vida!',
              style: TextStyle(height: 1.5),
            ),
            SizedBox(height: 15),
            Text(
              'Nosso aplicativo oferece uma variedade de funcionalidades: localização de hemocentros, agendamento de doações, notificações personalizadas, gamificação, entre outras. Tudo isso pensado para motivar, informar e facilitar a jornada do doador.',
              style: TextStyle(height: 1.5),
            ),
            SizedBox(height: 15),
            Text(
              'A equipe do Orby é composta por estudantes apaixonados por inovação e impacto social. Colaboramos com especialistas da área da saúde e contamos com o apoio de professores, parceiros e doadores que acreditam na nossa missão. Queremos inspirar outras pessoas a se tornarem doadoras e mostrar que, com pequenos gestos, podemos salvar vidas. A doação de sangue é um ato de amor e empatia, e nós estamos aqui para lembrar disso todos os dias.',
              style: TextStyle(height: 1.5),
            ),
            SizedBox(height: 20),
            Text(
              'Obrigado por escolher o Orby.',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            Text(
              'Com gratidão e esperança,\nA equipe Orby.',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
