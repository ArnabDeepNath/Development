import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'home_page_model.dart';
export 'home_page_model.dart';

class HomePageWidget extends StatefulWidget {
  const HomePageWidget({Key? key}) : super(key: key);

  @override
  _HomePageWidgetState createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget>
    with TickerProviderStateMixin {
  late HomePageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = {
    'textOnPageLoadAnimation': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        MoveEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 600.ms,
          begin: Offset(60, 0),
          end: Offset(0, 0),
        ),
      ],
    ),
  };

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HomePageModel());
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (isiOS) {
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          statusBarBrightness: Theme.of(context).brightness,
          systemStatusBarContrastEnforced: true,
        ),
      );
    }

    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: Stack(
          children: [
            Stack(
              alignment: AlignmentDirectional(0, -1),
              children: [
                Align(
                  alignment: AlignmentDirectional(0.05, -1.00),
                  child: Image.network(
                    'https://images.unsplash.com/photo-1516483638261-f4dbaf036963?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1286&q=80',
                    width: double.infinity,
                    height: 500,
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 500,
                  decoration: BoxDecoration(
                    color: Color(0x8D090F13),
                  ),
                ),
                SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 320, 0, 0),
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color:
                                FlutterFlowTheme.of(context).primaryBackground,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(0),
                              bottomRight: Radius.circular(0),
                              topLeft: Radius.circular(16),
                              topRight: Radius.circular(16),
                            ),
                          ),
                          child: Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 8, 0, 16),
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Divider(
                                    height: 4,
                                    thickness: 4,
                                    indent: 140,
                                    endIndent: 140,
                                    color: Color(0xFFE0E3E7),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        16, 16, 16, 0),
                                    child: InkWell(
                                      splashColor: Colors.transparent,
                                      focusColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () async {
                                        // final selectedFiles = await selectFiles(
                                        //   allowedExtensions: ['pdf'],
                                        //   multiFile: false,
                                        // );
                                        // if (selectedFiles != null) {
                                        //   setState(() =>
                                        //       _model.isDataUploading = true);
                                        //   var selectedUploadedFiles =
                                        //       <FFUploadedFile>[];

                                        //   try {
                                        //     selectedUploadedFiles =
                                        //         selectedFiles
                                        //             .map((m) => FFUploadedFile(
                                        //                   name: m.storagePath
                                        //                       .split('/')
                                        //                       .last,
                                        //                   bytes: m.bytes,
                                        //                 ))
                                        //             .toList();
                                        //   } finally {
                                        //     _model.isDataUploading = false;
                                        //   }
                                        //   if (selectedUploadedFiles.length ==
                                        //       selectedFiles.length) {
                                        //     setState(() {
                                        //       _model.uploadedLocalFile =
                                        //           selectedUploadedFiles.first;
                                        //     });
                                        //   } else {
                                        //     setState(() {});
                                        //     return;
                                        //   }
                                        // }
                                      },
                                      child: Text(
                                        'Highest Rated',
                                        style: FlutterFlowTheme.of(context)
                                            .headlineMedium,
                                      ),
                                    ),
                                  ),
                                  // StreamBuilder<List<HouseDetailsRecord>>(
                                  //   stream: queryHouseDetailsRecord(),
                                  //   builder: (context, snapshot) {
                                  //     // Customize what your widget looks like when it's loading.
                                  //     if (!snapshot.hasData) {
                                  //       return Center(
                                  //         child: SizedBox(
                                  //           width: 50,
                                  //           height: 50,
                                  //           child: CircularProgressIndicator(
                                  //             valueColor:
                                  //                 AlwaysStoppedAnimation<Color>(
                                  //               FlutterFlowTheme.of(context)
                                  //                   .primary,
                                  //             ),
                                  //           ),
                                  //         ),
                                  //       );
                                  //     }
                                  //     List<HouseDetailsRecord>
                                  //         listViewHouseDetailsRecordList =
                                  //         snapshot.data!;
                                  //     return ListView.builder(
                                  //       padding: EdgeInsets.zero,
                                  //       shrinkWrap: true,
                                  //       scrollDirection: Axis.vertical,
                                  //       itemCount:
                                  //           listViewHouseDetailsRecordList
                                  //               .length,
                                  //       itemBuilder: (context, listViewIndex) {
                                  //         final listViewHouseDetailsRecord =
                                  //             listViewHouseDetailsRecordList[
                                  //                 listViewIndex];
                                  //         return Padding(
                                  //           padding:
                                  //               EdgeInsetsDirectional.fromSTEB(
                                  //                   16, 8, 16, 8),
                                  //           child: Container(
                                  //             width: 330,
                                  //             decoration: BoxDecoration(
                                  //               color: Colors.white,
                                  //               boxShadow: [
                                  //                 BoxShadow(
                                  //                   blurRadius: 8,
                                  //                   color: Color(0x230F1113),
                                  //                   offset: Offset(0, 4),
                                  //                 )
                                  //               ],
                                  //               borderRadius:
                                  //                   BorderRadius.circular(12),
                                  //               border: Border.all(
                                  //                 color: Color(0xFFF1F4F8),
                                  //                 width: 1,
                                  //               ),
                                  //             ),
                                  //             child: Column(
                                  //               mainAxisSize: MainAxisSize.max,
                                  //               children: [
                                  //                 Hero(
                                  //                   tag:
                                  //                       listViewHouseDetailsRecord
                                  //                           .image,
                                  //                   transitionOnUserGestures:
                                  //                       true,
                                  //                   child: ClipRRect(
                                  //                     borderRadius:
                                  //                         BorderRadius.only(
                                  //                       bottomLeft:
                                  //                           Radius.circular(0),
                                  //                       bottomRight:
                                  //                           Radius.circular(0),
                                  //                       topLeft:
                                  //                           Radius.circular(12),
                                  //                       topRight:
                                  //                           Radius.circular(12),
                                  //                     ),
                                  //                     child: Image.network(
                                  //                       listViewHouseDetailsRecord
                                  //                           .image,
                                  //                       width: double.infinity,
                                  //                       height: 200,
                                  //                       fit: BoxFit.cover,
                                  //                     ),
                                  //                   ),
                                  //                 ),
                                  //                 Padding(
                                  //                   padding:
                                  //                       EdgeInsetsDirectional
                                  //                           .fromSTEB(
                                  //                               16, 12, 16, 12),
                                  //                   child: Row(
                                  //                     mainAxisSize:
                                  //                         MainAxisSize.max,
                                  //                     mainAxisAlignment:
                                  //                         MainAxisAlignment
                                  //                             .spaceBetween,
                                  //                     children: [
                                  //                       Expanded(
                                  //                         child: Column(
                                  //                           mainAxisSize:
                                  //                               MainAxisSize
                                  //                                   .max,
                                  //                           crossAxisAlignment:
                                  //                               CrossAxisAlignment
                                  //                                   .start,
                                  //                           children: [
                                  //                             Text(
                                  //                               listViewHouseDetailsRecord
                                  //                                   .homeName,
                                  //                               style: FlutterFlowTheme.of(
                                  //                                       context)
                                  //                                   .bodyLarge
                                  //                                   .override(
                                  //                                     fontFamily:
                                  //                                         'Plus Jakarta Sans',
                                  //                                     color: Color(
                                  //                                         0xFF14181B),
                                  //                                     fontSize:
                                  //                                         16,
                                  //                                     fontWeight:
                                  //                                         FontWeight
                                  //                                             .normal,
                                  //                                   ),
                                  //                             ),
                                  //                             Padding(
                                  //                               padding:
                                  //                                   EdgeInsetsDirectional
                                  //                                       .fromSTEB(
                                  //                                           0,
                                  //                                           8,
                                  //                                           0,
                                  //                                           0),
                                  //                               child: Row(
                                  //                                 mainAxisSize:
                                  //                                     MainAxisSize
                                  //                                         .max,
                                  //                                 children: [
                                  //                                   RatingBarIndicator(
                                  //                                     itemBuilder:
                                  //                                         (context, index) =>
                                  //                                             Icon(
                                  //                                       Icons
                                  //                                           .radio_button_checked_rounded,
                                  //                                       color: Color(
                                  //                                           0xFF14181B),
                                  //                                     ),
                                  //                                     direction:
                                  //                                         Axis.horizontal,
                                  //                                     rating: listViewHouseDetailsRecord
                                  //                                         .rating,
                                  //                                     unratedColor:
                                  //                                         Color(
                                  //                                             0xFF57636C),
                                  //                                     itemCount:
                                  //                                         5,
                                  //                                     itemSize:
                                  //                                         16,
                                  //                                   ),
                                  //                                   Padding(
                                  //                                     padding: EdgeInsetsDirectional
                                  //                                         .fromSTEB(
                                  //                                             8,
                                  //                                             0,
                                  //                                             0,
                                  //                                             0),
                                  //                                     child:
                                  //                                         Text(
                                  //                                       listViewHouseDetailsRecord
                                  //                                           .rating
                                  //                                           .toString(),
                                  //                                       style: FlutterFlowTheme.of(context)
                                  //                                           .bodySmall
                                  //                                           .override(
                                  //                                             fontFamily: 'Plus Jakarta Sans',
                                  //                                             color: Color(0xFF14181B),
                                  //                                             fontSize: 12,
                                  //                                             fontWeight: FontWeight.normal,
                                  //                                           ),
                                  //                                     ),
                                  //                                   ),
                                  //                                 ],
                                  //                               ),
                                  //                             ),
                                  //                           ],
                                  //                         ),
                                  //                       ),
                                  //                       Container(
                                  //                         height: 32,
                                  //                         decoration:
                                  //                             BoxDecoration(
                                  //                           color: Color(
                                  //                               0xFF14181B),
                                  //                           borderRadius:
                                  //                               BorderRadius
                                  //                                   .circular(
                                  //                                       12),
                                  //                         ),
                                  //                         alignment:
                                  //                             AlignmentDirectional(
                                  //                                 0.00, 0.00),
                                  //                         child: Padding(
                                  //                           padding:
                                  //                               EdgeInsetsDirectional
                                  //                                   .fromSTEB(
                                  //                                       8,
                                  //                                       0,
                                  //                                       8,
                                  //                                       0),
                                  //                           child: Text(
                                  //                             'Rs.${listViewHouseDetailsRecord.price.toString()}',
                                  //                             style: FlutterFlowTheme
                                  //                                     .of(context)
                                  //                                 .bodyMedium
                                  //                                 .override(
                                  //                                   fontFamily:
                                  //                                       'Plus Jakarta Sans',
                                  //                                   color: Colors
                                  //                                       .white,
                                  //                                   fontSize:
                                  //                                       14,
                                  //                                   fontWeight:
                                  //                                       FontWeight
                                  //                                           .normal,
                                  //                                 ),
                                  //                           ),
                                  //                         ),
                                  //                       ),
                                  //                     ],
                                  //                   ),
                                  //                 ),
                                  //               ],
                                  //             ),
                                  //           ),
                                  //         );
                                  //       },
                                  //     );
                                  //   },
                                  // ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 40, 0, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Flexible(
                            child: Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 0, 10, 0),
                              child: InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  context.pushNamed('ContactsPage');
                                },
                                child: Icon(
                                  Icons.person_2,
                                  color: FlutterFlowTheme.of(context)
                                      .primaryBackground,
                                  size: 32,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(16, 24, 16, 24),
                      child: Text(
                        'Explore top destinations around the world. ',
                        style: FlutterFlowTheme.of(context)
                            .displaySmall
                            .override(
                              fontFamily: 'Outfit',
                              color:
                                  FlutterFlowTheme.of(context).primaryBtnText,
                            ),
                      ).animateOnPageLoad(
                          animationsMap['textOnPageLoadAnimation']!),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
