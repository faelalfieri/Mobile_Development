import 'package:aula_flutter_full08/services/role_service.dart'; // Serviço para interagir com a API
import 'package:flutter/material.dart';

class CreateRolePage extends StatefulWidget {
  const CreateRolePage({super.key});

  @override
  State<CreateRolePage> createState() => _CreateRolePageState();
}

class _CreateRolePageState extends State<CreateRolePage> {
  String _name = '';
  String _description = '';

  // Função de salvar a nova role
  void saveRole() {
    if (_name.trim() == '') {
      _showAlert('Nome da role é obrigatório!');
      return;
    }
    if (_description.trim() == '') {
      _showAlert('Descrição da role é obrigatória!');
      return;
    }

    final roleData = {
      'name': _name,
      'description': _description,
    };

    roleService.createRole(roleData).then((isCreated) {
      if (isCreated) {
        Navigator.pop(context);    
      } else {
        _showAlert('Erro ao criar a role!');
      }
    }).catchError((error) {
      _showAlert('Erro ao conectar com o servidor!');
    });
  }

  // Função de mostrar alertas
  void _showAlert(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cadastrar Role')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(labelText: 'Nome da Role'),
              onChanged: (value) => _name = value,
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Descrição da Role'),
              onChanged: (value) => _description = value,
            ),
            ElevatedButton(
              onPressed: saveRole,
              child: const Text('Salvar Role'),
            ),
          ],
        ),
      ),
    );
  }
}
