import 'package:flutter/material.dart';
import 'package:my_kakeibo/presentation/core/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = getMaterialTheme(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme.light(),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const double available = 2000.00;
    const double goal = 2500.00;
    const double spent = 600.00;

    final List<Map<String, dynamic>> transactions = [
      {
        "date": "Today",
        "items": [
          {"title": "Head", "subtitle": "Subhead", "amount": 30.01},
          {"title": "Head", "subtitle": "Subhead", "amount": 30.01},
        ]
      },
      {
        "date": "Yesterday",
        "items": [
          {"title": "Head", "subtitle": "Subhead", "amount": 30.01},
          {"title": "Head", "subtitle": "Subhead", "amount": 30.01},
        ]
      }
    ];

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.bar_chart), label: "Insights"),
          BottomNavigationBarItem(icon: Icon(Icons.menu), label: "More"),
        ],
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              const Text("Bem-vindo, Felipe!",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              const Text("Available",
                  style: TextStyle(fontSize: 16, color: Colors.grey)),
              Text("R\$ ${available.toStringAsFixed(2)}",
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("meta", style: TextStyle(fontSize: 16)),
                  Text(goal.toStringAsFixed(2),
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold)),
                ],
              ),
              const Divider(),
              Text("gasto: ${spent.toStringAsFixed(2)}",
                  style: const TextStyle(fontSize: 14, color: Colors.grey)),
              const SizedBox(height: 16),
              Expanded(
                child: ListView(
                  children: transactions.map((group) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                            group["date"],
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                        ...group["items"].map<Widget>((item) {
                          return Card(
                            margin: const EdgeInsets.symmetric(vertical: 4),
                            child: ListTile(
                              leading: const CircleAvatar(child: Text("A")),
                              title: Text(item["title"]),
                              subtitle: Text(item["subtitle"]),
                              trailing: Text(
                                item["amount"].toStringAsFixed(2),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          );
                        }).toList(),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
