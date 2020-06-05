
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sensors/sensors.dart';
void main() => runApp(MyApp());
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
       
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}
class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {
  double userAclr_x, userAclr_y, userAclr_z,aclr_x, aclr_y, aclr_z, giros_x, giros_y, giros_z;
  String position_y = '';
  String position_x = '';
  String directionAccelerate = '';
  double accelerateToUp = 0.0;
  double accelerateToDawn = 0.0;
  double aclr_Y_Z = 0.0;
  double diffAclr_Y_Z = 0.0;
  int toUp = 0;
  int toDawn = 0;
  int cont = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   

    accelerometerEvents.listen((AccelerometerEvent event) {
      setState(() {
        aclr_x = event.x;
        aclr_y = event.y;
        aclr_z = event.z;
       if(toUp == 1 && toDawn == 1){
            cont += 1;
            toUp = 0;
            toDawn = 0;
          }
        // directionAccelerate = userAclr_y > 0?'U':'D';
       
        // if(aclr_x >-1 && aclr_x < 1){
        //   position_x = '-';
        // }else if(aclr_x > 8.5 && aclr_x < 10){
        //   position_x = '|';
        // }else if((aclr_x < -1) && (aclr_x > -8.5)){
        //   position_x = '\\';
        // }else if((aclr_x > 1) && (aclr_x < 8.5)){
        //   position_x = '/';
        // }else if(aclr_x < -8.5 && aclr_x > -10){
        //   position_x = '|';
        // }


        // if(aclr_y >-1 && aclr_y < 1){
        //   position_y = '-';
        // }else if(aclr_y > 8.5 && aclr_y < 10){
        //   position_y = '|';
        // }else if((aclr_y < -1) && (aclr_y > -8.5)){
        //   position_y = '\\';
        // }else if((aclr_y > 1) && (aclr_y < 8.5)){
        //   position_y = '/';
        // }else if(aclr_y < -8.5 && aclr_y > -10){
        //   position_y = '|';
        // }

        // if(position_y == '|'){
         
        //   if(userAclr_y > 0.2){
            
        //     directionAccelerate = userAclr_y > accelerateToUp?'U':'D';
        //     accelerateToUp = userAclr_y;
        //   }
        // }
      });
    }); 
    userAccelerometerEvents.listen((UserAccelerometerEvent event) {
      setState(() {
        userAclr_x = event.x;
        userAclr_y = event.y;
        userAclr_z = event.z;
        aclr_Y_Z = aclr_y + userAclr_y;
        diffAclr_Y_Z = aclr_y - aclr_z;
        if(diffAclr_Y_Z > 4 && diffAclr_Y_Z < 10){
          if(userAclr_y < -2.0 && toUp != 1){
              toUp += 1;
          }if(userAclr_y > 1.0 && toUp == 1 && toDawn != 1){
              toDawn += 1;
          }
          // else if(userAclr_y < -1.0){
          //     directionAccelerate = 'D';
          // }else{
          //     directionAccelerate = '';
          // }
        }
      });
    }); //get the sensor data and set then to the data types
    
