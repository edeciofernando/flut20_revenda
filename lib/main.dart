import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:revenda_herbie/blocs/carros_bloc.dart';
import 'package:revenda_herbie/blocs/login_bloc.dart';
import 'package:revenda_herbie/components/home_page.dart';

void main() {
//  ApiCarros apicarros = ApiCarros();
//  apicarros.getCarros();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      blocs: [
        Bloc((i) => CarrosBloc()),
        Bloc((i) => LoginBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        home: HomePage(),
      ),
    );
  }
}
