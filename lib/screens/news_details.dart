
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


class MyNewDetail extends StatefulWidget {
  final String img;
  final String title;
  final String publishedAt;

  const MyNewDetail({Key key, this.img, this.title, this.publishedAt})
      : super(key: key);

  @override
  _MyNewDetailState createState() => _MyNewDetailState();
}

class _MyNewDetailState extends State<MyNewDetail> {
 

  @override
  Widget build(BuildContext context) {
    /*print("++++++++++++++urlToImage+++++++++++++>>>>>>");
    print(widget.img);
        print("+++++++++++++title++++++++++++++>>>>>>");
    print(widget.title);
        print("+++++++++++++publishedAt++++++++++++++>>>>>>");
    print(widget.publishedAt);

    */
   
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.black,
                      ),
                      onPressed: () => Navigator.of(context).pop(),
                      alignment: Alignment.topLeft,
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          widget.img,
                          fit: BoxFit.cover,
                        ),
                      ),
                     
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
