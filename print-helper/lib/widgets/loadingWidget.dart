import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

Widget loadingWidget =  Center(
                          child: new Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                               SpinKitCubeGrid(
                                color: Colors.grey,
                                size: 60.0,
                              ),
                              SizedBox(height: 20.0,),
                              Text("Ожидайте производятся вычисления... ", style: TextStyle(fontSize: 22, color: Colors.black87)),
                              
                            ],
                          ),
                        );