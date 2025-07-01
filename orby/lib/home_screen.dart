import 'package:flutter/material.dart';
import 'profile_screen.dart';
import 'map_screen.dart';
import 'ranking_screen.dart';
import 'questionnaire_screen.dart';
import 'faq_screen.dart';
import 'partners_screen.dart';
import 'news_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomeContent(),
    const QuestionnaireScreen(),
    const RankingScreen(),
    const MapScreen(),
    const ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFFCD3232),
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.description), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.emoji_events), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.location_on), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
        ],
      ),
    );
  }
}

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 24.0),
            child: Text(
              'Bem vindo de volta!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFFCD3232),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 16.0,
              mainAxisSpacing: 16.0,
              children: [
                _GridMenuItem(
                  title: 'Sobre nós',
                  imagePath: 'assets/images/orby_logo.png',
                  onTap: () => Navigator.pushNamed(context, '/about'),
                ),
                _GridMenuItem(
                  title: 'Notícias',
                  imagePath: 'assets/images/news.png',
                  onTap: () => Navigator.pushNamed(context, '/news'),
                ),
                _GridMenuItem(
                  title: 'Fórum',
                  imagePath: 'assets/images/forum.png',
                  onTap: () => Navigator.pushNamed(context, '/forum'),
                ),
                _GridMenuItem(
                  title: 'Patrocinadores',
                  imagePath: 'assets/images/patrocinio.png',
                  onTap: () => Navigator.pushNamed(context, '/partners'),
                ),
                _GridMenuItem(
                  title: 'Tipos Sanguíneos',
                  imagePath: 'assets/images/sangue.png',
                  onTap: () => Navigator.pushNamed(context, '/blood'),
                ),
                _GridMenuItem(
                  title: 'Dúvidas',
                  imagePath: 'assets/images/info.png',
                  onTap: () => Navigator.pushNamed(context, '/faqscreen'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

class _GridMenuItem extends StatelessWidget {
  final String title;
  final String imagePath;
  final VoidCallback? onTap;

  const _GridMenuItem({
    required this.title,
    required this.imagePath,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              imagePath,
              width: 80,
              height: 80,
            ),
            const SizedBox(height: 8),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Color(0xFF505050),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
