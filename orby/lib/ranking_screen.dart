import 'package:flutter/material.dart';

void main() {
  runApp(const RankingApp());
}

class User {
  final String name;
  final String imageUrl;
  final int donations;
  final double rating;
  final int rank;
  final int followers;
  final String description;
  final String bloodType;

  User({
    required this.name,
    required this.imageUrl,
    required this.donations,
    required this.rating,
    required this.rank,
    required this.followers,
    required this.description,
    required this.bloodType,
  });
}

class RankingApp extends StatelessWidget {
  const RankingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ranking App',
      theme: ThemeData(
        primarySwatch: Colors.red,
        fontFamily: 'Roboto',
      ),
      home: const RankingScreen(),
    );
  }
}

class RankingScreen extends StatelessWidget {
  const RankingScreen({super.key});

  static final List<User> users = [
    User(
      name: 'Roberta Silva',
      imageUrl: 'assets/images/robertasilva.jpg',
      donations: 15,
      rating: 5.0,
      rank: 1,
      followers: 105,
      description: 'Doar é um ato de amor que salva vidas!',
      bloodType: 'A+',
    ),
    User(
      name: 'Isabela Duarte',
      imageUrl: 'assets/images/isabeladuarte.jpg',
      donations: 13,
      rating: 5.0,
      rank: 2,
      followers: 93,
      description: 'Faço o bem sem olhar a quem.',
      bloodType: 'B+',
    ),
    User(
      name: 'Sandra Quintarelli',
      imageUrl: 'assets/images/sandraquintarelli.jpg',
      donations: 12,
      rating: 5.0,
      rank: 3,
      followers: 87,
      description: 'Sou doadora há 5 anos com muito orgulho!',
      bloodType: 'O-',
    ),
    User(
      name: 'Elena Vidal',
      imageUrl: 'assets/images/elenavidal.jpeg',
      donations: 12,
      rating: 4.5,
      rank: 4,
      followers: 80,
      description: 'Ajudar o próximo me move todos os dias.',
      bloodType: 'AB+',
    ),
    User(
      name: 'Elisa Reis',
      imageUrl: 'assets/images/elisareis.jpg',
      donations: 10,
      rating: 4.0,
      rank: 5,
      followers: 75,
      description: 'A solidariedade corre nas minhas veias.',
      bloodType: 'A-',
    ),
    User(
      name: 'Lucas Ferreira',
      imageUrl: 'assets/images/lucasferreira.jpg',
      donations: 8,
      rating: 4.5,
      rank: 6,
      followers: 65,
      description: 'Amo doar sangue, é minha maior paixão poder ajudar o próximo',
      bloodType: 'O+',
    ),
    User(
      name: 'Sérgio Costa',
      imageUrl: 'assets/images/sergiocosta.jpg',
      donations: 7,
      rating: 4.0,
      rank: 7,
      followers: 59,
      description: 'Faço minha parte com orgulho!',
      bloodType: 'B-',
    ),
    User(
      name: 'Antonio Rocha',
      imageUrl: 'assets/images/antoniorocha.jpg',
      donations: 6,
      rating: 3.5,
      rank: 8,
      followers: 52,
      description: 'Ser útil é a melhor forma de viver.',
      bloodType: 'AB-',
    ),
    User(
      name: 'Augusto Oliveira',
      imageUrl: 'assets/images/augustooliveira.jpg',
      donations: 6,
      rating: 3.0,
      rank: 9,
      followers: 48,
      description: 'Ajudar quem precisa é um privilégio.',
      bloodType: 'O+',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final currentUser = users.firstWhere((user) => user.name == 'Lucas Ferreira');

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFFE53935),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {},
        ),
        title: const Column(
          children: [
            Text('Ranking', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20)),
            Text('Sua posição', style: TextStyle(color: Colors.white70, fontSize: 14)),
          ],
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          _buildCurrentUserCard(currentUser),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Ranking',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black54),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => UserProfileScreen(user: users[index])),
                    );
                  },
                  child: _buildRankingCard(context, users[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCurrentUserCard(User user) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      color: const Color(0xFFE53935),
      child: Row(
        children: [
          CircleAvatar(radius: 35, backgroundImage: AssetImage(user.imageUrl)),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(user.name, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
                const SizedBox(height: 4),
                _buildStars(user.rating, color: Colors.white, size: 20),
                const SizedBox(height: 4),
                Text('Doações: ${user.donations}', style: const TextStyle(color: Colors.white70, fontSize: 14)),
              ],
            ),
          ),
          Text('${user.rank}°', style: const TextStyle(color: Colors.white, fontSize: 60, fontWeight: FontWeight.w300)),
        ],
      ),
    );
  }

  Widget _buildRankingCard(BuildContext context, User user) {
    Color cardColor;
    Color rankColor;

    switch (user.rank) {
      case 1:
        cardColor = const Color(0xFFFBC02D);
        rankColor = Colors.white;
        break;
      case 2:
        cardColor = const Color(0xFFC0C0C0);
        rankColor = Colors.white;
        break;
      case 3:
        cardColor = const Color(0xFFCD7F32);
        rankColor = Colors.white;
        break;
      default:
        cardColor = Colors.white;
        rankColor = Colors.grey.shade600;
    }

    bool isCurrentUser = user.name == 'Lucas Ferreira' && user.rank > 3;

    return Card(
      elevation: isCurrentUser ? 4.0 : 2.0,
      margin: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 8.0),
      color: cardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        side: isCurrentUser ? BorderSide(color: Colors.red.shade300, width: 1.5) : BorderSide.none,
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            CircleAvatar(radius: 28, backgroundImage: AssetImage(user.imageUrl)),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(user.name,
                      style: TextStyle(
                        color: user.rank <= 3 ? Colors.white : Colors.black87,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      )),
                  const SizedBox(height: 4),
                  _buildStars(user.rating, color: user.rank <= 3 ? Colors.white : Colors.amber),
                  const SizedBox(height: 4),
                  Text('Doações: ${user.donations}',
                      style: TextStyle(
                        color: user.rank <= 3 ? Colors.white70 : Colors.black54,
                        fontSize: 13,
                      )),
                ],
              ),
            ),
            Text('${user.rank}°',
                style: TextStyle(
                  color: rankColor,
                  fontSize: 36,
                  fontWeight: FontWeight.w300,
                )),
            const SizedBox(width: 8),
          ],
        ),
      ),
    );
  }

  Widget _buildStars(double rating, {Color color = Colors.amber, double size = 18}) {
    List<Widget> stars = [];
    int fullStars = rating.floor();
    bool hasHalfStar = (rating - fullStars) >= 0.5;

    for (int i = 0; i < fullStars; i++) {
      stars.add(Icon(Icons.star, color: color, size: size));
    }

    if (hasHalfStar) {
      stars.add(Icon(Icons.star_half, color: color, size: size));
    }

    int emptyStars = 5 - stars.length;
    for (int i = 0; i < emptyStars; i++) {
      stars.add(Icon(Icons.star_border, color: color, size: size));
    }

    return Row(children: stars);
  }
}

