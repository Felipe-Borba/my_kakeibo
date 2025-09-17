import 'package:flutter/material.dart';

class AppBarCustom extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const AppBarCustom({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(60.0),
      child: Stack(children: [
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF16A34A),
                Color(0xFF059669),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          actions: const [SizedBox()],
          centerTitle: true,
          title: Text(
            title,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
          iconTheme: const IconThemeData(
            color: Colors.white,
          ),
        ),
      ]),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
