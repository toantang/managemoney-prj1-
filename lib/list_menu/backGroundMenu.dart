import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BackgroundMenuView extends StatelessWidget {
  //double x = 120;
  //double y = 120;

  Random random = new Random();
  Widget BackGround(BuildContext context, double x, double y) {
    return Container(
        width: x,
        height: y,
        decoration: BoxDecoration(
            color: Colors.greenAccent
        ),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: x/3,
                  height: y/3,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(bottomRight: Radius.circular(35)),
                      color: Colors.white
                  ),
                ),
                Container(
                  width: x/3,
                  height: y/3,
                  child: Column(
                    children: [
                      Container(
                        width: x/3,
                        height: x/8,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
                            color: Colors.white
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  width: x/3,
                  height: y/3,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(35)),
                      color: Colors.white
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: x/3,
                  height: y/3,
                  child: Row(
                    children: [
                      Container(
                        width: x/8,
                        height: x/3,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(bottomRight: Radius.circular(20), topRight: Radius.circular(20)),
                            color: Colors.white
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: x/3,
                  height: x/3,
                  child: BackGround1(context, x, y),
                ),
                Container(
                  //padding: EdgeInsets.only(left: x/3),
                  child: Container(
                    width: x/3,
                    height: y/3,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          width: x/8,
                          height: x/3,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(20), bottomLeft: Radius.circular(20)),
                              color: Colors.white
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
            Row(
              children: [
                Container(
                  width: x/3,
                  height: y/3,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(topRight: Radius.circular(35)),
                      color: Colors.white
                  ),
                ),
                Container(
                  width: x/3,
                  height: y/3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        width: x/3,
                        height: x/8,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                            color: Colors.white
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  width: x/3,
                  height: y/3,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(35)),
                      color: Colors.white
                  ),
                )
              ],
            ),
          ],
        )
    );
  }

  Widget BackGround1(BuildContext context, double x, double y) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
        ),
        child: Container(
            width: x/5,
            height: y/5,
            decoration: BoxDecoration(
                color: Colors.greenAccent
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      width: x/15,
                      height: y/15,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(bottomRight: Radius.circular(35)),
                          color: Colors.white
                      ),
                    ),
                    Container(
                      width: x/15,
                      height: y/15,
                      child: Column(
                        children: [
                          Container(
                            width: x/15,
                            height: x/40,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
                                color: Colors.white
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      width: x/15,
                      height: y/15,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(35)),
                          color: Colors.white
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: x/15,
                      height: y/15,
                      child: Row(
                        children: [
                          Container(
                            width: x/40,
                            height: x/15,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(bottomRight: Radius.circular(20), topRight: Radius.circular(20)),
                                color: Colors.white
                            ),
                          ),
                        ],
                      ),
                    ),
                    /*Container(
                    width: x/9,
                    height: y/9,
                    child: FloatingActionButton(
                      backgroundColor: Colors.white,
                    ),
                  ),*/
                    Container(
                      padding: EdgeInsets.only(left: x/15),
                      child: Container(
                        width: x/15,
                        height: y/15,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              width: x/40,
                              height: x/15,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(20), bottomLeft: Radius.circular(20)),
                                  color: Colors.white
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    Container(
                      width: x/15,
                      height: y/15,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(topRight: Radius.circular(35)),
                          color: Colors.white
                      ),
                    ),
                    Container(
                      width: x/15,
                      height: y/15,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            width: x/15,
                            height: x/40,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                                color: Colors.white
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      width: x/15,
                      height: y/15,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(35)),
                          color: Colors.white
                      ),
                    )
                  ],
                ),
              ],
            )
        ),
      ),
    );
  }

  Widget buildBackGround(BuildContext context) {
    double x = 120;
    double y = 120;
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.only(top: 6, left: 26),
                child: BackGround(context, x, y),
              ),
              Container(
                padding: EdgeInsets.only(left: 30),
                child: BackGround(context, 180, 180),
              )
            ],
          ),
          Container(
            //padding: EdgeInsets.only(top: 10),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.only(left: 6, top: 10),
                  child: BackGround(context, 83, 83),
                ),
                Container(
                  padding: EdgeInsets.only(left: 45),
                  child: BackGround(context, 72, 72),
                ),
                Container(
                  padding: EdgeInsets.only(left: 69, top: 5),
                  child: BackGround(context, 135, 135),
                )
              ],
            ),
          ),
          Row(
            children: [
              Container(
                padding: EdgeInsets.only(left: 13),
                child: BackGround(context, 150, 150),
              ),
              Container(
                padding: EdgeInsets.only(left: 15),
                child: BackGround(context, 15, 15),
              ),
              Container(
                padding: EdgeInsets.only(left: 45),
                child: BackGround(context, 102, 102),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                padding: EdgeInsets.only(left: 34),
                child: BackGround(context, 81, 81),
              ),
              Container(
                padding: EdgeInsets.only(right: 19),
                child: BackGround(context, 115, 115),
              ),
              Container(
                padding: EdgeInsets.only(right: 39, top: 65),
                child: BackGround(context, 35, 35),
              ),
              Container(
                padding: EdgeInsets.only(right: 39, top: 15),
                child: BackGround(context, 48, 48),
              )
            ],
          ),
          Row(
            children: [
              Container(
                child: BackGround(context, 43, 43),
              ),
              Container(
                padding: EdgeInsets.only(left: 16, top: 10),
                child: BackGround(context, 70, 70),
              ),
              Container(
                padding: EdgeInsets.only(left: 29),
                child: BackGround(context, 83, 83),
              ),
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(bottomRight: Radius.circular(150)),
          color: Colors.white,
      ),
      child: buildBackGround(context),
    );
  }
}