class UserProfileScreen extends StatelessWidget {
  final User user;

  const UserProfileScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 250,
                decoration: BoxDecoration(
                  color: theme.primary,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(50),
                    bottomRight: Radius.circular(50),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(user.name, style: const TextStyle(fontSize: 28, color: Colors.white)),
                    const SizedBox(height: 4),
                    Text('Seguidores: ${user.followers}', style: const TextStyle(color: Colors.white70)),
                    const SizedBox(height: 20),
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 3),
                        image: DecorationImage(
                          image: AssetImage(user.imageUrl),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const Text('Avaliação', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  5,
                      (index) => Icon(
                    index < user.rating.floor()
                        ? Icons.star
                        : (user.rating - user.rating.floor() >= 0.5 && index == user.rating.floor()
                        ? Icons.star_half
                        : Icons.star_border),
                    color: Colors.amber,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  user.description,
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 20),
              const Text('Estatísticas', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: constraints.maxWidth > 400 ? 3 : 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      children: [
                        _StatCard(label: 'Maior posição no ranking:', value: '${user.rank}°'),
                        _StatCard(label: 'Doações totais:', value: '${user.donations}'),
                        _StatCard(label: 'Posição atual:', value: '${user.rank}°'),
                        _StatCard(label: 'Nota máx.:', value: '${user.rating}'),
                        _StatCard(label: 'Seguidores:', value: '${user.followers}'),
                        _StatCard(label: 'Tipo sanguíneo:', value: user.bloodType),
                      ],
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final String value;

  const _StatCard({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(label,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
            const SizedBox(height: 8),
            Text(value,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                )),
          ],
        ),
      ),
    );
  }
}
