import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_completion/data/generate.dart';
import 'package:hive_completion/data/constructor.dart' as cons;

class AddData extends StatefulWidget {
  const AddData({Key? key, this.type}) : super(key: key);

  final HiveTypeData? type;
  @override
  State<AddData> createState() => _AddDataState();
}

class _AddDataState extends State<AddData> {
  final _title = TextEditingController();
  final _author = TextEditingController(text: 'Author Name');
  final _content = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    if (widget.type != null) {
      _title.text = widget.type!.title;
      _author.text = widget.type!.author;
      _content.text = widget.type!.content;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hive Add Data'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Text(
                    'Add your data down below',
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w500
                    ),
                    textAlign: TextAlign.center
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: TextFormField(
                  controller: _title,
                  decoration: InputDecoration(
                      hintText: 'Type your title',
                      labelText: 'Title',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)
                      )
                  ),
                  validator: (nilai) {
                    if (nilai == null || nilai.isEmpty) {
                      return 'Title required';
                    }
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: TextFormField(
                  enabled: false,
                  controller: _author,
                  decoration: InputDecoration(
                      labelText: 'Author',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)
                      )
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: TextFormField(
                  controller: _content,
                  decoration: InputDecoration(
                      hintText: 'Type your content',
                      labelText: 'Content',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)
                      )
                  ),
                  validator: (nilai) {
                    if (nilai == null || nilai.isEmpty) {
                      return 'Title required';
                    }
                  },
                ),
              ),
              SizedBox(height: 20),
              Container(
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        late Box<HiveTypeData> openKey;
                        final isOpen = Hive.isBoxOpen(cons.keyID);
                        if(isOpen) {
                          openKey = Hive.box(cons.keyID);
                        } else {
                          openKey = await Hive.openBox(cons.keyID);
                        }
                        final key = HiveTypeData(
                          _title.text,
                          _author.text,
                          _content.text,
                        );
                        
                        if(widget.type != null) {
                          openKey.put(widget.type!.id, key).then((k) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Post Updated'),
                              )
                            );
                            Navigator.pop(
                              context,
                              HiveTypeData(
                                key.title,
                                key.author,
                                key.content,
                                id: widget.type!.id,
                              ),
                            );
                          }).onError((error, stackTrace) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(error.toString()),
                              )
                            );
                          });
                        } else {
                          openKey.add(key).then((id) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Post $id Created'),
                              ),
                            );
                            Navigator.pop(context);
                          }).onError((error, stackTrace) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(error.toString()),
                              )
                            );
                          });
                        }
                      }
                    },
                    child: Text('Submit'),
                  )
              )
            ],
          ),
        )
      ),
    );
  }
}
