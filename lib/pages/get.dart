import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:podex/functions/pokedex_parser.dart';
import 'package:podex/models/pokemon_model.dart';

class Get extends StatelessWidget {
  new({super.key});
  final Dio _dio = Dio();

  Future<Map<String, dynamic>> getPokemons() async {
    final reponse = await _dio.get('http://127.0.0.1:8000/podex/api');
    return reponse.data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pokedex')),
      body: FutureBuilder<Map<String, dynamic>>(
        future: getPokemons(),
        builder:
            (
              BuildContext context,
              AsyncSnapshot<Map<String, dynamic>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (snapshot.hasData) {
                Map<String, dynamic> data = snapshot.data!;

                List<Pokemon> pokedex = parsePokedex(data);

                return ListView.builder(
                  itemCount: pokedex.length,
                  itemBuilder: (context, index) {
                    return Card(
                      margin: const EdgeInsets.all(8.0),
                      child: ListTile(
                        leading: Text(pokedex.elementAt(index).id),
                        title: Text(
                          pokedex.elementAt(index).name,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(pokedex.elementAt(index).type),
                      ),
                    );
                  },
                );
              }
              else {
                return Center(child: Text('There is no data'),);
              }
            },
      ),
    );
  }
}
