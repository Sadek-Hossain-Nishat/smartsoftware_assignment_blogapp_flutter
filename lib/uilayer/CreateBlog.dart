import 'dart:convert';

import 'package:blog_app_flutter/uilayer/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../domainlayer/UTIL.dart';

class CreateBlog extends StatefulWidget {




  @override
  State<CreateBlog> createState() => _CreateBlogState();
}

class _CreateBlogState extends State<CreateBlog> {
  final _formKey = GlobalKey<FormState>();

  final _title = TextEditingController();

  final _subtitle = TextEditingController();

  final _slug = TextEditingController();

  final _description = TextEditingController();

  final _categoryid = TextEditingController();

  final _date = TextEditingController();

  var _imgpath = TextEditingController();
  var _imgname = '';

late final SharedPreferences prefs;
late final token;

@override
void initState() {
    // TODO: implement initState
    super.initState();
    initSharePrefe();



  }

  initSharePrefe() async{
    prefs = await SharedPreferences.getInstance();
    token = prefs.getString(TOKEN);
    print('token in homepage $token');

  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar: AppBar(title: Text('Create Blog'),),
      body: Padding(padding: EdgeInsets.all(20.w),
      child: Form(
        key: _formKey,
          child: SingleChildScrollView(
        child: Column(
          children: [

            Container(
              height: 80.h,
              width: 300.w,
              child: TextFormField(
                keyboardType: TextInputType.emailAddress,
                controller: _title,

                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the field';
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
                  hintText: 'Title',
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
                keyboardType: TextInputType.emailAddress,
                controller: _subtitle,

                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the field';
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
                  hintText: 'Subtitle',
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
                keyboardType: TextInputType.emailAddress,
                controller: _slug,

                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter slug';
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
                  hintText: 'Slug',
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
                keyboardType: TextInputType.emailAddress,
                controller: _description,

                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Description';
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
                  hintText: 'Description',
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
                controller: _categoryid,

                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter category id';
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
                  hintText: 'Category id',
                ),


              ),

            ),
            SizedBox(
              height: 10.h,
            ),

            // Container(
            //   height: 80.h,
            //   width: 300.w,
            //   child: TextFormField(
            //     keyboardType: TextInputType.emailAddress,
            //     controller: _imagelink,
            //
            //     validator: (value) {
            //       if (value == null || value.isEmpty) {
            //         return 'upload image';
            //       }
            //       return null;
            //     },
            //
            //     decoration: new InputDecoration(
            //       focusedBorder: OutlineInputBorder(
            //         borderSide: BorderSide(color: Theme
            //             .of(context)
            //             .colorScheme
            //             .inversePrimary),
            //       ),
            //       enabledBorder: OutlineInputBorder(
            //         borderSide: BorderSide(color: Theme
            //             .of(context)
            //             .colorScheme
            //             .inversePrimary),
            //       ),
            //       errorBorder: OutlineInputBorder(
            //         borderSide: BorderSide(color: Colors.redAccent),
            //       ),
            //       focusedErrorBorder: OutlineInputBorder(
            //         borderSide: BorderSide(color: Colors.redAccent),
            //       ),
            //       hintText: 'Video url link',
            //     ),
            //
            //
            //   ),
            //
            // ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [



                Container(

                  width: 200.w,
                  child: TextFormField(
                    readOnly: true,

                    controller: _imgpath,



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

                    ),


                  ),

                ),

                GestureDetector(
                  onTap: ()=>browseImage(),
                  child: Center(
                    child: Container(

                        width: 100.w,
                      height: 60.h,

                      color:Theme.of(context).colorScheme.inversePrimary ,

                      child: Align(child: Text(_imgname.toString().isNotEmpty?_imgname:'Upload Image'),
                      alignment: Alignment.center,),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10.h,
            ),

            Container(
              height: 80.h,
              width: 300.w,
              child: TextFormField(
                keyboardType: TextInputType.emailAddress,
                controller: _date,

                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter data dd/mm/yyyy format';
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
                  hintText: 'Date',
                ),


              ),

            ),
            SizedBox(
              height: 20.h,
            ),

            OutlinedButton(onPressed: (){
              createPost();
            }, child: Text('Creat Post'))



          ],

        ),
      )),),
    ));
  }

  // final uripost = 'https://apitest.smartsoft-bd.com/api/admin/blog-news/store';

  Future<void> createPost() async {



    final response = await http.post(
      Uri.parse(uripost),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode({
        "title":_title.text,
        "sub_title":_subtitle.text,
        "slug":_slug.text,
        "description":_description.text,
        "category_id": _categoryid.text,
        "video":  "https://www.youtube.com/watch?v=s7wmiS2mSXY",
        "date": _date.text
      }),
    );

    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      print('create post response=>${response.body}');

      Navigator.pushAndRemoveUntil(
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
              }),
            (Route<dynamic> route) => false);
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to create post');
    }

















  }

  // Obtain shared preferences.



  browseImage() async {

    var status = await Permission.storage.status;
    if (status.isDenied) {
      // We haven't asked for permission yet or the permission has been denied before, but not permanently.
      await Permission.storage.onDeniedCallback(() {
        // Your code
      }).onGrantedCallback(() {

        pickImagefromgalery();
        // Your code
      }).onPermanentlyDeniedCallback(() {
        // Your code
      }).onRestrictedCallback(() {
        // Your code
      }).onLimitedCallback(() {
        // Your code
      }).onProvisionalCallback(() {
        // Your code
      }).request();
    }

// You can also directly ask permission about its status.
    if (status.isGranted) {
      pickImagefromgalery();
    }



  }




  Future<void> pickImagefromgalery() async {

    final ImagePicker picker = ImagePicker();
// Pick an image.
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);


    print('image=>${_imgpath}');

    setState(() {
      _imgname = image!.name;
      _imgpath.text = image.path;



    });




  }
}
