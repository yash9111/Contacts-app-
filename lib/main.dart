import 'package:contacts_app/features/contacts/presentation/bloc/contact_bloc.dart';
import 'package:contacts_app/features/contacts/presentation/screens/contact_screen.dart';

import 'package:contacts_app/init_dependency.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

void main() {
  init();
  final contactBloc =
      GetIt.I<ContactBloc>(); 
  runApp(
    BlocProvider(
      create: (_) => contactBloc,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'User List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ContactScreen(),
    );
  }
}
