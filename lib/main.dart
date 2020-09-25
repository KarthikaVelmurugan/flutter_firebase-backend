import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase CRUD',
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var fetchData = {};
  _fetchData() async {
    //fetch data from firebase

    CollectionReference _collectionreference =
        Firestore.instance.collection('Journey');
    _collectionreference.snapshots().listen((snapshot) {
      setState(() {
        fetchData = snapshot.documents[0].data;
        print("Fetch Data is :" + fetchData.toString());
        _toast("Fetch Data is" + fetchData.toString());
      });
    });
  }

  _addData() async {
//add data into firebase
    var data = {
      'title': 'Have a Great Journey!',
      'desc': 'Nice trip,ever never forget.'
    };
    CollectionReference _collectionreference =
        Firestore.instance.collection('Journey');
    _collectionreference.add(data);
    print("Add data successfully");
    _toast("Add data successfully!");
  }

  _updateData() async {
    //update Data
    var updateData = {
      'title': 'Enjoyable Trip',
      'desc': 'Have a pleasure moment'
    };
    CollectionReference _collectionreference =
        Firestore.instance.collection('Journey');
    QuerySnapshot _querysnapshot = await _collectionreference.getDocuments();
    _querysnapshot.documents[0].reference.updateData(updateData);
    print("update succesfully");
    _toast("update data successfully");
  }

  _deleteData() async {
//delete Data
    CollectionReference _collectionreference =
        Firestore.instance.collection('Journey');
    QuerySnapshot _querysnapshot = await _collectionreference.getDocuments();
    _querysnapshot.documents[0].reference.delete();
    print("Delete successfully");
    _toast("Delete Data succesfully");
  }

  _toast(String msg) {
    return Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter -Firebase CRUD"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            MaterialButton(
                color: Colors.green[400],
                child: Text("Fetch Data"),
                onPressed: _fetchData),
            MaterialButton(
                color: Colors.red[400],
                child: Text("Delete Data"),
                onPressed: _deleteData),
            MaterialButton(
                color: Colors.deepPurpleAccent[100],
                child: Text("Add Data "),
                onPressed: _addData),
            MaterialButton(
                color: Colors.pinkAccent[200],
                child: Text("Update Data"),
                onPressed: _updateData),
            Text(fetchData.toString()),
          ],
        ),
      ),
    );
  }
}
