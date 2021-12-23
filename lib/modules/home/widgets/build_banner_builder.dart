import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mogawe/modules/pesona/pesona_page.dart';

class BuildBannerBuilder extends StatelessWidget {
  const BuildBannerBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 140,
      child: GestureDetector(
          onTap: () async {
            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PesonaPage(),
              ),
            );
          },
          child: ListView.builder(
              itemCount: 3,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                String mockImageUrl =
                    "https://images.unsplash.com/photo-1540575467063-178a50c2df87?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxleHBsb3JlLWZlZWR8Mnx8fGVufDB8fHx8&w=1000&q=80";
                return Container(
                    width: 260,
                    margin: const EdgeInsets.symmetric(horizontal: 12),
                    child: Image.network(mockImageUrl, fit: BoxFit.fill));
              })),
    );
  }
}
