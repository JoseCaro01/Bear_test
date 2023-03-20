import 'package:bear_test/models/bear.dart';
import 'package:flutter/material.dart';

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
