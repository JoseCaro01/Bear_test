import 'package:bear_test/blocs/home_view/home_view_bloc.dart';
import 'package:bear_test/blocs/search_bar/seach_bar_bloc.dart';
import 'package:bear_test/services/bear_api/bear_repository_impl.dart';
import 'package:bear_test/views/bear_detail_view.dart';
import 'package:bear_test/views/home_view/home_view.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => BearRepositoryImpl(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => SeachBarBloc(),
          ),
          BlocProvider(
            create: (context) => HomeViewBloc(
                bearRepository:
                    RepositoryProvider.of<BearRepositoryImpl>(context)),
          )
        ],
        child: MaterialApp(
          title: 'Bear Test',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          initialRoute: "home_view",
          routes: {
            'home_view': (context) => const HomeView(),
            'detail_view': (context) => const BearDetailView()
          },
        ),
      ),
    );
  }
}
