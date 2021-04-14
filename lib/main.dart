import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pengolahan_citra_digital/constant.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pengolahan Citra Digital',
      theme: ThemeData(primarySwatch: Colors.teal),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  File _image;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future getFile() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pengolahan Citra Digital'),
      ),
      body: ListView(
        children: [
          Center(
              child: _image == null
                  ? Text('No image selected.')
                  : Image.file(_image)),
          _buildButton(
              text: 'Hitam Putih',
              onPressed: () =>
                  showAlertDialog(context, 'Hitam Putih', hitamPutih)),
          _buildButton(
              text: 'Ijo',
              onPressed: () => showAlertDialog(context, 'Ijo', ijo)),
          _buildButton(
              text: 'Magenta',
              onPressed: () => showAlertDialog(context, 'Magenta', magenta)),
        ],
      ),
      floatingActionButton: SpeedDial(
        icon: Icons.add,
        activeIcon: Icons.cancel,
        visible: true,
        closeManually: false,
        children: [
          SpeedDialChild(
            child: Icon(Icons.camera_alt),
            label: 'Ambil Gambar',
            onTap: getImage,
          ),
          SpeedDialChild(
            child: Icon(Icons.photo_library),
            label: 'Pilih Foto',
            onTap: getFile,
          )
        ],
      ),
    );
  }

  Widget _buildButton({String text, Function onPressed}) {
    return MaterialButton(
      color: Colors.teal,
      textColor: Colors.white,
      child: Text(text),
      onPressed: onPressed,
    );
  }

  showAlertDialog(BuildContext context, String title, List<double> filter) {
    Widget okButton = MaterialButton(
      child: Text("OK"),
      onPressed: () => Navigator.of(context).pop(),
    );

    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: ColorFiltered(
        colorFilter: ColorFilter.matrix(filter),
        child: Image.file(_image),
      ),
      actions: [
        okButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
