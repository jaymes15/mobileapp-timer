import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import "dart:async";
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Time',
      theme: ThemeData(

        primarySwatch: Colors.blue,
        //
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
 TabController tb;
 int hour = 0;
 int min = 0;
 int sec = 0;
 bool started = true;
 bool stopped = true;
 int timeforTimer = 0;
 String timetodisplay = "";
 bool checktimer = true;

 @override
  void initState(){
    tb = TabController(
      length: 2,
      vsync: this,
    );
    super.initState();
  }

void start(){
   setState(() {
     started = false;
     stopped = false;
   });
   timeforTimer = ((hour * 60 * 60) + (min * 60) + sec);
   Timer.periodic(Duration(
     seconds: 1,
   ),
           (Timer t){
                setState(() {
                  if(timeforTimer < 1 || checktimer == false){
                    t.cancel();
                    Navigator.pushReplacement(context, MaterialPageRoute(
                      builder: (context) => MyHomePage(),
                    ));

                  }
                  if(timeforTimer < 60){
                    timetodisplay =timeforTimer.toString();
                    timeforTimer = timeforTimer - 1;
                  }
                  else if( timeforTimer < 3600){
                    int m = timeforTimer ~/ 60;
                    int s = timeforTimer - ( 60 * m);
                    timetodisplay = m.toString() + ":" + s.toString();
                    timeforTimer = timeforTimer - 1;
                  }else{
                    int h = timeforTimer ~/ 3600;
                    int t = timeforTimer - (3600 * h);
                    int m = t ~/ 60;
                    int s = t - (60 * m);
                    timetodisplay =
                        h.toString() + ":" + m.toString() + ":" + s.toString();
                    timeforTimer = timeforTimer - 1;
                  }

                  //timetodisplay = timeforTimer.toString();
                });
           });

}

void stop(){
   setState(() {
     started = true;
     stopped = true;
     checktimer = false;
   });
}
  Widget timer(){
   return Container(
     child: Column(
       mainAxisAlignment: MainAxisAlignment.center,
       children: <Widget>[
         Expanded(
           flex: 6,
           child: Row(
             mainAxisAlignment: MainAxisAlignment.center,
             children: <Widget>[
               Column(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: <Widget>[
                   Padding(
                     padding: EdgeInsets.only(
                       bottom: 10.0,
                     ),
                     child: Text(
                       "Hour",
                       style: TextStyle(
                         fontSize: 18.0,
                         fontWeight: FontWeight.w700,
                       ),
                     ),
                   ),
                   NumberPicker.integer(
                     initialValue: hour,
                     minValue: 0,
                     maxValue: 23,
                     listViewWidth: 60.0,
                     onChanged: (val){
                       setState(() {
                         hour = val;
                       });
                     },
                   ),
                 ],
               ),

               Column(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: <Widget>[
                   Padding(
                     padding: EdgeInsets.only(
                       bottom: 10.0,
                     ),
                     child: Text(
                         "Mins",
                       style: TextStyle(
                         fontSize: 18.0,
                         fontWeight: FontWeight.w700,
                       ),
                     ),
                   ),
                   NumberPicker.integer(
                     initialValue: min,
                     minValue: 0,
                     maxValue: 60,
                     listViewWidth: 60.0,
                     onChanged: (val){
                       setState(() {
                         min = val;
                       });
                     },
                   ),
                 ],
               ),

               Column(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: <Widget>[
                   Padding(
                     padding: EdgeInsets.only(
                       bottom: 10.0,
                     ),
                     child: Text(
                         "Secs",
                       style: TextStyle(
                         fontSize: 18.0,
                         fontWeight: FontWeight.w700,
                       ),
                     ),
                   ),
                   NumberPicker.integer(
                     initialValue: sec,
                     minValue: 0,
                     maxValue: 60,
                     listViewWidth: 60.0,
                     onChanged: (val){
                       setState(() {
                         sec = val;
                       });
                     },
                   ),
                 ],
               ),
             ],
           ),
         ),
         Expanded(
           flex:1,
             child: Text(
                 timetodisplay,
               style: TextStyle(
                 fontSize: 18.0,
                 fontWeight: FontWeight.w600,
               ),
             )
         ),
         Expanded(
           flex:3,
             child: Row(
               mainAxisAlignment: MainAxisAlignment.center,
               children: <Widget>[

                 RaisedButton(
                     onPressed: started ? start : null,
                     padding: EdgeInsets.symmetric(
                     horizontal: 40.0,
                     vertical: 20.0,
                   ),
                   color: Colors.green,
                     child: Text(
                       "Start",
                       style: TextStyle(
                         fontSize:18.0,
                         color: Colors.white,
                       ),
                     ),
                 ),

                 Padding(
                   padding: EdgeInsets.symmetric(
                     horizontal: 20.0,
                     vertical: 0.0,
                   ),
                 ),
                 RaisedButton(
                   onPressed: stopped ? null : stop,
                   padding: EdgeInsets.symmetric(
                     horizontal: 40.0,
                     vertical: 20.0,
                   ),
                   color: Colors.red,
                   child: Text(
                     "Stop",
                     style: TextStyle(
                       fontSize:18.0,
                       color: Colors.white,
                     ),
                   ),
                 ),

               ],

             ),
         ),
       ],
     ),
   );

  }

//  //////////////
  /////////////////////////////////////////////////////////////////////////////////////
  ////////////////////////////////////////////////////////////////////////////////////
  //////////////////////////////////////////////////////////////////////////////////
  ////STOP WATCH CODE/////////////////////////////////////////////////////////////
  /////////////////////////////////////////////////////////////////////////
  bool startispressed = true;
 bool stopispressed = true;
 bool resetispressed = true;
 String stoptimetodisplay = "00:00:00";
var swatch = Stopwatch();
final dur = const Duration(seconds: 1);

void starttimer(){
  Timer(dur, keeprunning);
}

void keeprunning(){
  if(swatch.isRunning){
    starttimer();
  }
  setState(() {
    stoptimetodisplay =swatch.elapsed.inHours.toString().padLeft(2,"0") + ":"
                          + (swatch.elapsed.inMinutes%60).toString().padLeft(2,"0") + ":"
                          + (swatch.elapsed.inSeconds%60).toString().padLeft(2,"0");
  });
}

 void startstopwatch(){
  setState(() {
    stopispressed =false;
    startispressed = false;
  });
  swatch.start();
  starttimer();

 }

 void stopstopwatch(){
  setState(() {
    stopispressed = true;
    resetispressed = false;
    startispressed=true;

  });
  swatch.stop();
 }

 void resetstopwatch(){
   setState(() {
     startispressed = true;
     resetispressed = true;
   });
   swatch.reset();
   stoptimetodisplay = "00:00:00";
 }

  Widget stopwatch(){
   return Container(
     alignment: Alignment.center,
     child: Column(
       children: <Widget>[
         Padding(
           padding: EdgeInsets.only(top:30.0),
         ),
         Expanded(
           flex: 6,
           child: Text(
             stoptimetodisplay,
             style: TextStyle(
               fontSize: 50.0,
               fontWeight: FontWeight.w700,
             ),
           ),
         ),
         Expanded(
           flex: 4,
           child: Container(
             child: Column(
               mainAxisAlignment: MainAxisAlignment.spaceAround,
               children: <Widget>[
                 Row(
                   mainAxisAlignment: MainAxisAlignment.spaceAround,
                   children: <Widget>[
                     RaisedButton(
                       onPressed: stopispressed ? null : stopstopwatch,
                       color: Colors.red,
                       padding: EdgeInsets.symmetric(
                         horizontal: 35.0,
                         vertical:15.0,
                       ),
                       child: Text(
                         "Stop",
                         style: TextStyle(
                           fontSize: 20.0,
                           color: Colors.white,
                         ),
                       ),
                     ),
                     RaisedButton(
                       onPressed: resetispressed ? null : resetstopwatch,

                       color: Colors.teal,
                       padding: EdgeInsets.symmetric(
                         horizontal: 35.0,
                         vertical:15.0,
                       ),
                       child: Text(
                         "Reset",
                         style: TextStyle(
                           fontSize: 20.0,
                           color: Colors.white,
                         ),
                       ),
                     ),
                   ],
                 ),
                 RaisedButton(
                   onPressed: startispressed ? startstopwatch : null,

                   color: Colors.green,
                   padding: EdgeInsets.symmetric(
                     horizontal: 80.0,
                     vertical:20.0,
                   ),
                   child: Text(
                     "Start",
                     style: TextStyle(
                       fontSize: 20.0,
                       color: Colors.white,
                     ),
                   ),
                 ),
               ],
             ),
           ),
         ),
       ],
     ),

   );
  }











  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: Text(
          "Time Project",
        ),
        centerTitle: true,
        bottom: TabBar(
          tabs: <Widget>[
            Text(
              "Timer"
            ),
            Text(
              "Stopwatch",
            )
          ],

          labelPadding: EdgeInsets.only(
            bottom: 10.0,
          ),
          labelStyle: TextStyle(
            fontSize: 18.0,
          ),
          unselectedLabelColor: Colors.white60,

          controller: tb,
        ),
      ),
      body: TabBarView(
        children: <Widget>[
          timer(),
          stopwatch(),
        ],
        controller: tb,
      ),
    );
  }
}
