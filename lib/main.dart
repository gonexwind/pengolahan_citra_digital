import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.teal,
        statusBarIconBrightness: Brightness.light,
      ),
      child: SafeArea(
        child: Scaffold(
          body: ListView(
            children: [
              _buildHeader(context),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    Center(
                        child: _image == null
                            ? Text('No image selected.')
                            : Image.file(_image)),
                    SizedBox(height: 30),
                    _buildButton(
                        text: 'GreyScale',
                        onPressed: () =>
                            showAlertDialog(context, 'GreyScale', greyScale)),
                    _buildButton(
                        text: 'Lighten',
                        onPressed: () =>
                            showAlertDialog(context, 'Lighten', lighten)),
                    _buildButton(
                        text: 'Green',
                        onPressed: () =>
                            showAlertDialog(context, 'Green', green)),
                    _buildButton(
                        text: 'Magenta',
                        onPressed: () =>
                            showAlertDialog(context, 'Magenta', magenta)),
                  ],
                ),
              ),
              SizedBox(height: 50),
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
        ),
      ),
    );
  }

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

  Widget _buildButton({String text, Function onPressed}) {
    return Container(
      width: double.infinity,
      child: MaterialButton(
        color: Colors.teal,
        textColor: Colors.white,
        child: Text(text),
        onPressed: onPressed,
      ),
    );
  }

  Widget _button({String text, Function onPressed}) {
    return Container(
      width: double.infinity,
      child: MaterialButton(
        color: Colors.teal,
        textColor: Colors.white,
        child: Text(text),
        onPressed: onPressed,
      ),
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

  Widget _buildHeader(BuildContext context) {
    return Container(
      height: (MediaQuery.of(context).orientation == Orientation.landscape)
          ? 110
          : 120,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.teal,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(50),
          bottomRight: Radius.circular(50),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 10),
          Text(
            'Pengolahan Citra Digital',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
            ),
          ),
          Text(
            'Fikky Ardianto',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
          Text(
            '201851136',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
          Text(
            'Kelas Y',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}
