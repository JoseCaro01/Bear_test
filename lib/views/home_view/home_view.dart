import 'package:bear_test/blocs/home_view/home_view_bloc.dart';
import 'package:bear_test/blocs/search_bar/seach_bar_bloc.dart';
import 'package:bear_test/models/bear.dart';
import 'package:bear_test/widgets/search_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final TextEditingController searchController =
      TextEditingController(text: "");

  @override
  void initState() {
    context.read<HomeViewBloc>().add(const LoadBearsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        controller: searchController,
        title: 'Bears',
        titleSearch: "Buscardor de osos",
      ),
      body: BlocConsumer<HomeViewBloc, HomeViewState>(
        listener: (context, state) {
          if (state is LoadedBearsState) {
            searchController.addListener(() {
              print(searchController.text);
              context.read<SeachBarBloc>().add(FilteredEvent(
                  bearList: state.bearList, filter: searchController.text));
            });
          }
        },
        builder: (context, state) {
          return BlocBuilder<HomeViewBloc, HomeViewState>(
            builder: (context, state) {
              if (state is LoadedBearsState) {
                return BlocBuilder<SeachBarBloc, SeachBarState>(
                  buildWhen: (previous, current) => current is FilterListState,
                  builder: (context, filterState) {
                    if (filterState is FilterListState) {
                      return BearCard(
                        bearList: filterState.bearList,
                      );
                    } else {
                      return BearCard(bearList: state.bearList);
                    }
                  },
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
          );
        },
      ),
    );
  }
}

class BearCard extends StatelessWidget {
  const BearCard({
    required this.bearList,
    super.key,
  });

  final List<Bear> bearList;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) => Container(
        margin: const EdgeInsets.all(16),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height / 10,
        child: GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, "detail_view",
                arguments: bearList[index].id);
          },
          child: Row(children: [
            SizedBox(
              width: MediaQuery.of(context).size.height / 10,
              height: MediaQuery.of(context).size.height / 10,
              child: Image.network(
                bearList[index].imageUrl!,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) => Expanded(
                    child: Container(
                  color: Colors.blue,
                )),
              ),
            ),
            Expanded(
              child: ListTile(
                title: Text(bearList[index].name ?? "Sin nombre"),
                subtitle: Text(
                  bearList[index].description ?? "Sin descripcion",
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
      itemCount: bearList.length,
    );
  }
}
