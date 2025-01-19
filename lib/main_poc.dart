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
      restorationScopeId: 'poc',
      debugShowCheckedModeBanner: false,
      darkTheme: theme.dark(),
      theme: theme.light(),
      themeMode: ThemeMode.light,
      home: const Dashboard(),
    );
  }
}

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarCustom(),
      endDrawer: Drawer(
        child: ListView(
          children: const [
            ListTile(
              title: Text("Item 1."),
            ),
            ListTile(
              title: Text("Item 2"),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavigationBarCustom(),
      body: const Center(
        child: Text("Conteúdo da página"),
      ),
    );
  }
}

class AppBarCustom extends StatelessWidget implements PreferredSizeWidget {
  const AppBarCustom({super.key});

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(60.0),
      child: AppBar(
        actions: const [
          //Esconde o ícone padrão do drawer
          SizedBox(),
          // IconButton(
          //   icon: Icon(Icons.notifications),
          //   onPressed: () {},
          // ),
        ],
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 15,
              child: Icon(
                Icons.person,
                size: 15,
              ),
            ),
            Expanded(child: SizedBox(width: 10)),
            Text("Dashboard"),
            Expanded(child: SizedBox(width: 10)),
            SizedBox(width: 30),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}

class BottomNavigationBarCustom extends StatelessWidget {
  const BottomNavigationBarCustom({super.key});

  @override
  Widget build(BuildContext context) {
    final scaffold = Scaffold.of(context);

    return BottomNavigationBar(
      onTap: (index) {
        if (index == 2) {
          scaffold.openEndDrawer();
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Ação para o item $index"),
            ),
          );
        }
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.pie_chart),
          label: "Gráfico 1",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.bar_chart),
          label: "Gráfico 2",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.menu),
          label: "Menu",
        ),
      ],
    );
  }
}
