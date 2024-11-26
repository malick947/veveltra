import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:recipe_app/recipemodel.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Recipemodel> recipelist = [];

  TextEditingController search_value = TextEditingController();
  String query = "";

  Future callApi() async {
    Response response = await get(Uri.parse(
        "https://api.edamam.com/search?q=$query&app_id=1a6e303d&app_key=5ea6c6deeb2226e92336e7292f3ce2e8"));
    Map data = jsonDecode(response.body);
    data["hits"].forEach((Element) {
      Recipemodel recipemodel = new Recipemodel();
      recipemodel = Recipemodel.fromMap(Element["recipe"]);
      recipelist.add(recipemodel);
    });

    recipelist.forEach((recipe) {
      debugPrint(recipe.applabel);
    });
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: h,
          width: w,
          decoration: BoxDecoration(
              gradient: LinearGradient(
            colors: [Color(0xff112c50), Color(0xff3a5373), Color(0xff33576c)],
            stops: [0, 0.5, 1],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          )),
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 15),
            decoration: BoxDecoration(
                gradient: LinearGradient(
              colors: [Color(0xff112c50), Color(0xff3a5373), Color(0xff33576c)],
              stops: [0, 0.5, 1],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            )),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 20),
                  height: h / 15,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15.0, vertical: 5),
                    child: TextField(
                      onSubmitted: (value) async {
                        query = value;
                        await callApi();
                      },
                      controller: search_value,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                      decoration: InputDecoration(
                        hintText: "Let's Cook Something!",
                        suffixIcon: Icon(
                          Icons.search,
                          size: 30,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    "WHAT DO YOU WANT TO COOK TODAY!!",
                    style: TextStyle(fontSize: 40, color: Colors.white),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 0),
                  child: Text(
                    "Let's Cook Something New!!",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
