import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../blocs/bloc.dart';
import '../blocs/google_pay_bloc.dart';
import '../blocs/apple_pay_bloc.dart';
import '../components/pay_button.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(
          create: (BuildContext context) => GooglePayBloc(environment: 'test'),
          dispose: (BuildContext context, Bloc bloc) => bloc.dispose(),
        ),
        Provider(
          create: (BuildContext context) => ApplePayBloc(environment: 'test'),
          dispose: (BuildContext context, Bloc bloc) => bloc.dispose(),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              PayButton('Google Pay'),
            ],
          )
        ),
      ),
    );
  }
}
