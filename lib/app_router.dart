import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'business_logic/cubit/charachters_cubit.dart';
import 'constants/strings.dart';
import 'data/api/charachters_api.dart';
import 'data/models/charachters_model.dart';
import 'data/repositories/charachters_repository.dart';
import 'presentation/screens/charachter_details_screen.dart';
import 'presentation/screens/charachters_screen.dart';

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
