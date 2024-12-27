import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Navigation Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const NavigationFirst(),
    );
  }
}

class NavigationFirst extends StatefulWidget {
  const NavigationFirst({super.key});

  @override
  State<NavigationFirst> createState() => _NavigationFirstState();
}

class _NavigationFirstState extends State<NavigationFirst> {
  Color color = Colors.blue;

  Future<void> _navigateAndGetColor(BuildContext context) async {
    // Navigasi ke layar kedua dan mendapatkan warna yang dipilih
    final Color? selectedColor = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const NavigationSecond()),
    );

    // Perbarui warna jika ada warna yang dikembalikan
    if (selectedColor != null) {
      setState(() {
        color = selectedColor;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color,
      appBar: AppBar(
        title: const Text('Navigation First Screen'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => _navigateAndGetColor(context),
          child: const Text('Change Color'),
        ),
      ),
    );
  }
}

class NavigationSecond extends StatelessWidget {
  const NavigationSecond({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Navigation Second Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => Navigator.pop(context, Colors.green),
              child: const Text('Red'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => Navigator.pop(context, Colors.yellow),
              child: const Text('Green'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => Navigator.pop(context, Colors.blue),
              child: const Text('Blue'),
            ),
          ],
        ),
      ),
    );
  }
}
