import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:revenda_herbie/classes/cliente.dart';

class ApiLogin {
  final url =
      'https://api.sheety.co/58aad4af0eff6bb2d1446fe9d32d121a/revendaHerbie/clientes';

  getLoginCliente(String email, String senha) async {
    var response =
        await http.get(url + '?filter[email]=${email}&filter[senha]=${senha}');

    if (response.statusCode == 200) {
      var lista = json.decode(response.body)['clientes'];

      if (lista.length == 1) {
        //print(lista[0]);
        //print(lista[0]['nome']);
        return Cliente(lista[0]['id'], lista[0]['nome'], lista[0]['email']);
      } else {
        return null;
      }
    } else {
      throw Exception('Erro ao conectar com WebService');
    }
  }
}
