import 'package:flutter/material.dart';
import 'package:rickandmorty/constants/appcolors.dart';
import 'package:rickandmorty/constants/strings.dart';
import 'package:rickandmorty/data/models/charachters_model.dart';

class CharachterItem extends StatelessWidget {
  final CharachterModel charachter;
  const CharachterItem({required this.charachter, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: double.infinity,
      margin: EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
      padding: EdgeInsetsDirectional.all(4),
      decoration: BoxDecoration(
        color: Appcolors.mentGreen,
        borderRadius: BorderRadius.circular(8),
      ),
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(
            context,
            charachterDetailsScreen,
            arguments: charachter,
          );
        },
        child: GridTile(
          footer: Hero(
            tag: charachter.id,
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              color: Appcolors.darkSaga.withValues(alpha: .85),
              alignment: Alignment.bottomCenter,
              child: Text(
                charachter.name,
                style: TextStyle(
                  height: 1.3,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,

                  color: Appcolors.mainGrey,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          child: Container(
            color: Appcolors.saga,
            child: charachter.image.isNotEmpty
                ? FadeInImage.assetNetwork(
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                    placeholder: "assets/images/Loader 4.gif",
                    image: charachter.image,
                  )
                : Image.asset('assets/images/rick.gif'),
          ),
        ),
      ),
    );
  }
}
