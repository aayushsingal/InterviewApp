import 'package:flutter/material.dart';
import 'package:flutter_application_2/models/data_model.dart';
import 'package:http/http.dart' as http;

class NextPage extends StatefulWidget {
  final String inputString;
  const NextPage({Key key, this.inputString}) : super(key: key);

  @override
  State<NextPage> createState() => _NextPageState();
}

class _NextPageState extends State<NextPage> {
  List<Posts> _posts;

  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    try {
      var reponse =
          await http.get("https://jsonplaceholder.typicode.com/posts");

      setState(() {
        _posts = postsFromJson(reponse.body);
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Posts"),
          centerTitle: true,
        ),
        body: _posts == null
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(itemBuilder: (context, i) {
                return ListTile(
                  title: Text(
                    _posts[i].title,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black87,
                    ),
                  ),
                  subtitle: Text(
                    _posts[i].body,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.black54,
                    ),
                  ),
                );
              }));
  }
}
