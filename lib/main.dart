import 'package:flutter/material.dart';
import 'package:flutter_application_1/views/home_processor_view.dart';
import 'views/image_processor_view.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePageWithNavigation(),
    );
  }
}

class HomePageWithNavigation extends StatefulWidget {
  const HomePageWithNavigation({super.key});

  @override
  State<HomePageWithNavigation> createState() => _HomePageWithNavigationState();
}

class _HomePageWithNavigationState extends State<HomePageWithNavigation> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomePage(),
    const ImageProcessorView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text("App de processamento de imagem"),
        centerTitle: true,
      ),
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.image),
            label: "Processar Imagem",
          ),
        ],
      ),
    );
  }
}
