import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart' as ph;
import 'package:veloce/sizeConfig.dart';
import 'package:location/location.dart';

class FirstScreen extends StatefulWidget {
  final screenName;

  const FirstScreen({super.key, required this.screenName});

  static double? latitude = 0.0;
  static double? longitude = 0.0;
  static String lat = '0.0';
  static String long = '0.0';

  static var id = 'FirstScreen';

  @override
  _FirstScreenState createState() => _FirstScreenState();
}

Map<String, dynamic> ck = {
  'hello': 1,
};

class _FirstScreenState extends State<FirstScreen> with WidgetsBindingObserver {
  var checkIfDeniedForeverhasalwaysbeenncountered = false;
  Location location = Location();
  bool serviceEnabled=false;

  PermissionStatus? permissionGranted;
  void getLocation() async {

    LocationData locationData;
    serviceEnabled = await location.serviceEnabled();
    print("locationStatus: $serviceEnabled");
    while (!serviceEnabled) {
      print("ServiceStatus: $serviceEnabled");
      serviceEnabled = await location.requestService();
    }
    // if (!serviceEnabled) {
    //return;
    //}
    //}

    //await Future.delayed(const Duration(seconds: 2), () {});

    // while (
    //     !serviceEnabled); //so that permission dialog not get popped up before service request.

    permissionGranted = await location.hasPermission();
    print("permissionStatus1: $permissionGranted");

    while (permissionGranted == PermissionStatus.denied) //{
    {
      print("permissionStatus2: $permissionGranted");
      permissionGranted = await location.requestPermission();
    }
    while (permissionGranted == PermissionStatus.deniedForever &&
        !checkIfDeniedForeverhasalwaysbeenncountered) //{
    {
      print("permissionStatus4: $permissionGranted");
      _SettingsDialog(context);
      permissionGranted = await location.requestPermission();

      Future.delayed(const Duration(seconds: 5), () async {
        var a = await ph.openAppSettings();
        CheckIfAlreadySettingsHasbeenOpened =true;
        // print(a);
      });
      checkIfDeniedForeverhasalwaysbeenncountered = true;

    }

    // print("permissionStatus3: $permissionGranted");
    // while (permissionGranted != PermissionStatus.granted); //to avoid going to next screen
    // if (permissionGranted != PermissionStatus.granted) {
    //return;
    // }
    //}
    locationData = await location.getLocation();
    if (!mounted) return;
    setState(() {
      FirstScreen.latitude = locationData.latitude;
      Navigator.pushNamedAndRemoveUntil(
          context, widget.screenName, (Route<dynamic> route) => false);
    });
    FirstScreen.longitude = locationData.longitude;
    FirstScreen.lat = FirstScreen.latitude.toString();
    FirstScreen.long = FirstScreen.longitude.toString();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state)async {

    if (state == AppLifecycleState.paused ) {
       if(permissionGranted == PermissionStatus.denied || permissionGranted == PermissionStatus.deniedForever )
         {
           await ph.openAppSettings();
         }
     else
       {
         Navigator.pop(_SettingsContext);
       }

    }
    else if(state ==  AppLifecycleState.resumed && CheckIfAlreadySettingsHasbeenOpened)
      {
        if(permissionGranted == PermissionStatus.denied || permissionGranted == PermissionStatus.deniedForever )
        {
         permissionGranted = await location.requestPermission();
         if(permissionGranted == PermissionStatus.granted)
           {
             Navigator.pushNamedAndRemoveUntil(
                 context, widget.screenName, (Route<dynamic> route) => false);
           }
         else
           {

             await ph.openAppSettings();
           }

        }
      }

  }

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    getLocation();


    // Future.delayed(const Duration(seconds: 4)).then((value) =>

    super.initState();
  }
  var _SettingsContext;
  var CheckIfAlreadySettingsHasbeenOpened=false;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return WillPopScope(
      onWillPop: () async => false,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: SizedBox(
            height: SizeConfig.safeBlockVertical * 100,
            width: SizeConfig.safeBlockHorizontal * 100,
            child: const Center(
              child: CircularProgressIndicator(
                color: Colors.black,
                strokeWidth: 3.5,
              ),
            ),
          ),
        ),
      ),
    );
  }

  _SettingsDialog(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          _SettingsContext = context;
          // print("entered");
          return WillPopScope(
            onWillPop: () async => false,
            child: AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              backgroundColor: Colors.white,
              title: const Text(
                "Since we do not have permission to your location.\nNow you'll be directed to your settings. Please turn on your location by going to Permissions->Location->Allow",
                style: TextStyle(fontFamily: 'Nunito Sans'),
              ),
            ),
          );
        });
  }
}
