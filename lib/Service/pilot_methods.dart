import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:path/path.dart';

class PilotMethods with ChangeNotifier{

  var NotAvailableDialogContext;


  Future<bool> isPassengerAvailable({var phone, var destination}) async {
    var response = await http.get(Uri.parse(
        'http://139.59.90.159:25060/passengers/isPassengerThere?phone=$phone&destination=$destination'));
    var data = jsonDecode(response.body);
    return data;
  }

  Future<void> NotAvailableDialog(context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        NotAvailableDialogContext = context;
        notifyListeners();
        return AlertDialog(
          title: const Text(
            'Passenger not available',
            style: TextStyle(
                fontSize: 15,
                fontFamily: 'Nunito Sans',
                fontWeight: FontWeight.w900,
                color: Colors.black),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: const [
                Text(
                  'The passenger has either changed the destination or is not longer searching for the ride.',
                  style: TextStyle(
                      fontSize: 15,
                      fontFamily: 'Nunito Sans',
                      fontWeight: FontWeight.w500,
                      color: Colors.black),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                'OK',
                style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'Nunito Sans',
                    fontWeight: FontWeight.w500,
                    color: Colors.black),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }


  void popNotAvailableDialogContext(s)
  {
    Navigator.of(s).pop();
  }
}
