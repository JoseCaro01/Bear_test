import 'package:bear_test/blocs/detail_view/detail_view_bloc.dart';
import 'package:bear_test/services/bear_api/bear_repository_impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BearDetailView extends StatelessWidget {
  const BearDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as int;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Vista detalle"),
      ),
      body: BlocProvider(
          create: (context) => DetailViewBloc(
              bearRepository:
                  RepositoryProvider.of<BearRepositoryImpl>(context))
            ..add(LoadBearEvent(id: args)),
          child: BlocBuilder<DetailViewBloc, DetailViewState>(
            builder: (context, state) {
              if (state is LoadedBearState) {
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 32, horizontal: 24),
                    child: Column(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height / 3,
                          child: Image.network(
                            state.bear.imageUrl!,
                            fit: BoxFit.contain,
                          ),
                        ),
                        const SizedBox(
                          height: 32,
                        ),
                        Text(
                          state.bear.name ?? "Sin nombre",
                          style: Theme.of(context).textTheme.headlineLarge,
                        ),
                        const SizedBox(
                          height: 32,
                        ),
                        Text(
                          state.bear.description ?? "Sin description",
                          style: Theme.of(context).textTheme.bodyLarge,
                          textAlign: TextAlign.justify,
                        ),
                        const SizedBox(
                          height: 32,
                        ),
                        ListTile(
                          contentPadding: const EdgeInsets.all(0),
                          leading: const Icon(Icons.abc),
                          title: Text(
                            "ABV:${state.bear.abv ?? 0}",
                          ),
                        ),
                        ListTile(
                          contentPadding: const EdgeInsets.all(0),
                          leading: const Icon(Icons.abc),
                          title: Text(
                            "Target FG:${state.bear.targetFg ?? 0}",
                          ),
                        ),
                        ListTile(
                          contentPadding: const EdgeInsets.all(0),
                          leading: const Icon(Icons.abc),
                          title: Text(
                            "Target OG:${state.bear.targetOg ?? 0}",
                          ),
                        )
                      ],
                    ),
                  ),
                );
              } else if (state is LoadingBearState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is ErrorLoadingBear) {
                return Center(
                  child: Text(state.message),
                );
              } else {
                return Container();
              }
            },
          )),
    );
  }
}
