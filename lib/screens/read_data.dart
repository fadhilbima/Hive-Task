import 'package:flutter/material.dart';
import 'package:hive_completion/data/generate.dart';
import 'package:hive_completion/screens/add_data.dart';
import 'package:hive_completion/screens/detail.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_completion/data/constructor.dart' as k;

class ReadData extends StatefulWidget {
  const ReadData({Key? key}) : super(key: key);

  @override
  State<ReadData> createState() => _ReadDataState();
}

class _ReadDataState extends State<ReadData> {
  final List<HiveTypeData> _type = [];

  @override
  void initState() {
    super.initState();
    Hive.openBox<HiveTypeData>(k.keyID).then((boxy) {
      _type.addAll(boxy.values.map((e) {
        final keyNew = HiveTypeData(
          e.title,
          e.author,
          e.content,
          id: e.key,
        );
        return keyNew;
      }).toList());
    });
    refreshPage();
  }

  Future<void> deleting(int id) async {
    late Box<HiveTypeData> boxy;
    if (Hive.isBoxOpen(k.keyID)) {
      boxy = Hive.box(k.keyID);
    } else {
      boxy = await Hive.openBox(k.keyID);
    }
    await boxy.delete(id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hive Data'),
      ),
      body: Builder(
        builder: (builder) {
          if(_type.isEmpty) {
            return Center(child: Text('Data Kosong'));
          }
          return ListView.separated(
            itemBuilder: (context, snap) => ListTile(
              title: Text('${_type[snap].title} (${_type[snap].id})'),
              subtitle: Text(_type[snap].author),
              trailing: IconButton(
                onPressed: () async {
                  await showDialog<bool?>(
                    context: context,
                    builder: (p) => AlertDialog(
                      title: Text('Del'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context, true);
                          },
                          child: Text('Hapus'),
                        )
                      ],
                    ),
                  ).then((result) async {
                    if (result != null && result) {
                      deleting(_type[snap].id);
                      refreshPage();
                    }
                  });
                },
                icon: Icon(Icons.delete),
              ),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context){
                  return DetailsData(type: _type[snap]);
                }));
              },
            ),
            separatorBuilder: (context, snap) => Divider(),
            itemCount: _type.length,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (k) {
            return AddData();
          })).then((result) async {
            refreshPage();
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
  Future<void> refreshPage() async {
    late Box<HiveTypeData> boxy;
    if (Hive.isBoxOpen(k.keyID)) {
      boxy = Hive.box(k.keyID);
    } else {
      boxy = await Hive.openBox(k.keyID);
    }
    _type
      ..clear()
      ..addAll(boxy.values.map((e) {
        final keyNew = HiveTypeData(
          e.title,
          e.author,
          e.content,
          id: e.key
        );
        return keyNew;
      }).toList());
    setState(() {});
  }
}