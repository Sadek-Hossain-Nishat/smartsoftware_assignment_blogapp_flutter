import 'dart:convert';

import 'package:blog_app_flutter/uilayer/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'domainlayer/UTIL.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return
      ScreenUtilInit(
        designSize: Size(width,height),
        builder: (context,child) {
          return MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            // This is the theme of your application.
            //
            // TRY THIS: Try running your application with "flutter run". You'll see
            // the application has a blue toolbar. Then, without quitting the app,
            // try changing the seedColor in the colorScheme below to Colors.green
            // and then invoke "hot reload" (save your changes or press the "hot
            // reload" button in a Flutter-supported IDE, or press "r" if you used
            // the command line to start the app).
            //
            // Notice that the counter didn't reset back to zero; the application
            // state is not lost during the reload. To reset the state, use hot
            // restart instead.
            //
            // This works for code too, not just values: Most code changes can be
            // tested with just a hot reload.
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: const MyHomePage(title: 'Smart Blog App'),
    );
        }
      );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final _formKey = GlobalKey<FormState>();

  var _obsucureText = true;


  var _emailtextfield = TextEditingController();
  var _passwordtextfield = TextEditingController();

  late final SharedPreferences prefs;



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initSharePrefe();

  }

  initSharePrefe() async{
    prefs = await SharedPreferences.getInstance();

    if(prefs.getString(TOKEN)!=null){


      Navigator.pushReplacement(
          context,
          PageRouteBuilder(
              pageBuilder: (context, animation, scecondayranimation) =>
                  HomePage(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                const begin = Offset(0.0, 1.0);
                const end = Offset.zero;
                final tween = Tween(begin: begin, end: end);
                final offsetAnimation = animation.drive(tween);

                return SlideTransition(
                  position: offsetAnimation,
                  child: child,
                );
              }));


    }

  }




  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return




      Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme
            .of(context)
            .colorScheme
            .inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: SingleChildScrollView(
          child:
          Padding(
            padding: EdgeInsets.all(20.0.w),
            child:
            Form(
              key: _formKey,
              child: Column(
                // Column is also a layout widget. It takes a list of children and
                // arranges them vertically. By default, it sizes itself to fit its
                // children horizontally, and tries to be as tall as its parent.
                //
                // Column has various properties to control how it sizes itself and
                // how it positions its children. Here we use mainAxisAlignment to
                // center the children vertically; the main axis here is the vertical
                // axis because Columns are vertical (the cross axis would be
                // horizontal).
                //
                // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
                // action in the IDE, or press "p" in the console), to see the
                // wireframe for each widget.
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[

                  Container(
                    height: 80.h,
                    width: 300.w,
                    child: TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: _emailtextfield,

                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter email';
                        }
                        return null;
                      },

                      decoration: new InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Theme
                              .of(context)
                              .colorScheme
                              .inversePrimary),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Theme
                              .of(context)
                              .colorScheme
                              .inversePrimary),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.redAccent),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.redAccent),
                        ),
                        hintText: 'Email',
                      ),


                    ),

                  ),
                  SizedBox(
                    height: 10.h,
                  ),

                  Container(
                    height: 80.h,
                    width: 300.w,
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      controller: _passwordtextfield,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter password';
                        }
                        return null;
                      },


                      obscureText: _obsucureText,

                      decoration: new InputDecoration(
                        suffixIcon: _obsucureText == true ? IconButton(
                            onPressed: () {
                              setState(() {
                                _obsucureText = false;
                              });
                            }, icon: Icon(Icons.visibility_off)) : IconButton(
                            onPressed: () {
                              setState(() {
                                _obsucureText = true;
                              });
                            }, icon: Icon(Icons.visibility)),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Theme
                              .of(context)
                              .colorScheme
                              .inversePrimary),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Theme
                              .of(context)
                              .colorScheme
                              .inversePrimary),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.redAccent),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.redAccent),
                        ),
                        hintText: 'Password',
                      ),


                    ),

                  ),

                  SizedBox(
                    height: 20.h,
                  ),

                  OutlinedButton(onPressed: () {
                    login();
                  }, child: Text('Login')),

                  // SizedBox(
                  //   height: 20.h,
                  // ),
                  //
                  // OutlinedButton(onPressed: () {
                  //  postblog();
                  // }, child: Text('Post')),
                  // SizedBox(
                  //   height: 20.h,
                  // ),
                  //
                  // OutlinedButton(onPressed: () {
                  //   getblog();
                  // }, child: Text('Get')),


                ],
              ),
            ),
          ),
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  var token = '';
  // final urilogin = 'https://apitest.smartsoft-bd.com/api/login';
  final uripost = 'https://apitest.smartsoft-bd.com/api/admin/blog-news/store';
  final uriget = 'https://apitest.smartsoft-bd.com/api/admin/blog-news';


  Future<void> login() async {

    // Validate returns true if the form is valid, or false otherwise.
    if (_formKey.currentState!.validate()) {
      // If the form is valid, display a snackbar. In the real world,
      // you'd often call a server or save the information in a database.


      var map = new Map<String, dynamic>();
      map['email'] = _emailtextfield.text;
      map['password'] = _passwordtextfield.text;


      final response = await http.post(
        Uri.parse(urilogin),

        body: map,
      );

      if (response.statusCode == 200) {
        // If the server did return a 201 CREATED response,
        // then parse the JSON.
        token = jsonDecode(response.body)["data"]["token"];
        print('response=>${jsonDecode(response.body)["data"]["token"]}');
        print('token => $token');
        await prefs.setString(TOKEN, token).then((value) {


          Navigator.pushReplacement(
              context,
              PageRouteBuilder(
                  pageBuilder: (context, animation, scecondayranimation) =>
                      HomePage(),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    const begin = Offset(0.0, 1.0);
                    const end = Offset.zero;
                    final tween = Tween(begin: begin, end: end);
                    final offsetAnimation = animation.drive(tween);

                    return SlideTransition(
                      position: offsetAnimation,
                      child: child,
                    );
                  }));




        });



      } else {
        // If the server did not return a 201 CREATED response,
        // then throw an exception.
        throw Exception('Failed to create album.');
      }
    }
  }

  Future<void> postblog() async {


    final response = await http.post(
      Uri.parse(uripost),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode({
        "title":"This is Hospital",
        "sub_title":"This is Smart Hospital",
        "slug":"smart",
        "description":"This is description",
        "category_id":10,
        "video":"https://www.youtube.com/watch?v=s7wmiS2mSXY",
        "date":"17/12/2023"
      }),
    );

    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      print('create post response=>${response.body}');
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to create post');
    }






  }

  Future<void> getblog() async {


    final response = await http.get(
      Uri.parse(uriget),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      }

    );


    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      return print('get post response=>${jsonDecode(response.body)['data']['blogs']['data']}');
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to create post');
    }








  }
}
