import 'dart:async';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons_null_safety/flutter_icons_null_safety.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:zerodha/src/bloc/authentication/authentication_bloc.dart';
import 'package:zerodha/src/repository/helpeaze_preference_provider.dart';
import 'package:zerodha/src/repository/repository.dart';
import 'package:zerodha/src/ui/bottomSheets/filter_bottomsheet_view.dart';
import 'package:zerodha/src/utils/app_utils.dart';

class PortfolioPageTab extends StatefulWidget {
  final Repository appRepository;
  final PreferenceProvider sharePreferenceProvider;

  const PortfolioPageTab(
      {required this.appRepository, required this.sharePreferenceProvider});

  @override
  _PortfolioPageTabState createState() => _PortfolioPageTabState();
}

class _PortfolioPageTabState extends State<PortfolioPageTab>
    with SingleTickerProviderStateMixin {
  late BuildContext mContext;
  late TabController _tabController;
  int index = 0;
  bool isViewVisible = false;
  bool isSearchVisible = false;
  final _searchController = TextEditingController();
  final RefreshController _refreshController1 =
      RefreshController(initialRefresh: false);
  final RefreshController _refreshController2 =
  RefreshController(initialRefresh: false);

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
    _tabController.addListener(() {
      setState(() {
        index = _tabController.index;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) {
          return AuthenticationBloc(
              widget.appRepository, widget.sharePreferenceProvider);
        },
        child: BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            if (state is LoadingState) {
              AppUtils.showProgressDialog(context, 'Please Wait...');
            } else {
              AppUtils.hideProgressDialog(context);
            }
          },
          child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
            builder: (context, state) {
              if (state is AuthenticationInitial) {}
              mContext = context;
              return _buildContent(context);
            },
          ),
        ),
      ),
      /*bottomNavigationBar: !isViewVisible
          ? Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.white.withOpacity(0.1),
                    spreadRadius: 5,
                    blurRadius: 11,
                  ),
                ],
              ),
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 8.0, bottom: 8.0),
              child: Row(
                children: [
                  const Expanded(
                    child: Text(
                      "Day's P&L",
                      style: TextStyle(
                        */ /*fontWeight: FontWeight.w400,*/ /*
                        color: Colors.black,
                        */ /*fontSize: 15.0,*/ /*
                      ),
                    ),
                  ),
                  RichText(
                    textAlign: TextAlign.center,
                    text: const TextSpan(
                        text: '+1055.95 ',
                        style: TextStyle(
                          */ /*fontWeight: FontWeight.w400,*/ /*
                          color: Colors.green,
                          */ /*fontSize: 15.0,*/ /*
                        ),
                        children: <TextSpan>[
                          TextSpan(
                              text: ' +1.13%',
                              style: TextStyle(
                                */ /*fontWeight: FontWeight.w400,*/ /*
                                color: Colors.green, */ /*fontSize: 13.0*/ /*
                              ))
                        ]),
                  ),
                ],
              ),
            )
          : null,*/
    );
  }

  Widget _buildContent(BuildContext context) {
    return SafeArea(
        child: Container(
      color: const Color(0xFFebecee),
      child: Column(
        children: [
          const SizedBox(height: 10.0),
          Visibility(
              visible: isViewVisible,
              child: Column(
                children: [
                  const SizedBox(height: 10.0),
                  Row(
                    children: [
                      const SizedBox(width: 20.0),
                      const Expanded(
                        child: Text(
                          'Overview',
                          style: TextStyle(
                              fontSize: 22.0,
                              color: Colors.black,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isViewVisible = false;
                          });
                        },
                        child: const Icon(Icons.close, size: 30.0),
                      ),
                      const SizedBox(width: 15.0),
                    ],
                  ),
                  const SizedBox(height: 30.0),
                  Row(
                    children: const [
                      SizedBox(width: 25.0),
                      Expanded(
                        child: Text(
                          'SENSEX',
                          style: TextStyle(
                            fontSize: 15.0,
                            color: Colors.black, /*fontWeight: FontWeight.w500*/
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          'NIFTY BANK',
                          style: TextStyle(
                            fontSize: 15.0,
                            color: Colors.black, /*fontWeight: FontWeight.w500*/
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5.0),
                  Row(
                    children: const [
                      SizedBox(width: 25.0),
                      Expanded(
                        child: Text(
                          '54481.84',
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.black, /*fontWeight: FontWeight.w400*/
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          '35124.05.84',
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.black, /*fontWeight: FontWeight.w400*/
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15.0),
                  Row(
                    children: const [
                      SizedBox(width: 25.0),
                      Expanded(
                        child: Text(
                          '+303.38    +0.56%',
                          style: TextStyle(
                            fontSize: 14.0,
                            color:
                                Colors.green, /* fontWeight: FontWeight.w400*/
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          '+203.75    +0.58%',
                          style: TextStyle(
                            fontSize: 14.0,
                            color: Colors.green, /*fontWeight: FontWeight.w400*/
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15.0),
                  Row(
                    children: const [
                      SizedBox(width: 15.0),
                      Expanded(
                        child: Text(
                          '* Charts indicates 52 weeks trend',
                          style: TextStyle(
                            fontSize: 12.0,
                            color: Colors.grey, /* fontWeight: FontWeight.w400*/
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20.0),
                  const Divider(
                      color: Colors.grey, indent: 15.0, endIndent: 15.0),
                  const SizedBox(height: 20.0),
                  Row(
                    children: const [
                      SizedBox(width: 25.0),
                      Expanded(
                        child: Text(
                          'Funds',
                          style: TextStyle(
                            fontSize: 14.0,
                            color: Colors.black, /*fontWeight: FontWeight.bold*/
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20.0),
                  Row(
                    children: const [
                      SizedBox(width: 25.0),
                      Expanded(
                        child: Text(
                          'Equity',
                          style: TextStyle(
                            fontSize: 15.0,
                            color: Colors.grey, /*fontWeight: FontWeight.w400*/
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          'Commodity',
                          style: TextStyle(
                            fontSize: 15.0,
                            color: Colors.grey, /*fontWeight: FontWeight.w400*/
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5.0),
                  Row(
                    children: const [
                      SizedBox(width: 25.0),
                      Expanded(
                        child: Text(
                          '₹0.00',
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.black, /*fontWeight: FontWeight.w500*/
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          '₹0.00',
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.black, /*fontWeight: FontWeight.w500*/
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15.0),
                ],
              )),
          Expanded(
              child: Opacity(
            opacity: isViewVisible ? 0.5 : 1.0,
            child: AbsorbPointer(
              absorbing: isViewVisible,
              child: Container(
                decoration: BoxDecoration(
                  color: isViewVisible
                      ? Colors.white.withOpacity(0.9)
                      : Colors.transparent,
                  boxShadow: isViewVisible
                      ? [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: const Offset(
                                0, 3), // changes position of shadow
                          ),
                        ]
                      : [],
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 10.0),
                    Row(
                      children: [
                        const SizedBox(width: 20.0),
                        const Expanded(
                          child: Text(
                            'Portfolio',
                            style: TextStyle(
                                fontSize: 22.0,
                                color: Colors.black,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isViewVisible = true;
                            });
                          },
                          child:
                              const Icon(Icons.keyboard_arrow_down, size: 40.0),
                        ),
                        const SizedBox(width: 10.0),
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 5.0),
                      child: TabBar(
                        indicatorColor: Colors.blue,
                        labelColor: Colors.blue,
                        unselectedLabelColor: Colors.black,
                        tabs: [
                          SizedBox(
                            width: 110.0,
                            child: Tab(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const SizedBox(width: 5.0),
                                  const Text(
                                    'Holdings',
                                    style: TextStyle(
                                        fontSize: 13.0,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  const SizedBox(width: 5.0),
                                  Container(
                                    width: 20,
                                    height: 20,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 1, color: Colors.transparent),
                                      shape: BoxShape.circle,
                                      color: index == 0
                                          ? Colors.blue
                                          : Colors.grey,
                                    ),
                                    child: const Text(
                                      '12',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 11.0, color: Colors.white),
                                    ),
                                  ),
                                  const SizedBox(width: 5.0),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 110.0,
                            child: Tab(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  SizedBox(width: 5.0),
                                  Text(
                                    'Positions',
                                    style: TextStyle(
                                        fontSize: 13.0,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  SizedBox(width: 5.0),
                                  /*Container(
                          width: 20,
                          height: 20,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            border:
                                Border.all(width: 1, color: Colors.transparent),
                            shape: BoxShape.circle,
                            color: index == 1 ? Colors.blue : Colors.grey,
                          ),
                          child: const Text(
                            '12',
                            textAlign: TextAlign.center,
                            style:
                                TextStyle(fontSize: 11.0, color: Colors.white),
                          ),
                        ),*/
                                  SizedBox(width: 5.0),
                                ],
                              ),
                            ),
                          ),
                        ],
                        controller: _tabController,
                        indicatorSize: TabBarIndicatorSize.label,
                      ),
                    ),
                    Expanded(
                      child: TabBarView(
                        controller: _tabController,
                        children: [
                          SmartRefresher(
                            controller: _refreshController1,
                            onRefresh: _refresh1,
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  const SizedBox(height: 20.0),
                                  Stack(
                                    children: [
                                      Container(
                                        margin: isSearchVisible
                                            ? const EdgeInsets.only(top: 30.0)
                                            : const EdgeInsets.only(top: 60.0),
                                        decoration: const BoxDecoration(
                                          color: Colors.white,
                                        ),
                                        child: Column(
                                          children: [
                                            Container(
                                              padding: isSearchVisible
                                                  ? const EdgeInsets.only(
                                                      top: 35.0,
                                                      left: 20.0,
                                                      right: 20.0)
                                                  : const EdgeInsets.only(
                                                      top: 85.0,
                                                      left: 20.0,
                                                      right: 20.0),
                                              child: Visibility(
                                                visible: !isSearchVisible,
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Expanded(
                                                          child: Row(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              GestureDetector(
                                                                onTap: () {
                                                                  setState(() {
                                                                    isSearchVisible =
                                                                        !isSearchVisible;
                                                                  });
                                                                },
                                                                child: const Icon(
                                                                    AntDesign
                                                                        .search1,
                                                                    color: Colors
                                                                        .blue,
                                                                    size: 16),
                                                              ),
                                                              const SizedBox(
                                                                  width: 20.0),
                                                              GestureDetector(
                                                                  onTap: () {
                                                                    showModalBottomSheet(
                                                                        isScrollControlled:
                                                                            true,
                                                                        context:
                                                                            context,
                                                                        useRootNavigator:
                                                                            true,
                                                                        builder:
                                                                            (BuildContext
                                                                                context) {
                                                                          return const FilterBottomSheetView();
                                                                        });
                                                                  },
                                                                  child: const Icon(
                                                                      Octicons
                                                                          .settings,
                                                                      color: Colors
                                                                          .blue,
                                                                      size:
                                                                          16.0))
                                                            ],
                                                          ),
                                                        ),
                                                        Expanded(
                                                          child: Row(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            children: [
                                                              const Icon(
                                                                  Icons
                                                                      .family_restroom,
                                                                  color: Colors
                                                                      .blue,
                                                                  size: 22.0),
                                                              const SizedBox(
                                                                  width: 5.0),
                                                              const Text(
                                                                'Family',
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        12.0,
                                                                    color: Colors
                                                                        .blue),
                                                              ),
                                                              const SizedBox(
                                                                  width: 10.0),
                                                              Icon(
                                                                  FontAwesome
                                                                      .circle_o,
                                                                  color: Colors
                                                                          .blue[
                                                                      900],
                                                                  size: 22.0),
                                                              const SizedBox(
                                                                  width: 5.0),
                                                              const Text(
                                                                'Analytics',
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        12.0,
                                                                    color: Colors
                                                                        .blue),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(height: 5.0),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Visibility(
                                              visible: !isSearchVisible,
                                              child: const Divider(
                                                  color: Colors.grey),
                                            ),
                                            ListView.builder(
                                                itemCount: 8,
                                                physics:
                                                    const NeverScrollableScrollPhysics(),
                                                scrollDirection: Axis.vertical,
                                                shrinkWrap: true,
                                                itemBuilder: (context, index) {
                                                  return GestureDetector(
                                                    child: Column(
                                                      children: [
                                                        Container(
                                                          margin:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 15.0,
                                                                  right: 15.0,
                                                                  top: 10.0,
                                                                  bottom: 10.0),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Expanded(
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: <
                                                                      Widget>[
                                                                    Row(
                                                                      children: [
                                                                        RichText(
                                                                          textAlign:
                                                                              TextAlign.center,
                                                                          text: const TextSpan(
                                                                              text: '10',
                                                                              style: TextStyle(color: Colors.grey),
                                                                              children: <TextSpan>[
                                                                                TextSpan(text: ' Qty.', style: TextStyle(color: Colors.black))
                                                                              ]),
                                                                        ),
                                                                        const SizedBox(
                                                                            width:
                                                                                5.0),
                                                                        const Text(
                                                                            "•",
                                                                            style:
                                                                                TextStyle(fontSize: 8.0)),
                                                                        const SizedBox(
                                                                            width:
                                                                                5.0),
                                                                        RichText(
                                                                          textAlign:
                                                                              TextAlign.center,
                                                                          text:
                                                                              const TextSpan(
                                                                                  text: 'Avg.',
                                                                                  style: TextStyle(
                                                                                    color: Colors.grey,
                                                                                  ),
                                                                                  children: <TextSpan>[
                                                                                TextSpan(text: ' 880.00', style: TextStyle(color: Colors.black))
                                                                              ]),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    const SizedBox(
                                                                        height:
                                                                            8.0),
                                                                    const Text(
                                                                      'AFFLE',
                                                                    ),
                                                                    const SizedBox(
                                                                        height:
                                                                            8.0),
                                                                    RichText(
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                      text: const TextSpan(
                                                                          text: 'Invested',
                                                                          style: TextStyle(
                                                                            color:
                                                                                Colors.grey,
                                                                            fontSize:
                                                                                14.0,
                                                                          ),
                                                                          children: <TextSpan>[
                                                                            TextSpan(
                                                                                text: ' 8820.00',
                                                                                style: TextStyle(color: Colors.black, fontSize: 14.0))
                                                                          ]),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              Expanded(
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .end,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: <
                                                                      Widget>[
                                                                    const Text(
                                                                      '+17.90 %',
                                                                      style:
                                                                          TextStyle(
                                                                        /*fontWeight:
                                                                          FontWeight
                                                                              .w600,*/
                                                                        color: Colors
                                                                            .green,
                                                                        /*fontSize:
                                                                          13.0,*/
                                                                      ),
                                                                    ),
                                                                    const SizedBox(
                                                                        height:
                                                                            8.0),
                                                                    const Text(
                                                                      '+1232.00',
                                                                      style:
                                                                          TextStyle(
                                                                        /*fontWeight:
                                                                          FontWeight
                                                                              .w600,*/
                                                                        color: Colors
                                                                            .green,
                                                                        /*fontSize:
                                                                          15.0,*/
                                                                      ),
                                                                    ),
                                                                    const SizedBox(
                                                                        height:
                                                                            8.0),
                                                                    RichText(
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                      text: const TextSpan(
                                                                          text: 'LTP',
                                                                          style: TextStyle(
                                                                            fontSize:
                                                                                14,
                                                                            color:
                                                                                Colors.grey,
                                                                          ),
                                                                          children: <TextSpan>[
                                                                            TextSpan(
                                                                                text: ' 1120.00',
                                                                                style: TextStyle(fontSize: 14, color: Colors.black)),
                                                                            TextSpan(
                                                                                text: ' (+3.01%)',
                                                                                style: TextStyle(
                                                                                  fontSize: 14,
                                                                                  color: Colors.green,
                                                                                ))
                                                                          ]),
                                                                    ),
                                                                  ],
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                        const Divider(
                                                            color: Colors.grey),
                                                      ],
                                                    ),
                                                  );
                                                })
                                          ],
                                        ),
                                      ),
                                      isSearchVisible
                                          ? Container(
                                              padding: const EdgeInsets.only(
                                                  left: 0.0, right: 10.0),
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  .9,
                                              alignment: Alignment.center,
                                              margin: const EdgeInsets.only(
                                                  left: 20.0, right: 20.0),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(5.0)),
                                                color: Colors.white,
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey
                                                        .withOpacity(0.5),
                                                    spreadRadius: 5,
                                                    blurRadius: 7,
                                                    offset: const Offset(0,
                                                        3), // changes position of shadow
                                                  ),
                                                ],
                                              ),
                                              child: TextFormField(
                                                keyboardType:
                                                    TextInputType.text,
                                                autofocus: true,
                                                controller: _searchController,
                                                style: const TextStyle(
                                                  color: Color(0xFF181818),
                                                  fontSize:
                                                      16.0, /*fontWeight: FontWeight.w400*/
                                                ),
                                                decoration: InputDecoration(
                                                    prefixIcon: GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          isSearchVisible =
                                                              !isSearchVisible;
                                                        });
                                                      },
                                                      child: const Icon(
                                                          Icons.arrow_back,
                                                          color: Color(
                                                              0xFFa9a8ae)),
                                                    ),
                                                    suffixIcon: SizedBox(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              .15,
                                                      height: 5.0,
                                                      child: Row(
                                                        children: [
                                                          const VerticalDivider(
                                                            endIndent: 15.0,
                                                            indent: 15.0,
                                                            thickness: 1.0,
                                                            color: Color(
                                                                0xFFa9a8ae),
                                                          ),
                                                          const SizedBox(
                                                              width: 5.0),
                                                          GestureDetector(
                                                              onTap: () {
                                                                showModalBottomSheet(
                                                                    isScrollControlled:
                                                                        true,
                                                                    context:
                                                                        context,
                                                                    useRootNavigator:
                                                                        true,
                                                                    builder:
                                                                        (BuildContext
                                                                            context) {
                                                                      return const FilterBottomSheetView();
                                                                    });
                                                              },
                                                              child: const Icon(
                                                                  Octicons
                                                                      .settings,
                                                                  color: Colors
                                                                      .grey,
                                                                  size: 16.0))
                                                        ],
                                                      ),
                                                    ),
                                                    counterText: '',
                                                    contentPadding:
                                                        const EdgeInsets.all(
                                                            15),
                                                    fillColor:
                                                        Colors.transparent,
                                                    border: InputBorder.none,
                                                    hintStyle: const TextStyle(
                                                        color: Colors.grey),
                                                    hintText:
                                                        'Search eg: infy, reliance',
                                                    filled: true),
                                                maxLength: 50,
                                                maxLines: 1,
                                              ))
                                          : Container(
                                              padding:
                                                  const EdgeInsets.all(20.0),
                                              margin: const EdgeInsets.only(
                                                  left: 20.0, right: 20.0),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(5.0)),
                                                color: Colors.white,
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey
                                                        .withOpacity(0.5),
                                                    spreadRadius: 5,
                                                    blurRadius: 7,
                                                    offset: const Offset(0,
                                                        3), // changes position of shadow
                                                  ),
                                                ],
                                              ),
                                              child: Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: const [
                                                            Text(
                                                              'Invested',
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      15.0,
                                                                  /*fontWeight:
                                                                    FontWeight
                                                                        .w400,*/
                                                                  color: Colors
                                                                      .grey),
                                                            ),
                                                            Text(
                                                              '1,22,345.40',
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      18.0,
                                                                  /*fontWeight:
                                                                    FontWeight
                                                                        .w400,*/
                                                                  color: Colors
                                                                      .black),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: const [
                                                            Text(
                                                              'Current',
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      15.0,
                                                                  /*fontWeight:
                                                                    FontWeight
                                                                        .w400,*/
                                                                  color: Colors
                                                                      .grey),
                                                            ),
                                                            Text(
                                                              '1,02,345.40',
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      18.0,
                                                                  /* fontWeight:
                                                                    FontWeight
                                                                        .w400,*/
                                                                  color: Colors
                                                                      .black),
                                                            ),
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  const SizedBox(height: 5.0),
                                                  const Divider(
                                                      indent: 20.0,
                                                      endIndent: 20.0,
                                                      color: Colors.grey),
                                                  const SizedBox(height: 5.0),
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: const [
                                                            Text(
                                                              'P&L',
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      18.0,
                                                                  /*fontWeight:
                                                                    FontWeight
                                                                        .w400,*/
                                                                  color: Colors
                                                                      .grey),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            RichText(
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              text:
                                                                  const TextSpan(
                                                                      text:
                                                                          '-20,000',
                                                                      style:
                                                                          TextStyle(
                                                                        /*fontWeight:
                                                                          FontWeight
                                                                              .w600,*/
                                                                        color: Colors
                                                                            .red,
                                                                        fontSize:
                                                                            18.0,
                                                                        decoration:
                                                                            TextDecoration.none,
                                                                      ),
                                                                      children: <
                                                                          TextSpan>[
                                                                    TextSpan(
                                                                        text:
                                                                            '  -15.22%',
                                                                        style: TextStyle(
                                                                            /*fontWeight: FontWeight
                                                                              .w400,*/
                                                                            color: Colors.red,
                                                                            fontSize: 15.0))
                                                                  ]),
                                                            ),
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                          SmartRefresher(
                            controller: _refreshController2,
                            onRefresh: _refresh2,
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  const SizedBox(height: 20.0),
                                  Stack(
                                    children: [
                                      Container(
                                        margin:
                                            const EdgeInsets.only(top: 30.0),
                                        decoration: const BoxDecoration(
                                          color: Colors.white,
                                        ),
                                        child: Column(
                                          children: [
                                            Container(
                                              padding: const EdgeInsets.only(
                                                  top: 35.0,
                                                  left: 20.0,
                                                  right: 20.0),
                                              child: Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        child: Opacity(
                                                          opacity: 0.5,
                                                          child: Row(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: const [
                                                              Icon(Icons.search,
                                                                  color: Colors
                                                                      .blue,
                                                                  size: 22.0),
                                                              SizedBox(
                                                                  width: 20.0),
                                                              Icon(Icons.tune,
                                                                  color: Colors
                                                                      .blue,
                                                                  size: 22.0)
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .end,
                                                          children: [
                                                            Icon(
                                                                FontAwesome
                                                                    .circle_o,
                                                                color: Colors
                                                                    .blue[900],
                                                                size: 22.0),
                                                            const SizedBox(
                                                                width: 5.0),
                                                            const Text(
                                                              'Analytics',
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      12.0,
                                                                  color: Colors
                                                                      .blue),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 5.0),
                                                ],
                                              ),
                                            ),
                                            const Divider(color: Colors.grey),
                                            Container(
                                              color: Colors.white,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  .6,
                                              child: Column(
                                                children: [
                                                  Image.asset(
                                                      "assets/image/ic_no_position.png",
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              .3,
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              .4),
                                                  const Text(
                                                    'No positions',
                                                    style: TextStyle(
                                                      /*fontWeight: FontWeight.bold,*/
                                                      color: Colors.black,
                                                      fontSize: 18.0,
                                                    ),
                                                  ),
                                                  const Text(
                                                    'Place an order from your \nwatchlist',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      /*fontWeight: FontWeight.w400,*/
                                                      color: Colors.grey,
                                                      fontSize: 14.0,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.only(
                                            left: 20.0,
                                            right: 20.0,
                                            top: 15.0,
                                            bottom: 15.0),
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .9,
                                        alignment: Alignment.center,
                                        margin: const EdgeInsets.only(
                                            left: 20.0, right: 20.0),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(5.0)),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                              spreadRadius: 5,
                                              blurRadius: 7,
                                              offset: const Offset(0,
                                                  3), // changes position of shadow
                                            ),
                                          ],
                                        ),
                                        child: const Text(
                                          'No Positions',
                                          style: TextStyle(
                                              fontSize: 16.0,
                                              /*fontWeight: FontWeight.w500,*/
                                              color: Colors.grey),
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ))
        ],
      ),
    ));
  }

  Future<void> _refresh1() async {
    await Future<void>.delayed(const Duration(seconds: 3))
        .then((value) => _refreshController1.refreshCompleted());
  }

  Future<void> _refresh2() async {
    await Future<void>.delayed(const Duration(seconds: 3))
        .then((value) => _refreshController2.refreshCompleted());
  }
}
