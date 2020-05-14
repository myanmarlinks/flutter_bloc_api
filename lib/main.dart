import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:test_two/bloc/task/bloc.dart';
import 'package:test_two/network/api_service.dart';
import 'package:test_two/ui/my_home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  static const String _title = "BLoC Two";

  @override
  Widget build(BuildContext context) {
    return Provider<ApiService>(
      create: (context) => ApiService.create(),
      child: Consumer<ApiService>(
        builder: (context, apiService, child) {
          return BlocProvider<TaskBloc>(
            create: (context) => TaskBloc(apiService),
            child: MaterialApp(
              title: _title,
              theme: ThemeData(
                primaryColor: Colors.redAccent
              ),
              home: MyHome(),
            ),
          );
        },
      )
    );
  }
}

