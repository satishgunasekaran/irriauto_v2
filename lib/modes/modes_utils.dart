import 'package:email_password_login/model/sensor_model.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AutoMode extends StatefulWidget {
  const AutoMode({
    Key? key,
  }) : super(key: key);

  @override
  State<AutoMode> createState() => _AutoModeState();
}

class _AutoModeState extends State<AutoMode> {
  // bool auto = false;
  DatabaseReference ref = FirebaseDatabase.instance.ref("sensorReadings");

  void toggleMode(modeVal) async {
    await ref.update({
      "mode": modeVal,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SensorModel>(builder: (context, sensorModel, child) {
      return Container(
        width: double.infinity,
        height: 100,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 7,
              color: Color(0x32171717),
              offset: Offset(0, 3),
            )
          ],
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Center(
                child: Image.asset(
                  'assets/auto_mode.webp',
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16, 0, 0, 0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Auto Mode',
                        style: TextStyle(
                          fontFamily: 'Lexend Deca',
                          color: Color(0xFF090F13),
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                        child: Text(
                          sensorModel.mode ? 'is turned on' : 'is turned off',
                          style: TextStyle(
                            fontFamily: 'Lexend Deca',
                            color: Colors.red,
                            fontSize: 12,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              IconButton(
                icon: sensorModel.mode
                    ? Icon(Icons.toggle_on)
                    : Icon(Icons.toggle_off),
                onPressed: () {
                  setState(() {
                    toggleMode(!sensorModel.mode);
                  });
                },
                iconSize: 65,
              )
            ],
          ),
        ),
      );
    });
  }
}

class ManualMode extends StatefulWidget {
  const ManualMode({
    Key? key,
  }) : super(key: key);

  @override
  State<ManualMode> createState() => _ManualModeState();
}

class _ManualModeState extends State<ManualMode> {
  DatabaseReference ref = FirebaseDatabase.instance.ref("sensorReadings");

  void toggleMode(modeVal) async {
    await ref.update({
      "mode": modeVal,
    });
  }

  void toggleValve(valveNo, status) async {
    if (status == "Idle") {
      await ref.update({
        "v$valveNo": "Running",
      });
    } else {
      await ref.update({
        "v$valveNo": "Idle",
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SensorModel>(builder: (context, sensorModel, child) {
      return Column(
        children: [
          Container(
            width: double.infinity,
            height: 100,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  blurRadius: 7,
                  color: Color(0x32171717),
                  offset: Offset(0, 3),
                )
              ],
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Center(
                    child: Image.asset(
                      'assets/manual_mode.jpg',
                      width: 55,
                      height: 55,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(16, 0, 0, 0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Manual Mode',
                            style: TextStyle(
                              fontFamily: 'Lexend Deca',
                              color: Color(0xFF090F13),
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                            child: Text(
                              !sensorModel.mode
                                  ? 'is turned on'
                                  : 'is turned off',
                              style: TextStyle(
                                fontFamily: 'Lexend Deca',
                                color: Colors.red,
                                fontSize: 12,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  IconButton(
                    icon: !sensorModel.mode
                        ? Icon(Icons.toggle_on)
                        : Icon(Icons.toggle_off),
                    onPressed: () {
                      setState(() {
                        toggleMode(!sensorModel.mode);
                      });
                    },
                    iconSize: 65,
                  )
                ],
              ),
            ),
          ),

          //valve control
          !sensorModel.mode? Padding(
            padding: EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
            child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Center(
                        child: Image.asset(
                          'assets/valve.webp',
                          width: 55,
                          height: 55,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding:
                              EdgeInsetsDirectional.fromSTEB(16, 0, 0, 0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Valve 1',
                                style: TextStyle(
                                  fontFamily: 'Lexend Deca',
                                  color: Color(0xFF090F13),
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0, 4, 0, 0),
                                child: Text(
                                  sensorModel.v1 == "Idle"
                                      ? 'is Idle'
                                      : 'is Running',
                                  style: TextStyle(
                                    fontFamily: 'Lexend Deca',
                                    color: Colors.red,
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      IconButton(
                        icon: sensorModel.v1 == "Idle"
                            ? Icon(Icons.invert_colors_off_rounded)
                            : Icon(Icons.invert_colors),
                        onPressed: () {
                          setState(() {
                            toggleValve(1, sensorModel.v1);
                          });
                        },
                        iconSize: 65,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 25,
                  ),

                  // Valve 2
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Center(
                        child: Image.asset(
                          'assets/valve.webp',
                          width: 55,
                          height: 55,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding:
                              EdgeInsetsDirectional.fromSTEB(16, 0, 0, 0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Valve 1',
                                style: TextStyle(
                                  fontFamily: 'Lexend Deca',
                                  color: Color(0xFF090F13),
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0, 4, 0, 0),
                                child: Text(
                                  sensorModel.v2 == "Idle"
                                      ? 'is Idle'
                                      : 'is Running',
                                  style: TextStyle(
                                    fontFamily: 'Lexend Deca',
                                    color: Colors.red,
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      IconButton(
                        icon: sensorModel.v2 == "Idle"
                            ? Icon(Icons.invert_colors_off_rounded)
                            : Icon(Icons.invert_colors),
                        onPressed: () {
                          setState(() {
                            toggleValve(2, sensorModel.v2);
                          });
                        },
                        iconSize: 65,
                      )
                    ],
                  ),
                ]),
          ): SizedBox(height: 10,)

          // Valve 1
        ],
      );
    });
  }
}
