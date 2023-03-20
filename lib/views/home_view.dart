import 'package:bear_test/blocs/home_view/home_view_bloc.dart';
import 'package:bear_test/services/bear_api/bear_repository_impl.dart';
import 'package:bear_test/widgets/search_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});
  final TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        controller: searchController,
        title: 'Bears',
        titleSearch: "Buscardor de osos",
      ),
      body: BlocProvider(
        create: (context) => HomeViewBloc(
            bearRepository: RepositoryProvider.of<BearRepositoryImpl>(context))
          ..add(const LoadBearsEvent()),
        child: BlocBuilder<HomeViewBloc, HomeViewState>(
          builder: (context, state) {
            if (state is LoadedBearsState) {
              return ListView.separated(
                itemBuilder: (context, index) => Container(
                  margin: const EdgeInsets.all(16),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 10,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, "detail_view",
                          arguments: state.bearList[index].id);
                    },
                    child: Row(children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.height / 10,
                        height: MediaQuery.of(context).size.height / 10,
                        child: Image.network(
                          state.bearList[index].imageUrl!,
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) =>
                              Expanded(
                                  child: Container(
                            color: Colors.blue,
                          )),
                        ),
                      ),
                      Expanded(
                        child: ListTile(
                          title:
                              Text(state.bearList[index].name ?? "Sin nombre"),
                          subtitle: Text(
                            state.bearList[index].description ??
                                "Sin descripcion",
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      const Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.black54,
                      )
                    ]),
                  ),
                ),
                separatorBuilder: (context, index) => const Divider(),
                itemCount: state.bearList.length,
              );
            } else if (state is LoadingBearsState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is ErrorLoadingBears) {
              return Center(
                child: Text(state.message),
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
