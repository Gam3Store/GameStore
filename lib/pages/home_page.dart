import 'package:flutter/material.dart';
import 'package:gamestore/main.dart';
import 'package:gamestore/services/auth_service.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

final List<String> imagePaths = [
  "assets/header.jpg",
  "assets/header1.jpg",
  "assets/header2.jpg"
];

class _HomePageState extends State<HomePage> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_pageController.page! < imagePaths.length - 1) {
      _pageController.nextPage(
          duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
    }
  }

  void _previousPage() {
    if (_pageController.page! > 0) {
      _pageController.previousPage(
          duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('GAMESTORE'),
          backgroundColor: const Color.fromARGB(255, 54, 67, 211),
          actions: [
            IconButton(
                onPressed: null, icon: const Icon(Icons.search, size: 30)),
            IconButton(
                onPressed: null, icon: const Icon(Icons.account_circle, size: 30)),
          ],
        ),
        body: Column(
          children: [
            // Slider de imagens
            SizedBox(
              width: double.infinity,
              height: MediaQuery.of(context).size.height / 2.5,
              child: GestureDetector(
                onTapUp: (details) {
                  double screenWidth = MediaQuery.of(context).size.width;
                  if (details.localPosition.dx < screenWidth / 2) {
                    _previousPage(); // Clique na esquerda -> Volta
                  } else {
                    _nextPage(); // Clique na direita -> Avança
                  }
                },
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: imagePaths.length,
                  itemBuilder: (context, index) {
                    return ImagePlaceholder(imagePath: imagePaths[index]);
                  },
                ),
              ),
            ),

            // Sessão com Ícones e Textos
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InfoCard(
                    icon: Icons.local_shipping,
                    title: "Frete Grátis",
                    subtitle: "Compras acima de R\$100,00",
                  ),
                  InfoCard(
                    icon: Icons.lock,
                    title: "Pagamento Seguro",
                    subtitle: "100 secure payment",
                  ),
                  InfoCard(
                    icon: Icons.autorenew,
                    title: "Fácil reembolso",
                    subtitle: "até 10 dias úteis",
                  ),
                  InfoCard(
                    icon: Icons.headset_mic,
                    title: "Suporte 24 horas",
                    subtitle: "Entre em contato a qualquer hora",
                  ),
                ],
              ),
            ),

            Padding(
              padding: EdgeInsets.all(24.0),
              child: OutlinedButton(
                onPressed: () => context.read<AuthService>().logout(), 
                style: OutlinedButton.styleFrom(backgroundColor: const Color.fromARGB(255, 255, 165, 158), ) ,
                child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.check),
                        Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Text(
                            'sair',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ],
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Widget para carregar imagens no slider
class ImagePlaceholder extends StatelessWidget {
  final String? imagePath;
  const ImagePlaceholder({super.key, this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      imagePath!,
      fit: BoxFit.cover,
    );
  }
}

//Widget reutilizável para os ícones e textos
class InfoCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const InfoCard({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 30, color: Colors.blue),
        SizedBox(height: 8),
        Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
        ),
        SizedBox(height: 5),
        Text(
          subtitle,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 8, color: Colors.grey),
        ),
      ],
    );
  }
}

