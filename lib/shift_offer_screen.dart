import 'dart:convert';
import 'package:bulldozer_test/json_to_dart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class ShiftOfferScreen extends StatefulWidget {
  final Offer offer;

  ShiftOfferScreen({Key? key, required this.offer}) : super(key: key);

  @override
  State<ShiftOfferScreen> createState() => _ShiftOfferScreenState();
}

class _ShiftOfferScreenState extends State<ShiftOfferScreen> {
  Stream<OfferedShifts> getOfferedShifts = (() async* {
    await Future<void>.delayed(Duration(seconds: 0));

    final String response = await rootBundle.loadString('assets/offered_shifts.json');
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
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Container(
                  margin: EdgeInsets.only(top: 25, left: 22),
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.arrow_back_rounded,
                    color: Colors.white,
                    size: 26,
                  ),
                ),
              ),
              Center(
                child: CircleAvatar(
                  radius: 62,
                  backgroundColor: Colors.black,
                  child: CircleAvatar(
                    radius: 60,
                    backgroundImage: NetworkImage('https://ssmscdn.yp.ca/image/resize/485cbf7f-c262-4237-9e40-6aa6b7ed059f/ypui-d-mp-pic-gal-lg/restaurant-le-bistro-sous-le-fort-devantdemagasin-1.jpg'),
                  ),
                ),
              ),
              Center(
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    '${widget.offer.company}',
                    style: TextStyle(
                      fontFamily: 'PTSerif',
                      fontSize: 26,
                      color: Colors.black,
                      letterSpacing: 0,
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 16, horizontal: 22),
                child: Text(
                  '${DateFormat('EEEE d MMMM', 'fr').format(widget.offer.startAt!)}'.toUpperCase(),
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 14,
                    color: Color.fromRGBO(241, 57, 57, 1),
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
                    Row(
                      children: [
                        Container(
                          height: 34,
                          padding: EdgeInsets.symmetric(vertical: 6, horizontal: 11),
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(239, 239, 239, 1),
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              '${widget.offer.postName}',
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
                        SizedBox(width: 15),
                        Text(
                          '${widget.offer.buyPrice}\$ / H',
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
                    SizedBox(width: 40),
                    Text(
                      '${widget.offer.startAt?.hour}:${widget.offer.startAt?.minute} - ${widget.offer.endAt?.hour}:${widget.offer.endAt?.minute}',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 14,
                        color: Color.fromRGBO(109, 114, 120, 1),
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 22, left: 22, right: 88),
                child: Row(
                  children: [
                    Container(
                      height: 50,
                      margin: EdgeInsets.only(right: 8),
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.black, width: 1.5),
                      ),
                      child: Icon(
                        Icons.location_on_outlined,
                        color: Colors.black,
                        size: 20,
                      ),
                    ),
                    Flexible(
                      child: Text(
                        '48 Rue Sous le Fort, Québec, QC G1K 4G9',
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.w200,
                          letterSpacing: 0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 4, left: 22, right: 88),
                child: Row(
                  children: [
                    Container(
                      height: 50,
                      margin: EdgeInsets.only(right: 8),
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.black, width: 1.5),
                      ),
                      child: Icon(
                        Icons.attach_money_rounded,
                        color: Colors.black,
                        size: 20,
                      ),
                    ),
                    Flexible(
                      child: Text(
                        'Bonus au travailleur: +${widget.offer.bonus}\$/H',
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.w200,
                          letterSpacing: 0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 4, left: 22, right: 88),
                child: Row(
                  children: [
                    Container(
                      height: 50,
                      margin: EdgeInsets.only(right: 8),
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.black, width: 1.5),
                      ),
                      child: Icon(
                        Icons.pause_rounded,
                        color: Colors.black,
                        size: 20,
                      ),
                    ),
                    Flexible(
                      child: Text(
                        'Pause de 30 minutes',
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.w200,
                          letterSpacing: 0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 4, left: 22, right: 88),
                child: Row(
                  children: [
                    Container(
                      height: 50,
                      margin: EdgeInsets.only(right: 8),
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.black, width: 1.5),
                      ),
                      child: Icon(
                        Icons.local_parking_rounded,
                        color: Colors.black,
                        size: 20,
                      ),
                    ),
                    Flexible(
                      child: Text(
                        'Stationnement gratuit',
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.w200,
                          letterSpacing: 0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 4, left: 22, right: 88),
                child: Row(
                  children: [
                    Container(
                      height: 50,
                      margin: EdgeInsets.only(right: 8),
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.black, width: 1.5),
                      ),
                      child: Icon(
                        Icons.sentiment_satisfied_alt_rounded,
                        color: Colors.black,
                        size: 20,
                      ),
                    ),
                    Flexible(
                      child: Text(
                        'Pantalon noir, chemise noir',
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.w200,
                          letterSpacing: 0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 16, left: 22),
                child: Text(
                  'Responsable',
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 14,
                    color: Color.fromRGBO(109, 114, 120, 0.5),
                    fontWeight: FontWeight.w500,
                    letterSpacing: 1,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 4, left: 22),
                child: Text(
                  'Gregorie Kolvkas',
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.w200,
                    letterSpacing: 0,
                  ),
                ),
              ),
              Container(
                height: 70,
                width: double.infinity,
                margin: EdgeInsets.symmetric(vertical: 45, horizontal: 22),
                decoration: BoxDecoration(
                  color: Color.fromRGBO(83, 197, 205, 1),
                  borderRadius: BorderRadius.circular(45),
                ),
                child: Center(
                  child: Text(
                    'Postuler',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0,
                    ),
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
