import 'package:contact_app/bloc/contact_cubit.dart';
import 'package:contact_app/sqlite/database_manager.dart';
import 'package:contact_app/ui/contacts_page.dart';
import 'package:contact_app/ui/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ContactCubit(DatabaseManager())..loadContacts(),
      child: const MaterialApp(
        title: 'Google Contacts App',
        debugShowCheckedModeBanner: false,
        home: HomePage(),
      ),
    );
  }
}
