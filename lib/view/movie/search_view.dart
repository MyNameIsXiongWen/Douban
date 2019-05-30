import 'package:flutter/material.dart';
// import 'package:hhh/utils/http_manager.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {

  TextEditingController _searchTextCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        titleSpacing: 0,
        elevation: 1,
        title: buildAppBarTitle(),
      ),
      body: ListView.builder(
        itemCount: 20,
        itemBuilder: (context, index) {
          return Text('=======$index');
        },
      ),
    );
  }

  Widget buildAppBarTitle() {
    return Container(
      width: MediaQuery.of(context).size.width - 30,
      height: 64,
      child: Stack(
        alignment: Alignment.centerLeft,
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Container(
              width: MediaQuery.of(context).size.width - 30 - 45,
              height: 30,
              color: Color(0xFFf5f5f5),
            ),
          ),
          Positioned(
            left: 10,
            child: Image.asset(
              'images/search_default.png',
              height: 23,
            ),
          ),
          Positioned(
              left: 40,
              child: Container(
                width: MediaQuery.of(context).size.width - 30 - 80,
                height: 30,
                child: TextField(
                  autofocus: true,
                  controller: _searchTextCtrl,
                  maxLines: 1,
                  textInputAction: TextInputAction.search,
                  decoration: InputDecoration(
                      hintText: '电影当中打动你的告白瞬间',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(top: 5)),
                  style: TextStyle(fontSize: 14),
                  onChanged: (content) {
                    print(content);
                  },
                ),
              )),
          Positioned(
            right: 0,
            child: GestureDetector(
              child: Text(
                '取消', 
                style: TextStyle(
                  fontSize: 16, 
                  color: Colors.green, 
                  fontWeight: FontWeight.w300, 
                )
              ),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
          )
        ],
      ),
    );
  }
}