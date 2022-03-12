import 'package:chat_app/core/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(0),
      child: SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              const Center(
                child: Text("WELCOME!"),
              ),
              ElevatedButton(
                onPressed: () {
                  context.read<AuthService>().signOut();
                },
                child: const Text("SIGN OUT"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
