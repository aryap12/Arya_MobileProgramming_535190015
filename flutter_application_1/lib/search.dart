import 'package:flutter_application_1/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/url.dart';
import 'package:flutter_application_1/Detail.dart';

class Search extends StatefulWidget {
  final String kunci;
  Search({Key key, @required this.kunci}) : super(key: key);
  @override
  _State createState() => _State();
}

class _State extends State<Search> {
  List<Model> srcList;

  getSrc() async {
    if (srcList == null) {
      srcList = new List<Model>();
    }
    print("pulling search list");
    var pull = await Pokepull.fetchpokemon(widget.kunci.toString());
    if (pull != null) {
      setState(() {
        srcList.add(Model.detailfromJson(pull));
      });
    }
    print(srcList.length);
    return srcList;
  }

  @override
  // ignore: override_on_non_overriding_member
  void initstate() {
    super.initState();
    getSrc();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("hasil"),
        ),
        body: Container(
            child: srcList.length > 0
                ? GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 5,
                        mainAxisSpacing: 2,
                        childAspectRatio: 1.5),
                    itemCount: srcList.length,
                    itemBuilder: (
                      BuildContext context,
                      int index,
                    ) {
                      return Card(
                        elevation: 10.0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        margin: EdgeInsets.fromLTRB(20.0, 12.0, 20.0, 12.0),
                        child: Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Column(children: [
                            Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "#${srcList[index].num} ${srcList[index].name}",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 13),
                                )),
                            InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Detail(
                                                model: srcList[index],
                                              )));
                                  SizedBox(height: 6.0);
                                },
                                child: Container(
                                  width: 100,
                                  height: 75,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            srcList[index].sprites),
                                        scale: 0.6,
                                        fit: BoxFit.cover),
                                  ),
                                ))
                          ]),
                        ),
                      );
                    },
                  )
                : Container(
                    child: Center(
                    child: CircularProgressIndicator(
                      valueColor: new AlwaysStoppedAnimation<Color>(Colors.red),
                    ),
                  ))));
  }
}
