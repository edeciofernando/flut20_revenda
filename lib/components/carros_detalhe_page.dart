import 'package:flutter/material.dart';
import 'package:revenda_herbie/apis/api_propostas.dart';
import 'package:revenda_herbie/classes/carro.dart';
import 'package:revenda_herbie/classes/cliente.dart';

class CarrosDetalhePage extends StatefulWidget {
  final Carro carro;
  final Cliente cliente;

  CarrosDetalhePage(this.carro, this.cliente);

  @override
  _CarrosDetalhePageState createState() => _CarrosDetalhePageState();
}

class _CarrosDetalhePageState extends State<CarrosDetalhePage> {
  var _edProposta = TextEditingController();
  String _mensagem = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes do Carro'),
      ),
      body: _body(),
    );
  }

  _body() {
    return Container(
      padding: EdgeInsets.all(8),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          AspectRatio(
            aspectRatio: 16.0 / 9.0,
            child: Image.network(widget.carro.foto),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            widget.cliente == null
                ? "Você deve se logar para fazer uma proposta"
                : "Faça uma proposta, ${widget.cliente.nome}!",
            style: TextStyle(
              color: Colors.blue,
              fontSize: 18,
            ),
            textAlign: TextAlign.center,
          ),
          _formProposta(),
        ],
      ),
    );
  }

  _formProposta() {
    if (widget.cliente == null) {
      return Center(
        child: Text("Venha nos visitar..."),
      );
    }

    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        children: <Widget>[
          TextFormField(
            controller: _edProposta,
            keyboardType: TextInputType.text,
            style: TextStyle(
              fontSize: 18,
            ),
            decoration: InputDecoration(
              labelText:
                  'Sua proposta pelo ${widget.carro.modelo} ${widget.carro.ano}',
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 50,
            decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.8),
              borderRadius: BorderRadius.circular(10),
            ),
            child: FlatButton(
              onPressed: () async {
                await _enviarProposta();
              },
              child: Text(
                ' Enviar ',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            _mensagem,
            style: TextStyle(
              color: Colors.blue,
              fontSize: 20,
            ),
          )
        ],
      ),
    );
  }

  _enviarProposta() async {
    if (_edProposta.text == '') {
      showDialog(
        context: context,
        builder: (_) => new AlertDialog(
          title: new Text("Atenção:"),
          content: new Text("Por favor, informe a descrição da sua proposta"),
          actions: <Widget>[
            FlatButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        ),
      );
      return;
    }

    ApiPropostas apiPropostas = ApiPropostas();
    final propostaId = await apiPropostas.saveProposta(
        widget.carro, widget.cliente, _edProposta.text);

    if (propostaId > 0) {
      showDialog(
        context: context,
        builder: (_) => new AlertDialog(
          title: new Text("Proposta Cadastrada com Sucesso"),
          content: new Text(
              "Em breve entraremos em contato. Sua proposta: ${propostaId}"),
          actions: <Widget>[
            FlatButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        ),
      );
    } else {
      print('Erro de acesso ao WebService...');
    }
  }
}
