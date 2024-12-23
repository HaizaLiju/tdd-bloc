import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tdd_bloc/main.dart';
import 'package:tdd_bloc/src/authentication/presentation/cubit/authentication_cubit.dart';

class AddUserDialog extends StatelessWidget {
  const AddUserDialog({super.key, required this.nameController});

  final TextEditingController nameController;

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Center(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20), color: Colors.white),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  label: Text('username'),
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    final email = 'sth@xema.org';
                    final username = nameController.text.trim();
                    context.read<AuthenticationCubit>().createUser(
                          id: '0',
                          username: username,
                          email: email,
                        );
                    Navigator.of(context).pop();
                  },
                  child: const Text('Create User')),
            ],
          ),
        ),
      ),
    );
  }
}
