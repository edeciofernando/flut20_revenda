import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:revenda_herbie/classes/carro.dart';
import 'package:revenda_herbie/blocs/carros_bloc.dart';
import 'package:revenda_herbie/classes/cliente.dart';
import 'package:revenda_herbie/components/item_lista.dart';
import 'package:revenda_herbie/blocs/login_bloc.dart';
import 'package:revenda_herbie/components/login_page.dart';
import 'package:revenda_herbie/components/menu_pesquisa.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _bloc = BlocProvider.getBloc<CarrosBloc>();
  final _blocLogin = BlocProvider.getBloc<LoginBloc>();
  Cliente _pessoaLogada;

  @override
  void initState() {
    super.initState();
    _blocLogin.outCliente.listen((dado) {
      setState(() {
        _pessoaLogada = dado;
      });
//      print("Logado: " + _pessoaLogada.nome);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Image.asset(
              'assets/carros.png',
              fit: BoxFit.contain,
              height: 32,
            ),
            Container(
              padding: EdgeInsets.all(4),
              child: Text('Herbie'),
            ),
          ],
        ),
        actions: <Widget>[
          IconButton(
            icon: _pessoaLogada == null
                ? Icon(Icons.login)
                : Icon(Icons.verified_user),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.star),
            onPressed: () async {
              _bloc.buscaCarrosDestaque();
            },
          ),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () async {
              String pesq = await showSearch(
                context: context,
                delegate: MenuPesquisa(),
              );
              // print(pesq);
              if (pesq != null) {
                _bloc.buscaCarrosPesquisa(pesq);
              }
            },
          ),
        ],
      ),
      body: _body(context),
    );
  }

  _body(context) {
    _bloc.buscaCarrosDestaque();

    return Column(
      children: <Widget>[
        Expanded(
          child: StreamBuilder<List<Carro>>(
            stream: _bloc.outCarros,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Text(
                    'Erro ao acessar WebService',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 24,
                    ),
                  ),
                );
              }

              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (snapshot.data.length == 0) {
                return Center(
                  child: Text(
                    'Não há veículos deste modelo',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 24,
                    ),
                  ),
                );
              }

              return ListView.builder(
                itemBuilder: (context, index) {
                  return ItemLista(snapshot.data[index], _pessoaLogada);
                },
                itemCount: snapshot.data.length,
              );
            },
          ),
        ),
      ],
    );
  }
}
