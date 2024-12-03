import 'package:aula_flutter_full08/models/user.dart';
import 'package:aula_flutter_full08/pages/create_role.dart'; // Import da página de criação de role
import 'package:aula_flutter_full08/pages/create_user.dart';
import 'package:aula_flutter_full08/pages/list_roles.dart'; // Import da página de listagem de roles
import 'package:aula_flutter_full08/services/user_service.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Função para buscar a lista de usuários
  Future<List<User>> fetchUsers(BuildContext context) async {
    try {
      return await userService.getList();
    } catch (error) {
      Navigator.pop(context);
    }
    return [];
  }

  // Função para navegação para a página de criação de usuário
  void goToCreateUser(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CreateUserPage()),
    );
  }

  // Função para navegação para a página de criação de role
  void goToCreateRole(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CreateRolePage()),
    );
  }

  // Função para navegação para a página de listagem de roles
  void goToListRoles(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ListRolesPage()),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Usuários'),
        actions: [
          // Botão para criação de usuário
          IconButton(
            icon: const Icon(Icons.person_add),
            onPressed: () => goToCreateUser(context),
          ),
          // Botão para listagem de roles
          IconButton(
            icon: const Icon(Icons.list_alt), // Ícone para listar roles
            onPressed: () => goToListRoles(context),
          ),
          // Botão para criação de role
          IconButton(
            icon: const Icon(Icons.security),
            onPressed: () => goToCreateRole(context),
          ),
        ],
      ),
      body: FutureBuilder(
        future: fetchUsers(context),
        builder: (context, snapshot) {
          List<User> users = snapshot.data ?? [];
          return RefreshIndicator(
            onRefresh: () {
              setState(() {});
              return Future.value();
            },
            child: _buildListUsers(users),
          );
        },
      ),
    );
  }

  // Função para construir a lista de usuários
  ListView _buildListUsers(List<User> users) {
    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (context, index) {
        User user = users[index];

        return ListTile(
          title: Text(user.name),
          subtitle: Text(user.username),
        );
      },
    );
  }
}
