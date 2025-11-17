import '../api/charachters_api.dart';
import '../models/charachters_model.dart';

class CharachtersRepository {
  final CharachtersApi charachtersApi;

  CharachtersRepository({required this.charachtersApi});

  Future<List<CharachterModel>> getAllCharachters() async {
    final charachters = await charachtersApi.getAllCharachters();
    return charachters
        .map((charachter) => CharachterModel.fromJson(charachter))
        .toList();
  }
}
