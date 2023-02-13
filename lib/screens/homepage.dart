import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:pratical_exam_jokes/screens/models_class.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'api_helper.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomePage> {
  List jokesList = [];

  jocksdata() async {
    await JockData.joksData.fetchJocksData();
  }

  @override
  void initState() {
    super.initState();
    Data();
  }

  Data() async {
    final prefs = await SharedPreferences.getInstance();
    var getData = prefs.getString("jokesString");

    if (getData != null) {
      var datas = jsonDecode(getData);

      jokesList.clear();
      jokesList = datas;
      print(jokesList);
    }
  }

  String date = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Jocks App"),
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      content: Container(
                        height: double.infinity,
                        width: 400,
                        child: ListView.builder(
                          itemCount: jokesList.length,
                          itemBuilder: (context, position) {
                            JoksData joks = JoksData(
                                value: 'value', createddate: 'created_at');

                            var jokes = jokesList[position];

                            return Card(
                              child: Padding(
                                padding: const EdgeInsets.all(13.0),
                                child: RichText(
                                  text: TextSpan(
                                    text: 'Jocks: ',
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                    children: <TextSpan>[
                                      TextSpan(
                                          text: "${jokes["Value"]},\n",
                                          style: const TextStyle(
                                              fontSize: 13,
                                              color: Colors.grey,
                                              fontWeight: FontWeight.normal)),
                                      const TextSpan(
                                        text: "Date: ",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                      ),
                                      TextSpan(
                                          text:
                                              "${jokes["created_at"]!.split(" ")[0]}\n",
                                          style: const TextStyle(
                                              fontSize: 15,
                                              color: Colors.grey,
                                              fontWeight: FontWeight.normal)),
                                      const TextSpan(
                                        text: "Time: ",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                      ),
                                      TextSpan(
                                          text:
                                              "${jokes["Created_at"]!.split(" ")[1].toString().split(".")[0]}",
                                          style: const TextStyle(
                                              fontSize: 15,
                                              color: Colors.grey,
                                              fontWeight: FontWeight.normal)),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            setState(() {
                              jokesList.clear();
                              Navigator.pop(context);
                            });
                          },
                          child: Text("Clear"),
                        ),
                      ],
                    );
                  });
            },
            icon: const Icon(
              Icons.assignment,
              color: Colors.white,
            ),
          )
        ],
      ),
      body: FutureBuilder(
        future: JockData.joksData.fetchJocksData(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("${snapshot.error}"),
            );
          } else if (snapshot.hasData) {
            JoksData data = snapshot.data;

            return SafeArea(
              child: Center(
                child: Container(
                  height: double.infinity,
                  width: double.infinity,
                  color: Colors.grey,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Container(
                      height: MediaQuery.of(context).size.height / 3,
                      width: MediaQuery.of(context).size.width / 1,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(width: 4, color: Colors.blue),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blue,
                            offset: Offset(1, 1),
                            spreadRadius: 5,
                            blurRadius: 10,
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                alignment: Alignment.center,
                                height: MediaQuery.of(context).size.height / 11,
                                width: MediaQuery.of(context).size.width / 2.5,
                                color: Colors.grey.shade300,
                                child: RichText(
                                  text: TextSpan(
                                    text: 'date: ',
                                    style: const TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text:
                                            " ${data.createddate!.split(" ")[0]}",
                                        style: const TextStyle(
                                            fontSize: 20,
                                            color: Colors.blue,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Container(
                                alignment: Alignment.center,
                                height: MediaQuery.of(context).size.height / 11,
                                width: MediaQuery.of(context).size.width / 2.5,
                                color: Colors.grey.shade300,
                                child: RichText(
                                  text: TextSpan(
                                    text: 'Time: ',
                                    style: const TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                    children: <TextSpan>[
                                      TextSpan(
                                          text:
                                              " ${data.createddate!.split(" ")[1].toString().split(".")[0]}",
                                          style: const TextStyle(
                                              fontSize: 20,
                                              color: Colors.blue,
                                              fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          RichText(
                            text: TextSpan(
                              text: 'Jocks: ',
                              style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                              children: <TextSpan>[
                                TextSpan(
                                  text: "${data.value}",
                                  style: const TextStyle(
                                      fontSize: 20,
                                      color: Colors.blue,
                                      letterSpacing: 0.5,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              setState(() {
                                JoksData joke = JoksData(
                                    createddate: data.createddate,
                                    value: data.value);

                                jokesList.add(joke);
                              });
                              setState(() async {
                                final prefs =
                                    await SharedPreferences.getInstance();
                                var setdata = jsonEncode(jokesList);

                                Data();

                                prefs.setString("jokesString", setdata);
                              });
                            },
                            child: Text("Fetch For Jokes"),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
