import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:podex/models/pokemon_model.dart';
import 'package:podex/functions/parse_pokemon.dart';
import 'dart:math';
class Post extends StatefulWidget {
  Post({super.key});

  @override
  State<Post> createState() => _PostState();
}

class _PostState extends State<Post> {
  final Dio dio = Dio();

  Future<Map<String, dynamic>> postRequest(String number) async {
    final reponse = await dio.post(
      'http://192.168.100.11:8000/podex/api/',
      data: {'number': number},
      options: Options(headers: {'Content-Type': 'application/json'}),
    );

    return reponse.data;
  }

  TextEditingController numberController = TextEditingController();

  String number = "";
  String nameReturned = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pokedex')),
      resizeToAvoidBottomInset: false,

      body: FutureBuilder<Map<String, dynamic>>(
        future: postRequest(number),
        builder:
            (
              BuildContext context,
              AsyncSnapshot<Map<String, dynamic>> snapshot,
            ) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Text("Error: ${snapshot.error}");
              } else if (snapshot.hasData) {
                Map<String, dynamic> data = snapshot.data!;
                Pokemon pokemon = parserPokemon(data['pokemon'], number);

                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                  
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric( horizontal: 34.0, vertical: 8.0),
                        child: TextField(
                          
                          controller: numberController,
                          autofocus: false,
                          decoration: InputDecoration(
                            hintText: 'Enter Pokemon Number',
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: const Color.fromARGB(255, 175, 40, 199),
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black,
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                          ),
                        
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      
                  
                      
                      Image.asset('Glossy Poké Ball Asset Icon.png'),
                      SizedBox(height: 16.0),
                      Text(
                        pokemon.name,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(height: 23.0),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FilledButton(
                          style: FilledButton.styleFrom(
                            backgroundColor: Colors.purpleAccent[500],
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                          ),
                         
                          child: Text("Search",style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                  
                          onPressed: () async {
                            number = numberController.text;
                            await postRequest(number);
                            setState(() {
                            
                            });
                          },
                        ),
                      ),
                      
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FilledButton(
                          style: FilledButton.styleFrom(
                            backgroundColor: Colors.purpleAccent[500],
                          
                            padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                          ),
                         
                          child: Text("Randomize",style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.purpleAccent[500]),),
                  
                          onPressed: () async {
                            Random randomizer = Random();
                            number = (randomizer.nextInt(20) + 1).toString();
                            await postRequest(number);
                            setState(() {
                            
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return Center(child: Text('There is no data'));
              }
            },
      ),
    );
  }
}
