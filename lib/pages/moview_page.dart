import 'package:flutter/material.dart';
import 'package:moview_app/models/moview.dart';
import 'package:moview_app/globals.dart' as globals;
import 'package:moview_app/widgets/moview_item.dart';

class MoviewPage extends StatefulWidget {
  MoviewPage({Key? key}) : super(key: key);

  @override
  State<MoviewPage> createState() => _MoviewPageState();
}

class _MoviewPageState extends State<MoviewPage> {
  final TextEditingController moviewController = TextEditingController();


  Moview? deletedMoview;
  int? deletedMoviewPos;

  String? errorText;

  @override
  void initState() {
    super.initState();

    globals.moviewRepository.getMoviewList().then((value) {
      setState(() {
        globals.moviews = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {

    return SafeArea(
        child: Scaffold(
          body: Center(
              child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ElevatedButton.icon(
                        label: Text('Adicionar Filme', style: TextStyle(fontSize: 30)),
                        icon: Icon(Icons.add, size: 30),
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            "/add",
                          );
                        },
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Flexible(
                        child: ListView(
                          shrinkWrap: true,
                          children: [
                            for (Moview moview in globals.moviews)
                              MoviewItem(
                                  moview: moview,
                                  onEdit: onEdit,
                                  onDelete: onDelete),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Text(globals.moviews.length == 1
                                ? 'Você possui ${globals.moviews.length} filme avaliado'
                                : 'Você possui ${globals.moviews.length} filmes avaliados'),
                          ),
                          SizedBox(
                            width: 8,
                          )
                        ],
                      )
                    ],
                  ))),
        ));
  }

  void onEdit(Moview moview) {
    globals.indexEdit = globals.moviews.indexOf(moview);
    Navigator.pushNamed(
      context,
      "/edit",
    );
  }

  void onDelete(Moview moview) {
    deletedMoview = moview;
    deletedMoviewPos = globals.moviews.indexOf(moview);
    setState(() {
      globals.moviews.remove(moview);
    });
    globals.moviewRepository.saveMoviewList(globals.moviews);

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Filme ${moview.title} foi removido com sucesso!',
          style: TextStyle(color: Color(0xff060708)),
        ),
        backgroundColor: Colors.white,
        action: SnackBarAction(
          label: 'Desfazer',
          textColor: const Color(0xff00d7f3),
          onPressed: () {
            setState(() {
              globals.moviews.insert(deletedMoviewPos!, deletedMoview!);
            });
            globals.moviewRepository.saveMoviewList(globals.moviews);
          },
        ),
        duration: const Duration(seconds: 5),
      ),
    );
  }
}
