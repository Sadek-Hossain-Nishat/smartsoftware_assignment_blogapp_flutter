import 'dart:convert';

import 'package:blog_app_flutter/datalayer/BlogList.dart';
import 'package:blog_app_flutter/uilayer/DetailsBlogPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../domainlayer/Blog.dart';
import '../domainlayer/UTIL.dart';
import '../main.dart';
import 'CreateBlog.dart';
import 'EditBlogPage.dart';
import 'package:http/http.dart' as http;


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  Future<List<Blog>> _allblogs = Future(() => []);

  late final SharedPreferences prefs;

  @override
  void initState(){
    // TODO: implement initState
    super.initState();
    print('home page init called');

    initall();

  }

  initall() async{

    prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(TOKEN);

    setState(() {

      _allblogs = BlogList.fetchAllBlogs(token!);

      _allblogs.then((value) => print(jsonEncode(value)));
      print('token in homepage $token');

    });




  }




  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('All Blogs'),
          centerTitle: true,
          actions: [
            IconButton(onPressed: (){


              Navigator.push(
                  context,
                  PageRouteBuilder(
                      pageBuilder: (context, animation, scecondayranimation) =>
                          CreateBlog(),
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

            }, icon: Icon(Icons.add)),


            IconButton(onPressed: (){

              logout();




            }, icon: Icon(Icons.power_off))
          ],
        ),
        body: FutureBuilder<List<Blog>>(future:_allblogs ,builder:(context,snapshot){


          if (snapshot.hasData) {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Container(

                      color: Theme.of(context).colorScheme.inversePrimary,
                      child: InkWell(
                        onTap: (){

                          Navigator.push(
                              context,
                              PageRouteBuilder(
                              pageBuilder: (context, animation, scecondayranimation) =>
                              DetailsBlogPage(blog: snapshot.data![index]),
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










                        },
                        child: ListTile(
                          leading:  IconButton(onPressed: (){

                            Navigator.push(
                                context,
                                PageRouteBuilder(
                                    pageBuilder: (context, animation, scecondayranimation) =>
                                        EditBlogPage(blog: snapshot.data![index]),
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






                          }, icon: Icon(Icons.edit)),
                          title: Text(
                              snapshot.data![index].title as String,
                              style: TextStyle(
                                  fontSize: 14.sp)),
                          trailing:
                              IconButton(onPressed: (){


                                 deleteBlog(snapshot.data![index].id);






                              }, icon: Icon(Icons.delete)),

                          subtitle: Text(
                              snapshot.data![index].subTitle as String,
                              style: TextStyle(
                                  fontSize: 14.sp)),
                        ),
                      ),
                    ),
                    SizedBox(height: 10.h)
                  ],
                );
              },
            );

            // return ListTile(
            //     leading: Icon(Icons.location_on),
            //     title: Text('User id:${snapshot.data!.user_id}'),
            //     subtitle: Text('Lat:${snapshot.data!.lat}'),
            //     trailing: Text('Long:${snapshot.data!.long}'));
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }

          // By default, show a loading spinner.
          return const CircularProgressIndicator();

        } )



      ),
    );
  }

  Future<void> deleteBlog(id) async {

   await http.delete(
      Uri.parse('$uridelete$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${prefs.getString(TOKEN)}'
      },
    ).then((value) {

      print('value =>${value.body}');
      setState(() {
        _allblogs = BlogList.fetchAllBlogs(prefs.getString(TOKEN)!);
      });
   }).catchError((e){
     print("error=> ${e.toString()}");
   })
   ;



  }

  Future<void> logout() async {

    await prefs.remove(TOKEN).then((value) {


      Navigator.pushReplacement(
          context,
          PageRouteBuilder(
              pageBuilder: (context, animation, scecondayranimation) =>
                  MyHomePage(title: 'Smart Blog App'),
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


  }
}

