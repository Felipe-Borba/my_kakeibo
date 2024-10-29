import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:my_kakeibo/core/components/app_bar_custom.dart';
import 'package:my_kakeibo/core/components/drawer_custom.dart';
import 'package:my_kakeibo/presentation/user/dashboard/dashboard_controller.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  static const routeName = '/dashboard';

  @override
  Widget build(BuildContext context) {
    final controller = Modular.get<DashboardController>();

    return FutureBuilder(
      future: controller.getInitialData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        return ListenableBuilder(
          listenable: controller,
          builder: (BuildContext context, Widget? child) {
            return Scaffold(
              appBar: AppBar(
                title: Text(""),
              ),
              body: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                child: Column(
                  children: [
                    // Container 1 - Exibição dos valores
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.blueAccent.shade100,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Valores',
                          ),
                          const SizedBox(height: 8),
                          Text("")
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Divider(),
                    // Container 2 - Lista de despesas em formato de coluna
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: ListView.builder(
                                itemCount: 10,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 4),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            index % 2 == 0
                                                ? 'Inbound'
                                                : 'Outbound',
                                            style: TextStyle(
                                                color: Colors.blueAccent),
                                          ),
                                        ),
                                        Expanded(
                                          child:
                                              Text('R\$ ${20 + index * 10}.00'),
                                        ),
                                        Expanded(
                                          child: Text('Alimentação'),
                                        ),
                                        Expanded(
                                          child: Text('10/10'),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              drawer: const DrawerCustom(),
            );
          },
        );
      },
    );
  }
}