    gyroscopeEvents.listen((GyroscopeEvent event) {
      setState(() {
        giros_x = event.x;
        giros_y = event.y;
        giros_z = event.z;
      });
    }); 
    
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Sensor Events"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  "painel events",
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w900),
                ),
                
              ),
              Text(
                  "Poli "+cont.toString(),
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w900),
                ),
                Text(
                  "to Up "+toUp.toString(),
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w900),
                ),
                Text(
                  "to Dawn "+toDawn.toString(),
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w900),
                ),
                FlatButton(
                    color: Colors.blue,
                    textColor: Colors.white,
                    disabledColor: Colors.grey,
                    disabledTextColor: Colors.black,
                    padding: EdgeInsets.all(1.0),
                    splashColor: Colors.blueAccent,
                    onPressed: () {
                      toUp = 0;
                      toDawn = 0;
                      toUp = 0;
                    },
                    child: Text(
                      "Clear",
                      style: TextStyle(fontSize: 12.0),
                    ),
                  ),
              Table(
                border: TableBorder.all(
                    width: 2.0,
                    color: Colors.blueAccent,
                    style: BorderStyle.solid),
                children: [
                  
                  TableRow(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "User Accelerometer eixo Y : ",
                          style: TextStyle(fontSize: 20.0),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(userAclr_y.toStringAsFixed(2)+' '+directionAccelerate ,  //trim the asis value to 2 digit after decimal point
                            style: TextStyle(fontSize: 20.0)),
                      )
                    ],
                  ),
                  // TableRow(
                  //   children: [
                  //     Padding(
                  //       padding: const EdgeInsets.all(8.0),
                  //       child: Text(
                  //         "Up : ",
                  //         style: TextStyle(fontSize: 20.0),
                  //       ),
                  //     ),
                  //     Padding(
                  //       padding: const EdgeInsets.all(8.0),
                  //       child: Text(toUp+' '+directionAccelerate ,  //trim the asis value to 2 digit after decimal point
                  //           style: TextStyle(fontSize: 20.0)),
                  //     )
                  //   ],
                  // ),
                  TableRow(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "User Accelerometer eixo Z: ",
                          style: TextStyle(fontSize: 20.0),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0), 
                        child: Text(userAclr_z.toStringAsFixed(2),   //trim the asis value to 2 digit after decimal point
                            style: TextStyle(fontSize: 20.0)),  
                      )
                    ],
                  // ), TableRow(
                  //   children: [
                  //     Padding(
                  //       padding: const EdgeInsets.all(8.0),
                  //       child: Text(
                  //         "Soma acelerações do usuário e do dispositivo y ",
                  //         style: TextStyle(fontSize: 20.0),
                  //       ),
                  //     ),
                  //     Padding(
                  //       padding: const EdgeInsets.all(8.0),
                  //       child: Text(aclr_Y_Z.toStringAsFixed(2) , //trim the asis value to 2 digit after decimal point
                  //           style: TextStyle(fontSize: 20.0)),
                  //     )
                  //   ],
                  ),
                   TableRow(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Soma z ",
                          style: TextStyle(fontSize: 20.0),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(diffAclr_Y_Z.toStringAsFixed(2) , //trim the asis value to 2 digit after decimal point
                            style: TextStyle(fontSize: 20.0)),
                      )
                    ],
                  ),TableRow(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Base Y ",
                          style: TextStyle(fontSize: 20.0),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(aclr_y.toStringAsFixed(2)+' ( '+ position_y+' )',  //trim the asis value to 2 digit after decimal point
                            style: TextStyle(fontSize: 20.0)),
                      )
                    ],
                  ),
                  TableRow(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Accelerometer Z: ",
                          style: TextStyle(fontSize: 20.0),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0), 
                        child: Text(aclr_z.toStringAsFixed(2),   //trim the asis value to 2 digit after decimal point
                            style: TextStyle(fontSize: 20.0)),  
                      )
                    ],
                  ),
                   TableRow(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Giros X : ",
                          style: TextStyle(fontSize: 20.0),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(giros_x.toStringAsFixed(2), //trim the asis value to 2 digit after decimal point
                            style: TextStyle(fontSize: 20.0)),
                      )
                    ],
                  ),
                  TableRow(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Giros Y : ",
                          style: TextStyle(fontSize: 20.0),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(giros_y.toStringAsFixed(2),  //trim the asis value to 2 digit after decimal point
                            style: TextStyle(fontSize: 20.0)),
                      )
                    ],
                  ),
                  TableRow(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Giros Z: ",
                          style: TextStyle(fontSize: 20.0),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0), 
                        child: Text(giros_z.toStringAsFixed(2),   //trim the asis value to 2 digit after decimal point
                            style: TextStyle(fontSize: 20.0)),  
                      )
                    ],
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}