import 'package:flutter/material.dart';
import 'package:revenda_herbie/classes/carro.dart';
import 'package:intl/intl.dart';
import 'package:revenda_herbie/components/carros_detalhe_page.dart';
import 'package:revenda_herbie/classes/cliente.dart';

class ItemLista extends StatelessWidget {
  final Carro carro;
  final Cliente cliente;

  ItemLista(this.carro, this.cliente);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      child: Column(
        children: <Widget>[
          AspectRatio(
            aspectRatio: 16.0 / 9.0,
            child: Image.network(carro.foto),
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.fromLTRB(12, 4, 0, 0),
                      child: Text(carro.marca + ' ' + carro.modelo),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(12, 4, 0, 12),
                      child: Text(
                          'Preço ${NumberFormat.simpleCurrency(locale: 'pt_BR').format(carro.preco)}'),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.all(4),
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: FlatButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              CarrosDetalhePage(carro, cliente)),
                    );
                  },
                  child: Text(
                    ' Detalhes ',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
