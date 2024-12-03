import 'package:flutter/material.dart';
import 'package:aula_flutter_full08/services/user_service.dart';
import 'package:aula_flutter_full08/util.dart';

class ListRolesPage extends StatefulWidget {
  const ListRolesPage({super.key});

  @override
  State<ListRolesPage> createState() => _ListRolesPageState();
}

class _ListRolesPageState extends State<ListRolesPage> {
  Future<List<String>> fetchRoles(BuildContext context) async {
    try {
      // Simulação de chamada ao serviço para obter as Roles
      return await userService.getRoles(); // Método que criamos no serviço
    } catch (error) {
      Util.alert(context, 'Erro ao carregar as roles!');
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lista de Roles')),
      body: FutureBuilder(
        future: fetchRoles(context),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Erro ao carregar dados.'));
          }

          List<String> roles = snapshot.data ?? [];
          return roles.isEmpty
              ? const Center(child: Text('Nenhuma role encontrada.'))
              : ListView.builder(
                  itemCount: roles.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: const Icon(Icons.label),
                      title: Text(roles[index]),
                    );
                  },
                );
        },
      ),
    );
  }
}