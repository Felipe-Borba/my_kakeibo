import 'package:flutter/material.dart';
import 'package:my_kakeibo/presentation/core/app_theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = getMaterialTheme(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme.light(),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final double available = 2000.00;
  final double goal = 2500.00;
  final double spent = 600.00;

  final List<Map<String, dynamic>> transactions = [
    {
      "date": "Today",
      "items": [
        {"title": "Heades", "subtitle": "Subhead", "amount": 30.01},
        {"title": "Heades", "subtitle": "Subhead", "amount": 30.01},
      ]
    },
    {
      "date": "Yesterday",
      "items": [
        {"title": "Heades", "subtitle": "Subhead", "amount": 30.01},
        {"title": "Heades", "subtitle": "Subhead", "amount": 30.01},
      ]
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: [
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
              Text("Bem-vindo, Felipe!",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Text("Available",
                  style: TextStyle(fontSize: 16, color: Colors.grey)),
              Text("R\$ ${available.toStringAsFixed(2)}",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("meta", style: TextStyle(fontSize: 16)),
                  Text(goal.toStringAsFixed(2),
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ],
              ),
              Divider(),
              Text("gasto: ${spent.toStringAsFixed(2)}",
                  style: TextStyle(fontSize: 14, color: Colors.grey)),
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
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                        ...group["items"].map<Widget>((item) {
                          return Card(
                            margin: EdgeInsets.symmetric(vertical: 4),
                            child: ListTile(
                              leading: CircleAvatar(child: Text("A")),
                              title: Text(item["title"]),
                              subtitle: Text(item["subtitle"]),
                              trailing: Text(
                                item["amount"].toStringAsFixed(2),
                                style: TextStyle(fontWeight: FontWeight.bold),
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
