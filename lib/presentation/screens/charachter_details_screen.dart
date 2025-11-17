import 'package:flutter/material.dart';
import 'package:rickandmorty/constants/appcolors.dart';
import 'package:rickandmorty/data/models/charachters_model.dart';
import 'package:rickandmorty/presentation/widgets/charachter_info.dart';

class CharachterDetailsScreen extends StatelessWidget {
  final CharachterModel character;
  const CharachterDetailsScreen({super.key, required this.character});

  buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 600,
      pinned: true,
      stretch: true,
      backgroundColor: Appcolors.mainGrey,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          character.name,
          style: TextStyle(
            color: Appcolors.darkSaga,
            fontWeight: FontWeight.bold,
          ),
        ),
        background: Hero(
          tag: character.id,
          child: Image.network(character.image, fit: BoxFit.cover),
        ),
      ),
    );
  }

  Widget buildDivider(double endIndent) {
    return Divider(
      height: 30,
      endIndent: endIndent,
      thickness: 4,
      color: Appcolors.contrastGreen,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolors.mainGrey,
      body: CustomScrollView(
        slivers: [
          buildSliverAppBar(),
          SliverList(
            delegate: SliverChildListDelegate([
              Container(
                margin: EdgeInsets.fromLTRB(14, 14, 14, 8),
                padding: EdgeInsets.all(8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    characterInfo("Gender : ", character.gender),
                    buildDivider(300),
                    characterInfo("Status : ", character.status),
                    buildDivider(310),
                    characterInfo("Species : ", character.species),
                    buildDivider(290),
                    characterInfo(
                      "Origin : ",
                      character.origin!.name ?? "Unknown",
                    ),
                    buildDivider(300),
                    characterInfo(
                      "Location : ",
                      character.location!.name ?? "UnLocated",
                    ),
                    buildDivider(280),
                    characterInfo(
                      "episode : ",
                      character.episode
                          .map(
                            (episodeUrl) =>
                                int.parse(episodeUrl.split('/').last),
                          )
                          .toList()
                          .toString(),
                    ),
                    buildDivider(300),
                    SizedBox(height: 20),
                  ],
                ),
              ),
              SizedBox(height: 500),
            ]),
          ),
        ],
      ),
    );
  }
}
