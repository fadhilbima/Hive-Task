import 'package:flutter/material.dart';
import 'package:hive_completion/data/generate.dart';
import 'package:hive_completion/screens/add_data.dart';
import 'package:hive_completion/screens/read_data.dart';

class DetailsData extends StatefulWidget {
  DetailsData({Key? key, required this.type}) : super(key: key);

  final HiveTypeData type;
  @override
  State<DetailsData> createState() => _DetailsDataState();
}

class _DetailsDataState extends State<DetailsData> {
  late HiveTypeData _type;

  void initState() {
    super.initState();
    _type = widget.type;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_type.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(_type.author, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            Text(_type.content, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400)),
          ],
        ),
      ),
      persistentFooterAlignment: AlignmentDirectional.bottomCenter,
      persistentFooterButtons: [
        ElevatedButton(
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (p){
              return AddData(type: _type,);
            })).then((result) {
              if(result != null && result is HiveTypeData) {
                setState(() {
                  _type = result;
                });
              }
            });
          },
          child: Text('Edit'),
        ),
      ],
    );
  }
}
