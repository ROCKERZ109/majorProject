import 'package:veloce/Screens/pilotripscreen.dart';
import 'api_otp_methods.dart';
import 'sizeConfig.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class PilotPopupDialog extends StatefulWidget {
  static var id = 'PilotPopopDialog';
  final int pilot;
  final int passenger;

  const PilotPopupDialog(
      {super.key, required this.pilot, required this.passenger});

  @override
  State<PilotPopupDialog> createState() => _PilotPopupDialogState();
}

class _PilotPopupDialogState extends State<PilotPopupDialog> {
  var dialogContext;

  void validateInput(context) async {
    var apiResponse = await OtpMethods()
        .validateOtp(otp: x, pilot: widget.pilot, passenger: widget.passenger);
    if (apiResponse.body == "true") {
      // Navigator.pop(this.context);
      if (!mounted) return;
      setState((){
        showOTPs = false;
        rideStarted = true;
        OtpMethods().deleteOtp(
            otp: x, pilot: widget.pilot, passenger: widget.passenger);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Ride Started"),
          duration: Duration(seconds: 2),
        ),
      );
    } else if (apiResponse.body == "false") {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Wrong Otp"),
        duration: Duration(milliseconds: 2000),
      ));
    }
  }

  var x = 0;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Builder(builder: (BuildContext context) {
        dialogContext = context;
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          backgroundColor:
              const Color.fromARGB(255, 227, 227, 227).withOpacity(0.90),
          title: Row(children: const [
            Material(
              color: Colors.transparent,
              child: Text(
                "Enter code shared by passenger",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'NunitoSans',
                    fontSize: 17.5),
              ),
            ),
          ]),
          insetPadding: EdgeInsets.all(SizeConfig.safeBlockVertical * 3),
          titlePadding: EdgeInsets.only(
            top: SizeConfig.safeBlockVertical,
            left: SizeConfig.safeBlockVertical * 2,
          ),
          actions: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: SizeConfig.safeBlockVertical * 1),
              child: Center(
                child: SizedBox(
                  height: SizeConfig.safeBlockVertical * 9,
                  width: SizeConfig.safeBlockHorizontal * 87,
                  child: Pinput(
                    onChanged: (val) {
                      x = int.parse(val);
                    },
                    // controller: otpController,
                    defaultPinTheme: PinTheme(
                      width: SizeConfig.safeBlockHorizontal * 15,
                      height: SizeConfig.safeBlockVertical * 7,
                      textStyle: const TextStyle(
                          fontSize: 20,
                          fontFamily: 'NunitoSans',
                          color: Color.fromRGBO(30, 60, 87, 1),
                          fontWeight: FontWeight.w600),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: const [
                          BoxShadow(
                            color: Color.fromRGBO(0, 0, 0, 0.059),
                            offset: Offset(0, 3),
                            blurRadius: 16,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.only(bottom: SizeConfig.safeBlockVertical * 1),
              child: Center(
                child: ElevatedButton(
                  onPressed: () {
                    validateInput(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    splashFactory: NoSplash.splashFactory,
                  ),
                  child: const Text(
                    "Start Ride!",
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontFamily: 'NunitoSans',
                        fontSize: 15),
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
