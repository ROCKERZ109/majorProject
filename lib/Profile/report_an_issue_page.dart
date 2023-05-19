import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import '../sizeConfig.dart';
import 'package:http/http.dart' as http;

class ReportIssueForm extends StatefulWidget {
  const ReportIssueForm({super.key});

  @override
  _ReportIssueFormState createState() => _ReportIssueFormState();
}

class _ReportIssueFormState extends State<ReportIssueForm> {
  final _formKey = GlobalKey<FormState>();
  String _issueDescription = '';
  void upload(context, File imageFile) async {
    const String url = 'http://209.38.239.223/uploads';

    var request = http.MultipartRequest('POST', Uri.parse(url));
    print(imageFile.path);
    request.files
        .add(await http.MultipartFile.fromPath('image', imageFile.path));
    var res = await request.send();
    final respStr = await res.stream.bytesToString();
    print(respStr.toString());
    if (res.statusCode == 200) {
      Navigator.pop(context);
      var str = dirname(imageFile.path);
      str = imageFile.path.substring(
        imageFile.path.lastIndexOf('/') + 1,
      );


    } else {
      print('Nahi Chalega');
    }
  }

  void _submitForm(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      // Perform the form submission logic here
      submitIssue(_issueDescription,context);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Issue reported successfully')),
      );

      _formKey.currentState!.reset();
    }
  }

  Future<void> submitIssue(String issueDescription,  BuildContext context)  async {
    var url = Uri.parse('http://209.38.239.190/feedback/crossFeedback');
    Map<String, String> headers = {'Content-Type': 'application/json'};
    var response = await http.post(
        url,
        body: jsonEncode({'issue_description': issueDescription}),
        headers: headers
    );
    if (response.statusCode == 200) {
      Navigator.pop(context);
      // Request successful, do something with the response
      print('Response body: ${response.body}');
    } else {
      // Request failed, handle the error
      print('Request failed with status: ${response.statusCode}');
    }
  }

  var showPicture=false;
  var opened;
  var resize;
  File?image;
  Future UploadImage(ImageSource source) async {
    // Permission permission;
    //
    // if (Platform.isIOS) {
    //   permission = Permission.photos;
    // } else {
    //   permission = Permission.storage;
    // }
    //
    // PermissionStatus permissionStatus = await permission.status;
    //
    // print(permissionStatus);
    //
    // if (permissionStatus == PermissionStatus.restricted) {
    //
    //
    //   permissionStatus = await permission.status;
    //
    //   if (permissionStatus != PermissionStatus.granted) {
    //     //Only continue if permission granted
    //     return;
    //   }
    // }
    //
    // if (permissionStatus == PermissionStatus.permanentlyDenied) {
    //   _showOpenAppSettingsDialog(context);
    //
    //   permissionStatus = await permission.status;
    //
    //   if (permissionStatus != PermissionStatus.granted) {
    //     //Only continue if permission granted
    //     return;
    //   }
    // }
    //
    // if (permissionStatus == PermissionStatus.undetermined) {
    //   permissionStatus = await permission.request();
    //
    //   if (permissionStatus != PermissionStatus.granted) {
    //     //Only continue if permission granted
    //     return;
    //   }
    // }
    //
    // if (permissionStatus == PermissionStatus.denied) {
    //   if (Platform.isIOS) {
    //     _showOpenAppSettingsDialog(context);
    //   } else {
    //     permissionStatus = await permission.request();
    //   }
    //
    //   if (permissionStatus != PermissionStatus.granted) {
    //     //Only continue if permission granted
    //     return;
    //   }
    // }
    //
    // if (permissionStatus == PermissionStatus.granted) {
    //   print('Permission granted');
    try {
      final image =
      await ImagePicker().pickImage(source: source, imageQuality: 30);
      if (image == null) return;
      final imageTemp = File(image.path);
      setState(() {
        this.image = imageTemp;
        opened = true;
        print(this.image);
        resize = 5;
        showPicture = true;
      });
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color.fromARGB(255, 230, 230, 230),
        foregroundColor: Colors.black,
        automaticallyImplyLeading: false,
        title: const Text('Describe the issue'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: SizeConfig.blockSizeVertical * 3,
                ),
                const Text(
                  'To ensure a seamless user experience, kindly provide a concise summary of any technical issues or challenges faced while using the app or during a ride.'
                  ,style: TextStyle(fontSize: 16,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Nunito Sans',

                  ),
                ),
                const SizedBox(height: 10),

                TextFormField(
                  maxLines: 10,
                  validator: (value) {
                    if (value == null || value.isEmpty &&showPicture==false) {
                      return 'Please enter the issue description';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _issueDescription = value!;
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'enter issue here',
                  ),
                ),
                const SizedBox(height: 7),
                GestureDetector(
                 onTap: (){
                   UploadImage(ImageSource.gallery);
                 },
                  child: SizedBox(
                    // color: Colors.grey,
                    height: SizeConfig.safeBlockVertical*6,
                    width: SizeConfig.safeBlockHorizontal*100,

                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Text('Click here to attach screenshot!',
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Nunito Sans',
                            fontSize: 17
                        ),
                        ),
                        const Icon(Icons.attach_file),
                        Visibility(
                            visible: showPicture,
                            child: const Icon(Icons.check,
                            color: Colors.green,
                            ))
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: SizeConfig.safeBlockVertical*5,
                ),
                ElevatedButton(
                  onPressed:(){
                    _submitForm(context);
                    upload(context, image!);
                    showPicture=false;
                    setState(() {
                      
                    });

                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: const Color.fromARGB(255, 230, 230, 230),
                    splashFactory: NoSplash.splashFactory,
                    elevation: 0,
                  ),
                  child: const Text(
                    "Submit",
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Nunito Sans',
                        fontSize: 20),
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
