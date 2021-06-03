import 'package:flutter/material.dart';
import 'custom_range_selector.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Range Selector',
      theme: ThemeData(        
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
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

    final _dialogKey = GlobalKey<FormState>();
  Future<void> showInformationDialog(BuildContext context) async {

    return await showDialog(context: context,
     builder: (context){

       bool isChecked = false;
       return StatefulBuilder(builder: (context, setState){
         return AlertDialog(
         content: Form(
           key: _dialogKey,
           child: Column(
           mainAxisSize: MainAxisSize.min,
           children: [
             TextFormField(
               validator: (value){
                 return value.isNotEmpty ? null : "Invalid field";
               },
               decoration: InputDecoration(hintText: 'Enter Some Text'),
             ),
             Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [               
               Text('Choice Box'),
               Checkbox(value: isChecked, onChanged: (checked){
                 setState((){
                   isChecked = checked;
                 });
               })
             ],)
           ],
         ),),
         actions: <Widget>[           
           TextButton(
             child: Text('Okey'),
             onPressed: () {
               if(_dialogKey.currentState.validate()){
                  Navigator.of(context).pop();
               }
           })
         ],
       );
       });
     });
  }

  double start = 0.25;
  double end = 0.75;
 final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
   Size size = MediaQuery.of(context).size;
   double rsWidth = size.width * 0.75;
   double rsHeight = rsWidth*0.25;
    return Scaffold(
      backgroundColor: Colors.blueAccent,      
      appBar: AppBar(        
        backgroundColor: Colors.yellow,
        title: Text('Range Selector'),        
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,         
          children: [
            CustomRangeSelector(
              width: rsWidth,
              height: rsHeight,
              divisions: 10,
              start: start,
              end: end,
              onStartChange: (value){
                setState(() {
                  start = value;
                });
              },
              onEndChange: (value){
                setState(() {
                  end = value;
                });
              },
            ),
            SizedBox(
              height: 40,
            ),
            Text("start: $start | End: $end",
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)
            ),
            
            Container(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  
                  children: <Widget>[
                    /*
                    TextFormField(                      
                      validator: (value) {
                        if(value == null || value.isEmpty){
                          return 'Pleae enter text';
                        }return null;
                      }
                    ),
                    Center(                                                                  
                      child: ElevatedButton(
                        onPressed: (){
                          if(_formKey.currentState.validate()){
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Processing Data'),));
                          }
                        },
                        child: Text('Submit'),
                      ),                      
                    ),
                   */
                   Container(      
                     margin: EdgeInsets.all(8.0),               
                     child: Center(                       
                       child: ElevatedButton(
                         style: ButtonStyle(
                           backgroundColor: MaterialStateProperty.all<Color>(Colors.green)),
                         onPressed: (){
                           showInformationDialog(context);
                         },
                         child: Text(
                           'Stateful Dialog',
                           style: TextStyle(color: Colors.white, fontSize: 15),
                          ),
                         ),
                     ),
                   )
                  ],
                ),                
              ),
            )
          ],
          
        ),        
      ),  
          
    );
  }
}
