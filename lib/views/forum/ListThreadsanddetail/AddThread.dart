
import 'dart:ui';


import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:geeks_overflow/entities/ForumCategory.dart';
import 'package:geeks_overflow/entities/ForumUser.dart';
import 'package:geeks_overflow/entities/User.dart';
import 'package:geeks_overflow/views/var.dart';
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';




class UploadImageDemo extends StatefulWidget {

  Future<SharedPreferences> _prefs;

  final String title = "Add new thread";
  final subreddist usernameController;//if you have multiple values add here
  UploadImageDemo(this.usernameController, {Key key}): super(key: key);





  @override
  UploadImageDemoState createState() => UploadImageDemoState();


}

class UploadImageDemoState extends State<UploadImageDemo> {
  //
  User loggedInUser ;
  Future<SharedPreferences> _prefs;
  @override
  void initState() {
    _prefs = SharedPreferences.getInstance();
    _prefs.then((SharedPreferences prefs) {
      setState(() {
        Map<String, dynamic> text = jsonDecode(prefs.get("go_user"));
        this.loggedInUser = User.fromJsonMap(text);
      });
    });
    super.initState();
  }

  final titlec = TextEditingController();
  final descc = TextEditingController();
  String ppp ;
  static final String uploadEndPoint =
      Var.link+"/thread/uploadattachement";
  static final String addthread =
      Var.link+"/thread/add";
  Future<File> file;
  String status = '';
  String base64Image;
  File tmpFile;
  String fileName ;
  String errMessage = 'Error Uploading Image';
  String errnodesc = 'No description found';
  String errnotitle = 'No title found';
  chooseImage() {
    setState(() {
      file = ImagePicker.pickImage(source: ImageSource.gallery);

    });
    setStatus('');
  }

  setStatus(String message) {
    setState(() {
      status = message;
    });
  }

  startUpload() async {
    setStatus('Uploading Image...');
    if (null == tmpFile) {
      setStatus(errMessage);
      return;
    }
    if (titlec.text == '') {
      setStatus(errnotitle);
      return;
    }
    if (descc.text == "") {
      setStatus(errnodesc);
      return;
    }


    var res1 = await createAlbum().then((value) => print(value));
    fileName = tmpFile.path.split('/').last;

    var res = await uploadimg(tmpFile);
  }

  Future<http.Response> createAlbum() {

    ForumUser u = new ForumUser();
    u.username = this.loggedInUser.username;
    u.id = this.loggedInUser.id;
    u.email =this.loggedInUser.email;
    u.password = this.loggedInUser.password;
    u.firstName =  this.loggedInUser.firstName;
    u.lastName =  this.loggedInUser.lastName;
    u.dob = this.loggedInUser.dob;
    u.role = this.loggedInUser.role;
    u.status= this.loggedInUser.status;


    subreddist subr = new subreddist();
    subr.Name = widget.usernameController.Name;
    subr.id = widget.usernameController.id;
    subr.description = widget.usernameController.description;
    subr.idcateg = widget.usernameController.idcateg;
    var now = new DateTime.now();
    return http.post(
      addthread,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'title': titlec.text ,
        'description' : descc.text,
        'sender' :u,
        'addtime' : now.toString(),
        'likes' : '0' ,
        'subreddit' :subr,
        'dislikes' : '0'
      }),
    ).then((res) {
      print(res.body);
      this.ppp = res.body;
    }).catchError((err) {
      print(err);
    });
  }



  Future<String> uploadimg(File file) async {
    Dio dio = new Dio();
    FormData formData = new FormData.from({

      "file": new UploadFileInfo(new File(file.path), ppp+".jpg")
    });
 var  response = await dio.post(uploadEndPoint, data: formData);
  }

  Future<String> uploadImage(filename, url) async {
    var request = http.MultipartRequest('POST', Uri.parse(url));


    request.files.add(await http.MultipartFile.fromPath('picture', filename));

    var res = await request.send();
    return res.reasonPhrase;
  }

  Widget showImage() {
    return FutureBuilder<File>(
      future: file,
      builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            null != snapshot.data) {
          tmpFile = snapshot.data;
          base64Image = base64Encode(snapshot.data.readAsBytesSync());
          return Flexible(
            child: Image.file(
              snapshot.data,
              fit: BoxFit.fitHeight,
            ),
          );
        } else if (null != snapshot.error) {
          return const Text(
            'Error Picking Image',
            textAlign: TextAlign.center,
          );
        } else {
          return const Text(
            'No Image Selected',
            textAlign: TextAlign.center,
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add  new Thread"),
      ),
      body: Container(
        padding: EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(

              controller: titlec,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Title',
                  hintText: 'Title'),
            ),
            SizedBox(
              height: 10,
            ),

            TextField(

              controller: descc,
              keyboardType: TextInputType.multiline,
              maxLines: 3,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Description',
                  hintText: 'Note'),
            ),
            SizedBox(
              height: 10,
            ),

            OutlineButton(
              onPressed: chooseImage,
              child: Text('Choose Image'),
            ),
            SizedBox(
              height: 10.0,
            ),

            showImage(),
            SizedBox(
              height: 10.0,
            ),
            OutlineButton(
              onPressed: startUpload,
              child: Text('Add Thread'),
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              status,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.w500,
                fontSize: 10.0,
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
          ],
        ),
      ),
    );
  }
}