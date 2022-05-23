import 'package:flutter/material.dart';
import 'package:fast_meals/constants/data.dart';
import 'package:fast_meals/constants/measurement.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<bool> isFav = data.map((e) => false).toList();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: customAppBar(),
        body: ListView.builder(
            padding: const EdgeInsets.symmetric(
                horizontal: 8, vertical: 5),
            itemCount: data.length,
            itemBuilder: (cxt, index) => GestureDetector(
                  onTap: () => {
                    customModalBottomSheet(context, index)
                  },
                  child: customListTile(index),
                )));
  }

  Container customListTile(int index) {
    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.only(bottom: 8),
      height: 120,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: const [
            BoxShadow(color: Colors.black12, blurRadius: 2)
          ]),
      child: Row(
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Image.asset(
                  "images/${data[index]['image_url']}",
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                mainAxisAlignment:
                    MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    data[index]['name'].toString(),
                    style: GoogleFonts.lobster(
                      textStyle: const TextStyle(
                        fontSize: 17,
                      ),
                    ),
                  ),
                  Text(
                    "₹ " +
                        data[index]['cost_for_one']
                            .toString(),
                    style: GoogleFonts.notoSerif(
                        textStyle: const TextStyle(
                            fontSize: 15,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w500)),
                  ),
                ],
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              !isFav[index]
                  ? IconButton(
                      onPressed: () => {
                        setState(() => isFav[index] = true)
                      },
                      icon: const Icon(
                        Icons.favorite_border_outlined,
                        color: Colors.red,
                        size: 26,
                      ),
                    )
                  : IconButton(
                      onPressed: () => {
                        setState(() => isFav[index] = false)
                      },
                      icon: const Icon(
                        Icons.favorite,
                        color: Colors.red,
                        size: 26,
                      ),
                    ),
              const SizedBox(
                height: 10,
              ),
              Text(
                data[index]['rating'].toString(),
                style: GoogleFonts.notoSerif(
                    textStyle: const TextStyle(
                  fontWeight: FontWeight.w500,
                )),
              ),
            ],
          ),
        ],
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
      ),
    );
  }

  Future<dynamic> customModalBottomSheet(
      BuildContext context, int index) {
    return showModalBottomSheet(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
                top: Radius.circular(10))),
        context: context,
        builder: (cxt) => Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Pay Out",
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        data[index]['name'].toString(),
                        style: GoogleFonts.lobster(
                          textStyle: const TextStyle(
                            fontSize: 17,
                          ),
                        ),
                      ),
                      Text(
                        "₹ " +
                            data[index]['cost_for_one']
                                .toString(),
                        style: GoogleFonts.notoSerif(
                            textStyle: const TextStyle(
                                fontSize: 16,
                                fontWeight:
                                    FontWeight.w600)),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                      onPressed: () =>
                          {print("order placed")},
                      child: const Center(
                          child: Text("Place Order"))),
                  const SizedBox(
                    height: 8,
                  )
                ],
              ),
            ));
  }

  AppBar customAppBar() {
    return AppBar(
      backgroundColor: Colors.green,
      title: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text("Fast Foods",
            style: GoogleFonts.dancingScript(
              textStyle: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w300),
            )),
      ),
      actions: const [
        Icon(Icons.search_outlined, size: iconSize),
        Padding(
          padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
          child: Icon(
            Icons.filter_list,
            size: iconSize,
          ),
        ),
      ],
      elevation: 1,
    );
  }
}
