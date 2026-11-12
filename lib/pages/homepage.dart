import 'package:bloc_network_example/bloc/user_bloc.dart';
import 'package:bloc_network_example/bloc/user_event.dart';
import 'package:bloc_network_example/cubit/internet_cubir.dart';
import 'package:bloc_network_example/services/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/action_buttons.dart';
import '../widgets/user_list.dart';

class Homepage extends StatelessWidget {
  Homepage({super.key});

  final userRepository = UserRepository();
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              UserBloc(userRepository: context.read<UserRepository>())
                ..add(UserLoadEvent()),
        ),
        BlocProvider(create: (context) => ConnectionCubit()),
      ],

      child: Scaffold(
        appBar: AppBar(
          title: BlocBuilder<ConnectionCubit, MyConnectionState>(
            builder: (context, state) => state.connected
                ? Text('User list (в сети)')
                : Text(
                    'Нет соединения с интернетом!',
                    style: TextStyle(color: Colors.red),
                  ),
          ),
          centerTitle: true,
        ),
        backgroundColor: Colors.white,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ActionButtons(),
            Expanded(child: UserList()),
          ],
        ),
      ),
    );
  }
}
