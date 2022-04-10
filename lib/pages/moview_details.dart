import 'package:flutter/material.dart';
import '../models/moview.dart';
import 'package:moview_app/globals.dart' as globals;

class MoviewDetailsPage extends StatefulWidget {
  MoviewDetailsPage({Key? key}) : super(key: key);

  @override
  State<MoviewDetailsPage> createState() => _MoviewDetailsPageState();
}

class _MoviewDetailsPageState extends State<MoviewDetailsPage> {

  final TextEditingController titleMoviewController = TextEditingController();
  final TextEditingController dataMoviewController = TextEditingController();
  final TextEditingController avaliacaoMoviewController = TextEditingController();
  String? errorTextTitle;


  @override
  Widget build(BuildContext context) {

    Moview moview = globals.moviews.elementAt(globals.indexEdit);



    return SafeArea(
        child: Scaffold(
          body: Center(
              child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                              moview.title,
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 50),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                              moview.dateTime,
                              style: TextStyle(fontSize: 20),
                          ),
                          Text(
                              moview.rate.toString(),
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          Text(
                              moview.review,
                              style: TextStyle(fontSize: 15),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          ElevatedButton.icon(
                            label: Text('Voltar', style: TextStyle(fontSize: 20)),
                            icon: Icon(Icons.arrow_back, size: 20),
                            onPressed: () {
                              Navigator.pop(
                                  context);
                            },
                          )
                        ],
                      )
                    ],
                  ))),
        ));
  }

}