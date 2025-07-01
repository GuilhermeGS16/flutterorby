import 'package:flutter/material.dart';

class TermsScreen extends StatelessWidget {
  const TermsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Termos e Condições',style: TextStyle(color: Colors.white),),
        backgroundColor: const Color(0xFFCD3232),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: RichText(
            text: const TextSpan(
              style: TextStyle(
                fontSize: 16,
                height: 1.5,
                color: Colors.black,
              ),
              children: [
                TextSpan(
                  text: 'Termos e Condições\n\n',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                TextSpan(
                  text: 'Última atualização: 23/05/2025\n\n'
                      'Bem-vindo ao Orby! Ao utilizar nosso aplicativo, você concorda com os seguintes termos e condições. Leia atentamente antes de utilizar nossos serviços.\n\n'
                      '1. Objetivo do Orby\n\n'
                      'O Orby é uma plataforma digital com o objetivo de incentivar a doação de sangue, oferecendo uma experiência gamificada e interativa. Nosso intuito é aumentar a conscientização e o número de doações voluntárias, conectando usuários a bancos de sangue, como o Hemominas, e promovendo o engajamento por meio de rankings, fóruns e recompensas simbólicas.\n\n'
                      '2. Cadastro e Responsabilidades do Usuário\n\n'
                      'Ao se cadastrar no Orby, o usuário declara fornecer informações verdadeiras e atualizadas.\n\n'
                      'O uso do Orby é destinado a maiores de 18 anos ou menores com autorização dos responsáveis legais.\n\n'
                      'O usuário se compromete a respeitar outros membros da comunidade nos fóruns e interações públicas.\n\n'
                      '3. Uso das Informações\n\n'
                      'O Orby pode coletar dados fornecidos voluntariamente pelo usuário, como nome, e-mail, localidade e histórico de doações, com o intuito de melhorar a experiência na plataforma.\n\n'
                      'As informações podem ser compartilhadas com bancos de sangue parceiros exclusivamente para fins de agendamento e controle de doações.\n\n'
                      'Nenhum dado pessoal será comercializado ou utilizado para fins não relacionados à proposta da plataforma.\n\n'
                      '4. Gamificação e Recompensas\n\n'
                      'O sistema de rankings, conquistas e recompensas é simbólico e tem caráter motivacional.\n\n'
                      'As recompensas não possuem valor monetário e são utilizadas apenas dentro do ambiente da plataforma.\n\n'
                      '5. Conteúdo dos Fóruns\n\n'
                      'Os fóruns do Orby são espaços para troca de experiências, dúvidas e incentivo à doação.\n\n'
                      'Não é permitido o compartilhamento de conteúdos ofensivos, discriminatórios, falsos ou que infrinjam a legislação vigente.\n\n'
                      '6. Modificações e Encerramento\n\n'
                      'O Orby se reserva o direito de modificar os termos a qualquer momento, notificando os usuários com antecedência.\n\n'
                      'A plataforma pode ser descontinuada, temporária ou permanentemente, a qualquer momento, mediante aviso prévio.\n\n'
                      '7. Disposições Gerais\n\n'
                      'O uso do Orby está sujeito às leis brasileiras.\n\n'
                      'Qualquer disputa relacionada ao uso da plataforma será resolvida no foro da comarca de Belo Horizonte - MG.\n\n'
                      'Ao utilizar o Orby, você concorda com estes termos. Caso não concorde, recomendamos que não utilize a plataforma.',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

