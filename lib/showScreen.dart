import 'package:flutter/material.dart';
import 'package:flutter_test2/provider.dart';
import 'package:provider/provider.dart';

class ShowScreen extends StatefulWidget {
  @override
  _ShowScreenState createState() => _ShowScreenState();
}

class _ShowScreenState extends State<ShowScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
        future: Provider.of<MyModelProvider>(context, listen: false)
            .fetchAndSetFile(),
        builder: (context, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Consumer<MyModelProvider>(
                child: Center(
                  child: Text(
                    'خالی است',
                  ),
                ),
                builder: (context, product, child) => product.item.length <= 0
                    ? child!
                    : ListView.builder(
                        itemCount: product.item.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              elevation: 10,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Dismissible(
                                background: Container(
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).errorColor,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  padding: EdgeInsets.only(right: 10),
                                  alignment: Alignment.centerRight,
                                  child: Icon(
                                    Icons.delete_forever,
                                    size: 30,
                                    color: Colors.white,
                                  ),
                                ),
                                key: ValueKey(product.item[index].id),
                                onDismissed: (value) {
                                  setState(() {
                                    // DBHelperFavorite.delete(
                                    //     product.item[index].id);
                                  });
                                },
                                child: Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.symmetric(vertical: 15),
                                  child: Column(
                                    children: [
                                      Text(product.item[index].id),
                                      Text(product.item[index].name),
                                      Text(product.item[index].number),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
              ),
      ),
    );
  }
}
