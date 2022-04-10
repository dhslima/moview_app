import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:moview_app/models/moview.dart';
import 'package:intl/intl.dart';
import 'package:moview_app/globals.dart' as globals;

class MoviewItem extends StatelessWidget {
  const MoviewItem({Key? key, required this.moview, required this.onEdit, required this.onDelete}) : super(key: key);

  final Moview moview;
  final Function(Moview) onEdit;
  final Function(Moview) onDelete;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2),
      child: Slidable(
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4), color: Colors.grey[200]),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                moview.dateTime.isEmpty ? DateFormat("dd/MM/yyyy").format(DateTime.now()).toString() : moview.dateTime,
                style: TextStyle(fontSize: 12),
              ),
              Text(
                moview.title,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              Text(
                "NOTA: " + moview.rate.toString(),
                style: TextStyle(fontSize: 16),
              ),
              ElevatedButton.icon(
                label: Text('Ver avaliação detalhada', style: TextStyle(fontSize: 12)),
                icon: Icon(Icons.search, size: 12),
                onPressed: () {
                  globals.indexEdit = globals.moviews.indexOf(moview);
                  Navigator.pushNamed(
                    context,
                    "/details",
                  );
                },
              ),
            ],
          ),
        ),
        actionExtentRatio: 0.25,
        actionPane: const SlidableDrawerActionPane(),
        secondaryActions: [
          IconSlideAction(
            color: Colors.amber,
            icon: Icons.edit,
            caption: 'Editar',
            onTap: () {
              onEdit(moview);
            },
          ),
          IconSlideAction(
            color: Colors.red,
            icon: Icons.delete,
            caption: 'Deletar',
            onTap: () {
              onDelete(moview);
            },
          ),
        ],
      ),
    );
  }
}
