import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../domainlayer/Blog.dart';

class DetailsBlogPage extends StatefulWidget {
  Blog blog;
  DetailsBlogPage( {required this.blog});

  @override
  State<DetailsBlogPage> createState() => _DetailsBlogPageState();
}

class _DetailsBlogPageState extends State<DetailsBlogPage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    print("blog obj=>${jsonEncode(widget.blog)}");
  }

  @override
  Widget build(BuildContext context) {

    return SafeArea(child: Scaffold(
      appBar: AppBar(title: Text(widget.blog.title as String),
      centerTitle: true,),
      body: Padding(
        padding:  EdgeInsets.all(20.0.w),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              SizedBox(
                height: 50.h,
              ),


              Text(widget.blog.subTitle as String),
              Text(widget.blog.slug as String),
              Text(widget.blog.description as String),
              Text('${widget.blog.categoryId}'),

              widget.blog.video!=null?Image.file(File(widget.blog.video as String)):Icon(Icons.photo)
              ,
              Text(widget.blog.date as String)



            ],
          ),
        ),
      ),
    ));
  }
}

