import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test2/provider.dart';
import 'package:flutter_test2/showScreen.dart';
import 'package:provider/provider.dart';

class FirstScreen extends StatefulWidget {
  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  FilePickerResult? result;
  LineSplitter lineSplitter = LineSplitter();
  File? file;
  var value;
  var number;
  List<dynamic> list = [];
  var item;

  @override
  Widget build(BuildContext context) {
    Future<dynamic> getFile() async {
      result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['txt'],
      );

      file = File(
          "${result!.paths.asMap().toString().replaceAll('{', '').replaceAll('}', '').substring(4)}");
      var text = await file!.readAsString();
      setState(() {
        value = text;
        lineSplitter.convert(value!);

        for (var item in lineSplitter.convert(value!)) {
          number = item;
          if (number.startsWith('98') && number.length <= 12) {
            print(number);
            list.add(number);
          }
        }
      });
    }

    final provider = Provider.of<MyModelProvider>(context);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(25),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 12),
                ),
                child: Text('Get Data'),
                onPressed: () {
                  list.clear();
                  getFile();
                },
              ),
            ),
            number == null
                ? Card(
                    elevation: 10,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text('Empty'),
                    ),
                  )
                : Card(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(35),
                      child: Container(
                        width: 100,
                        height: 50,
                        child:
                            // Text(
                            //   '${number}',
                            // ),
                            ListView(
                          children: [
                            Text(
                              '${list.toString().replaceAll("[", "").replaceAll("]", "").replaceAll(",", "\n")}',
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text('Save'),
              onPressed: () {
                provider.addProduct(
                  list
                      .toString()
                      .replaceAll("[", "")
                      .replaceAll("]", "")
                      .replaceAll(",", "\n"),
                  'name',
                );
              },
            ),
            SizedBox(height: 10),
            ElevatedButton(
              child: Text('show screen'),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ShowScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
//.replaceAll(",", "\n")
//value!.startsWith('98') || value!.length <=12
