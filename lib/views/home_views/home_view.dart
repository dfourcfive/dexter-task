import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeView extends StatelessWidget {
  static const id = '/home-view';

  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const colors = [Color(0xFF87CEFB), Color(0xFFFF7800), Color(0xFFFFD301), Color(0xFFFEF65C)];
    const icons = [Icons.design_services, Icons.info, Icons.meeting_room, Icons.health_and_safety];
    const type = ['Design', 'Learning', 'Meeting', 'Health'];

    return Container(
        color: Colors.black,
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.only(left: 18.0, top: 60.h),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Hello',
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400),
                          ),
                          Text(
                            'Wyatt Little',
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 16.sp),
                          )
                        ],
                      ),
                      Container(
                          padding: EdgeInsets.only(right: 14.0),
                          child: Material(
                            shape: CircleBorder(),
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            child: InkWell(
                              splashColor: Colors.black26,
                              child: Ink.image(
                                image: AssetImage("assets/images/person.jpeg"),
                                fit: BoxFit.cover, //Add this line for center crop or use 2nd way
                                height: 60,
                                width: 60,
                              ),
                            ),
                          ))
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 20.h, top: 50.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 18.0),
                          child: Text(
                            'Category',
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 16.sp),
                          ),
                        ),
                        Container(
                          height: 150,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: 4,
                              itemBuilder: (context, index) {
                                return Container(
                                  height: 100,
                                  width: 100,
                                  margin: const EdgeInsets.only(right: 10.0),
                                  decoration: BoxDecoration(color: colors[index], borderRadius: const BorderRadius.all(Radius.circular(14))),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: 12.0, left: 10),
                                        child: Icon(
                                          icons[index],
                                          color: Colors.white,
                                        ),
                                      ),
                                      Padding(
                                          padding: const EdgeInsets.only(top: 12.0, left: 10),
                                          child: Text(
                                            type[index],
                                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 16.sp),
                                          )),
                                      Padding(
                                          padding: const EdgeInsets.only(top: 12.0, left: 10),
                                          child: Text(
                                            '- ${index * 2 + 1} Tasks',
                                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 12.sp),
                                          ))
                                    ],
                                  ),
                                );
                              }),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 0.4.sh,
                  decoration: const BoxDecoration(
                      color: Colors.white, borderRadius: BorderRadius.only(topLeft: Radius.circular(50), topRight: Radius.circular(50))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 18.0, left: 40.w),
                        child: Text(
                          "Today's Tasks",
                          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 20.sp),
                        ),
                      ),
                      //first item
                      Container(
                        margin: EdgeInsets.only(right: 20.w, left: 30.w, top: 20.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  height: 50,
                                  width: 50,
                                  decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)), color: Color(0xFF90EE90)),
                                  child: const Center(
                                      child: Icon(
                                    Icons.brush,
                                    color: Colors.white,
                                  )),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 18.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Sketching',
                                        style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16.sp),
                                      ),
                                      Text(
                                        '2 Completed',
                                        style: TextStyle(fontWeight: FontWeight.w200, fontSize: 11.sp),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              height: 32,
                              width: 32,
                              decoration: BoxDecoration(
                                  color: Color(0xFF90EE90).withOpacity(0.4),
                                  border: Border.all(width: 0.3, color: Color(0xFF90EE90)),
                                  borderRadius: BorderRadius.all(Radius.circular(5))),
                              child: Center(
                                child: Text(
                                  '5',
                                  style: TextStyle(color: Color(0xFF90EE90)),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      //first item
                      Container(
                        margin: EdgeInsets.only(right: 20.w, left: 30.w, top: 20.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  height: 50,
                                  width: 50,
                                  decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)), color: Color(0xFF90EE90)),
                                  child: const Center(
                                      child: Icon(
                                    Icons.brush,
                                    color: Colors.white,
                                  )),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 18.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Sketching',
                                        style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16.sp),
                                      ),
                                      Text(
                                        '2 Completed',
                                        style: TextStyle(fontWeight: FontWeight.w200, fontSize: 11.sp),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              height: 32,
                              width: 32,
                              decoration: BoxDecoration(
                                  color: Color(0xFF90EE90).withOpacity(0.4),
                                  border: Border.all(width: 0.3, color: Color(0xFF90EE90)),
                                  borderRadius: BorderRadius.all(Radius.circular(5))),
                              child: Center(
                                child: Text(
                                  '5',
                                  style: TextStyle(color: Color(0xFF90EE90)),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      //first item
                      Container(
                        margin: EdgeInsets.only(right: 20.w, left: 30.w, top: 20.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  height: 50,
                                  width: 50,
                                  decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)), color: Color(0xFF90EE90)),
                                  child: const Center(
                                      child: Icon(
                                    Icons.brush,
                                    color: Colors.white,
                                  )),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 18.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Sketching',
                                        style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16.sp),
                                      ),
                                      Text(
                                        '2 Completed',
                                        style: TextStyle(fontWeight: FontWeight.w200, fontSize: 11.sp),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              height: 32,
                              width: 32,
                              decoration: BoxDecoration(
                                  color: Color(0xFF90EE90).withOpacity(0.4),
                                  border: Border.all(width: 0.3, color: Color(0xFF90EE90)),
                                  borderRadius: BorderRadius.all(Radius.circular(5))),
                              child: Center(
                                child: Text(
                                  '5',
                                  style: TextStyle(color: Color(0xFF90EE90)),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                )),
          ],
        ));
  }
}
