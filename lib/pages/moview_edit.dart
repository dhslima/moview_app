import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/moview.dart';
import 'package:moview_app/globals.dart' as globals;

class MoviewEditPage extends StatefulWidget {
  MoviewEditPage({Key? key}) : super(key: key);

  @override
  State<MoviewEditPage> createState() => _MoviewEditPageState();
}

class _MoviewEditPageState extends State<MoviewEditPage> {

  final TextEditingController titleMoviewController = TextEditingController();
  final TextEditingController dataMoviewController = TextEditingController();
  final TextEditingController avaliacaoMoviewController = TextEditingController();
  String? errorTextTitle;
  double _value = 0;

  @override
  Widget build(BuildContext context) {

    Moview moview = globals.moviews.elementAt(globals.indexEdit);

    titleMoviewController.text = moview.title;
    avaliacaoMoviewController.text = moview.review.toString();

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
                          TextField(
                            controller: titleMoviewController,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Título do Filme',
                                errorText: errorTextTitle,
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color(0xff00d7f3),
                                        width: 2
                                    )
                                ),
                                labelStyle: TextStyle(
                                    color: Color(0xff00d7f3)
                                )
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          TextField(
                            controller: dataMoviewController, //editing controller of this TextField
                            decoration: InputDecoration(
                                icon: Icon(Icons.calendar_today), //icon of text field
                                labelText: "Quando você assistiu?" //label text of field
                            ),
                            readOnly: true,
                            onTap: () async {
                              DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2000), //DateTime.now() - not to allow to choose before today.
                                  lastDate: DateTime.now()
                              );

                              if(pickedDate != null ){
                                String formattedDate = DateFormat('dd-MM-yyyy').format(pickedDate);
                                //you can implement different kind of Date Format here according to your requirement
                                setState(() {
                                  dataMoviewController.text = formattedDate; //set output date to TextField value.
                                });
                              }else{
                                print("Date is not selected");
                              }
                            },
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                            controller: avaliacaoMoviewController,
                            minLines: 5,
                            maxLines: 5,
                            keyboardType: TextInputType.multiline,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Avaliação',
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color(0xff00d7f3),
                                        width: 2
                                    )
                                ),
                                labelStyle: TextStyle(
                                    color: Color(0xff00d7f3)
                                )
                            ),
                          ),
                          Column(
                            children: [
                              SizedBox(
                                height: 16,
                              ),
                              Text("Qual sua nota?", style: TextStyle(fontSize: 20)),
                              Slider(
                                min: 0.0,
                                max: 10.0,
                                value: _value,
                                divisions: 20,
                                label: '${_value}',
                                onChanged: (value) {
                                  setState(() {
                                    _value = value;
                                  });
                                },
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ElevatedButton.icon(
                                label: Text('Salvar Mudanças', style: TextStyle(fontSize: 20)),
                                icon: Icon(Icons.edit, size: 20),
                                onPressed: () {
                                  if(titleMoviewController.text.isEmpty) {
                                    setState(() {
                                      errorTextTitle = 'O titulo não pode ser vazio';
                                    });
                                    return;
                                  }

                                  setState(() {
                                    globals.moviews.elementAt(globals.indexEdit).title = titleMoviewController.text;
                                    globals.moviews.elementAt(globals.indexEdit).dateTime = dataMoviewController.text;
                                    globals.moviews.elementAt(globals.indexEdit).review = avaliacaoMoviewController.text;
                                    globals.moviews.elementAt(globals.indexEdit).rate = _value;

                                    errorTextTitle = null;
                                  });

                                  globals.moviewRepository.saveMoviewList(globals.moviews);

                                  Navigator.pushNamed(
                                    context,
                                    "/",
                                  );

                                },
                              ),

                              ElevatedButton.icon(
                                label: Text('Cancelar', style: TextStyle(fontSize: 20)),
                                icon: Icon(Icons.close, size: 20),
                                onPressed: () {
                                  Navigator.pop(
                                      context);
                                },
                              )
                            ],
                          )
                        ],
                      )
                    ],
                  ))),
        ));
  }

}