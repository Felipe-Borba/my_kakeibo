import 'package:flutter/material.dart';

class AppBarUser extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const AppBarUser({
    super.key,
    required this.title,
  });

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
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 15,
              child: ClipOval(child: Image.asset("assets/launcher/icon.png")),
            ),
            const Expanded(child: SizedBox(width: 10)),
            // const SizedBox(width: 10),
            Text(title),
            const Expanded(child: SizedBox(width: 10)),
            const SizedBox(width: 30),
            // IconButton(onPressed: () {}, icon: const Icon(Icons.notifications)),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
