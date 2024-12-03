import 'dart:convert';
import 'package:http/http.dart' as http;

class _RoleService {
  final String _baseUrl = 'http://192.168.15.153:3030/roles'; // URL da API de roles
  final String _sessionKey = 'auth@SESSION_KEY';

  Map<String, String> _getHeaders() {
    return {
      'Content-Type': 'application/json; charset=UTF-8',
    };
  }

  Future<bool> createRole(Map<String, String> roleData) async {
    try {
      final response = await http.post(
        Uri.parse(_baseUrl),
        headers: _getHeaders(),
        body: jsonEncode(roleData),
      );

      // Exibir a resposta da API para depuração
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 201) {
        return true; // Role criada com sucesso
      } else {
        // Se a API retornar um erro, podemos analisar a resposta.
        print('Erro ao criar a role: ${response.body}');
        return false;
      }
    } catch (error) {
      print('Erro na requisição: $error');
      return false;
    }
  }
}

final roleService = _RoleService();
