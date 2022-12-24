import 'dart:convert';
import 'package:bulldozer_test/json_to_dart.dart';
import 'package:bulldozer_test/shift_offer_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class ShiftOffersScreen extends StatefulWidget {
  ShiftOffersScreen({Key? key}) : super(key: key);

  @override
  State<ShiftOffersScreen> createState() => _ShiftOffersScreenState();
}

class _ShiftOffersScreenState extends State<ShiftOffersScreen> {
  Stream<OfferedShifts> getOfferedShifts = (() async* {
    await Future<void>.delayed(Duration(milliseconds: 400));

    final String response = await rootBundle.loadString('assets/json/offered_shifts.json');
    dynamic data = await json.decode(response);
    OfferedShifts offeredShift = OfferedShifts.fromJson(data);
    yield offeredShift;
  })();

  @override
  void initState() {
    super.initState();
    initializeDateFormatting();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: Color(0xFFF2F2F2),
      body: StreamBuilder<OfferedShifts>(
        stream: getOfferedShifts,
        builder: (BuildContext context, AsyncSnapshot<OfferedShifts> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting || snapshot.connectionState == ConnectionState.active) {
            return Center(child: CircularProgressIndicator(color: Colors.black));
          } else if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Container();
            } else if (snapshot.hasData) {
              return SingleChildScrollView(
                child: SafeArea(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 45, left: 22),
                        child: Text(
                          'Shifts offerts',
                          style: TextStyle(
                            fontFamily: 'PTSerif',
                            fontSize: 34,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      if (snapshot.data?.offers != null)
                        if (snapshot.data!.offers!.where((element) => element.startSoon == true).length > 0)
                          Container(
                            margin: EdgeInsets.only(top: 45, bottom: 8, left: 22),
                            child: Text(
                              'DERNIÈRE MINUTE',
                              style: TextStyle(
                                fontFamily: 'Roboto',
                                fontSize: 14,
                                color: Color.fromRGBO(109, 114, 120, 0.5),
                                fontWeight: FontWeight.w500,
                                letterSpacing: 1,
                              ),
                            ),
                          ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: BouncingScrollPhysics(),
                        itemCount: snapshot.data?.offers?.where((element) => element.startSoon == true).length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => ShiftOfferScreen(offer: snapshot.data!.offers![index])));
                            },
                            child: Container(
                              height: 150,
                              margin: EdgeInsets.symmetric(vertical: 8, horizontal: 22),
                              padding: EdgeInsets.symmetric(vertical: 18),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(12),
                                ),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(left: 22),
                                    child: Text(
                                      '${snapshot.data?.offers?[index].company}',
                                      style: TextStyle(
                                        fontFamily: 'PTSerif',
                                        fontSize: 22,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500,
                                        letterSpacing: 1,
                                      ),
                                    ),
                                  ),
                                  if (snapshot.data?.offers?[index].startAt != null)
                                    Container(
                                      margin: EdgeInsets.symmetric(horizontal: 22),
                                      child: Text(
                                        'Aujourd\'hui'.toUpperCase(),
                                        style: TextStyle(
                                          fontFamily: 'Roboto',
                                          fontSize: 14,
                                          color: Color.fromRGBO(109, 114, 120, 1),
                                          fontWeight: FontWeight.w500,
                                          letterSpacing: 1,
                                        ),
                                      ),
                                    ),
                                  Container(
                                    margin: EdgeInsets.symmetric(horizontal: 22),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          height: 34,
                                          width: 71,
                                          padding: EdgeInsets.symmetric(vertical: 6, horizontal: 11),
                                          decoration: BoxDecoration(
                                            color: Color.fromRGBO(239, 239, 239, 1),
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(20),
                                            ),
                                          ),
                                          child: Center(
                                            child: Text(
                                              '${snapshot.data?.offers?[index].postName}',
                                              maxLines: 1,
                                              style: TextStyle(
                                                fontFamily: 'Roboto',
                                                fontSize: 14,
                                                color: Color.fromRGBO(154, 154, 154, 1),
                                                fontWeight: FontWeight.w500,
                                                letterSpacing: 0,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Text(
                                          '${snapshot.data?.offers?[index].buyPrice}\$ / H',
                                          style: TextStyle(
                                            fontFamily: 'Roboto',
                                            fontSize: 14,
                                            color: Color.fromRGBO(154, 154, 154, 1),
                                            fontWeight: FontWeight.w500,
                                            letterSpacing: 0,
                                          ),
                                        ),
                                        Text(
                                          '+ ${snapshot.data?.offers?[index].bonus}\$ / H',
                                          style: TextStyle(
                                            fontFamily: 'Roboto',
                                            fontSize: 14,
                                            color: snapshot.data?.offers?[index].bonus != null
                                                ? snapshot.data!.offers![index].bonus! > 0
                                                    ? Color.fromRGBO(94, 211, 105, 1)
                                                    : Colors.white
                                                : Colors.white,
                                            fontWeight: FontWeight.w500,
                                            letterSpacing: 0,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 40,
                                        ),
                                        Text(
                                          '${snapshot.data!.offers![index].startAt?.hour}:${snapshot.data!.offers![index].startAt?.minute} - ${snapshot.data!.offers![index].endAt?.hour}:${snapshot.data!.offers![index].endAt?.minute}',
                                          style: TextStyle(
                                            fontFamily: 'Roboto',
                                            fontSize: 14,
                                            color: Color.fromRGBO(241, 57, 57, 1),
                                            fontWeight: FontWeight.w500,
                                            letterSpacing: 0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 22, bottom: 8, left: 22),
                        child: Text(
                          'SHIFTS À VENIR',
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 14,
                            color: Color.fromRGBO(109, 114, 120, 0.5),
                            fontWeight: FontWeight.w500,
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: BouncingScrollPhysics(),
                        itemCount: snapshot.data?.offers?.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => ShiftOfferScreen(offer: snapshot.data!.offers![index])));
                            },
                            child: Container(
                              height: 150,
                              margin: EdgeInsets.symmetric(vertical: 8, horizontal: 22),
                              padding: EdgeInsets.symmetric(vertical: 18),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(12),
                                ),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(left: 22),
                                    child: Text(
                                      '${snapshot.data?.offers?[index].company}',
                                      style: TextStyle(
                                        fontFamily: 'PTSerif',
                                        fontSize: 22,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500,
                                        letterSpacing: 1,
                                      ),
                                    ),
                                  ),
                                  if (snapshot.data?.offers?[index].startAt != null)
                                    Container(
                                      margin: EdgeInsets.symmetric(horizontal: 22),
                                      child: Text(
                                        '${DateFormat('EEEE d MMMM', 'fr').format(snapshot.data!.offers![index].startAt!)}'.toUpperCase(),
                                        style: TextStyle(
                                          fontFamily: 'Roboto',
                                          fontSize: 14,
                                          color: Color.fromRGBO(109, 114, 120, 1),
                                          fontWeight: FontWeight.w500,
                                          letterSpacing: 1,
                                        ),
                                      ),
                                    ),
                                  Container(
                                    margin: EdgeInsets.symmetric(horizontal: 22),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          height: 34,
                                          width: 71,
                                          padding: EdgeInsets.symmetric(vertical: 6, horizontal: 11),
                                          decoration: BoxDecoration(
                                            color: Color.fromRGBO(239, 239, 239, 1),
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(20),
                                            ),
                                          ),
                                          child: Center(
                                            child: Text(
                                              '${snapshot.data?.offers?[index].postName}',
                                              maxLines: 1,
                                              style: TextStyle(
                                                fontFamily: 'Roboto',
                                                fontSize: 14,
                                                color: Color.fromRGBO(154, 154, 154, 1),
                                                fontWeight: FontWeight.w500,
                                                letterSpacing: 0,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Text(
                                          '${snapshot.data?.offers?[index].buyPrice}\$ / H',
                                          style: TextStyle(
                                            fontFamily: 'Roboto',
                                            fontSize: 14,
                                            color: Color.fromRGBO(154, 154, 154, 1),
                                            fontWeight: FontWeight.w500,
                                            letterSpacing: 0,
                                          ),
                                        ),
                                        Text(
                                          '+ ${snapshot.data?.offers?[index].bonus}\$ / H',
                                          style: TextStyle(
                                            fontFamily: 'Roboto',
                                            fontSize: 14,
                                            color: snapshot.data?.offers?[index].bonus != null
                                                ? snapshot.data!.offers![index].bonus! > 0
                                                    ? Color.fromRGBO(94, 211, 105, 1)
                                                    : Colors.white
                                                : Colors.white,
                                            fontWeight: FontWeight.w500,
                                            letterSpacing: 0,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 40,
                                        ),
                                        Text(
                                          '${snapshot.data!.offers![index].startAt?.hour}:${snapshot.data!.offers![index].startAt?.minute} - ${snapshot.data!.offers![index].endAt?.hour}:${snapshot.data!.offers![index].endAt?.minute}',
                                          style: TextStyle(
                                            fontFamily: 'Roboto',
                                            fontSize: 14,
                                            color: Color.fromRGBO(154, 154, 154, 1),
                                            fontWeight: FontWeight.w500,
                                            letterSpacing: 0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              );
            }
          }
          return Container();
        },
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          height: 70,
          margin: EdgeInsets.symmetric(vertical: 6, horizontal: 14),
          padding: EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(45),
          ),
          child: Row(
            children: [
              Flexible(
                flex: 8,
                child: Container(
                  height: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 50),
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(83, 197, 205, 1),
                    borderRadius: BorderRadius.circular(45),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(
                        Icons.search,
                        color: Colors.white,
                        size: 26,
                      ),
                      Text(
                        'Shift Offers',
                        maxLines: 1,
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  height: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(239, 239, 239, 1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.sticky_note_2_outlined,
                    color: Colors.black,
                    size: 26,
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  height: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(239, 239, 239, 1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.person_outline_outlined,
                    color: Colors.black,
                    size: 26,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
