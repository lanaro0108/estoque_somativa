import 'package:sa_petshop_sqlite/database/database_helper.dart';
import 'package:sa_petshop_sqlite/models/pet_model.dart';

class PetController {
  final _dbHelper = DatabaseHelper();

  Future<int> createPet(Pet pet) async {
    return _dbHelper.insertPet(pet);
  }

  Future<List<Pet>> readPet() async => _dbHelper.getPets();

  Future<List<Pet>>? listarTodos() async {}
}
