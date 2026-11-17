import 'package:podex/models/pokemon_model.dart';


Pokemon parserPokemon (Map<String,dynamic>? pokemonJson, String number) {

  if (pokemonJson == null) {
    return  Pokemon(id: number, name: number, type: 'Error');

  }

  return Pokemon.fromJson({
    'id' : number,
    'name' : pokemonJson['name'],
    'type' : pokemonJson['type'],
  });
}