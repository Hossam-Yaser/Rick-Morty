// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';
import 'package:rickandmorty/data/models/charachters_model.dart';
import 'package:rickandmorty/data/repositories/charachters_repository.dart';

part 'charachters_state.dart';

class CharachtersCubit extends Cubit<CharachtersState> {
  final CharachtersRepository repo;
  List<CharachterModel> charachters = [];

  CharachtersCubit(this.repo) : super(CharachtersInitial());

  Future<List<CharachterModel>> getAllCharachters() async {
    charachters = await repo.getAllCharachters();
    emit(CharachtersLoaded(charachters));
    return charachters;
  }
}
