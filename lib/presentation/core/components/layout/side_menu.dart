import 'package:flutter/material.dart';

class MenuBtn extends StatelessWidget {
  const MenuBtn({super.key, required this.press});

  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: SafeArea(
        child: Container(
          margin: const EdgeInsets.only(left: 16),
          height: 40,
          width: 40,
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                offset: Offset(0, 3),
                blurRadius: 8,
              ),
            ],
          ),
          child: const Icon(Icons.menu),
        ),
      ),
    );
  }
}

class SideMenu extends StatefulWidget {
  const SideMenu({super.key});

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  int? _selectedMenu;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: 288,
        height: double.infinity,
        color: const Color(0xFF17203A),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const InfoCard(
                name: "Joverson",
                profession: "Gauderio",
              ),
              Padding(
                padding: const EdgeInsets.only(left: 24, top: 32, bottom: 16),
                child: Text(
                  "Browse",
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(color: Colors.white70),
                ),
              ),
              ...[1, 2, 3].map(
                (item) => SideMenuTitle(
                  press: () {
                    setState(() {
                      _selectedMenu = item;
                    });
                  },
                  isActive: _selectedMenu == item,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 24, top: 32, bottom: 16),
                child: Text(
                  "Browse",
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(color: Colors.white70),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SideMenuTitle extends StatelessWidget {
  const SideMenuTitle({
    super.key,
    this.isActive = false,
    required this.press,
  });

  final bool isActive;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 24),
          child: Divider(
            color: Colors.white24,
            height: 1,
          ),
        ),
        Stack(children: [
          AnimatedPositioned(
            duration: const Duration(milliseconds: 300),
            curve: Curves.fastLinearToSlowEaseIn,
            height: 56,
            left: 0,
            width: isActive ? 288 : 0,
            child: Container(
              decoration: const BoxDecoration(
                color: Color(0xFF6792FF),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
            ),
          ),
          ListTile(
            onTap: press,
            leading: const Icon(
              Icons.home,
              color: Colors.white,
              size: 34,
            ),
            title: const Text(
              "Home",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ]),
      ],
    );
  }
}

class InfoCard extends StatelessWidget {
  const InfoCard({
    super.key,
    required this.name,
    required this.profession,
  });

  final String name, profession;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const CircleAvatar(
        backgroundColor: Colors.white24,
        child: Icon(
          Icons.person_outline,
          color: Colors.white,
        ),
      ),
      title: Text(
        name,
        style: const TextStyle(color: Colors.white),
      ),
      subtitle: Text(
        profession,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
