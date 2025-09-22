import 'package:flutter/material.dart';

class AppBarCustom extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;

  const AppBarCustom({
    super.key,
    required this.title,
    this.actions = const <Widget>[SizedBox()],
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
          actions: actions,
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
