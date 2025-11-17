import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rickandmorty/business_logic/cubit/charachters_cubit.dart';
import 'package:rickandmorty/constants/strings.dart';
import 'package:rickandmorty/data/api/charachters_api.dart';
import 'package:rickandmorty/data/models/charachters_model.dart';
import 'package:rickandmorty/data/repositories/charachters_repository.dart';
import 'package:rickandmorty/presentation/screens/charachter_details_screen.dart';
import 'package:rickandmorty/presentation/screens/charachters_screen.dart';

class AppRouter {
  late CharachtersRepository charachtersRepository;
  late CharachtersCubit charachtersCubit;

  AppRouter() {
    charachtersRepository = CharachtersRepository(
      charachtersApi: CharachtersApi(),
    );
    charachtersCubit = CharachtersCubit(charachtersRepository);
  }

  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case charachtersScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => charachtersCubit,
            child: CharachtersScreen(),
          ),
        );
      case charachterDetailsScreen:
        final tapedonCharachter = settings.arguments as CharachterModel;
        return MaterialPageRoute(
          builder: (_) => CharachterDetailsScreen(character: tapedonCharachter),
        );
    }
    return null;
  }
}
