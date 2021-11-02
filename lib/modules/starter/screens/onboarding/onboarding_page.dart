import 'package:flutter/material.dart';
import 'package:mogawe/core/flutter_flow/flutter_flow_theme.dart';
import 'package:mogawe/core/flutter_flow/flutter_flow_widgets.dart';
import 'package:mogawe/modules/auth/screens/login/login_page.dart';
import 'package:mogawe/modules/auth/screens/registration/registration_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingPage extends StatefulWidget {
  OnboardingPage({Key? key}) : super(key: key);

  @override
  _OnboardingPageState createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  PageController? pageViewController;
  bool _loadingButton1 = false;
  bool _loadingButton2 = false;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Color(0xFFF5F5F5),
      body: Stack(
        children: [
          Align(
            alignment: AlignmentDirectional(0, 0),
            child: Container(
              width: double.infinity,
              height: double.infinity,
              child: Stack(
                children: [
                  PageView(
                    controller: pageViewController ??=
                        PageController(initialPage: 0),
                    scrollDirection: Axis.horizontal,
                    children: [
                      Stack(
                        children: [
                          Image.asset(
                            'assets/images/onboarding_1.jpg',
                            width: double.infinity,
                            height: double.infinity,
                            fit: BoxFit.cover,
                          ),
                          Container(
                            width: double.infinity,
                            height: double.infinity,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Color(0x00FFFFFF),
                                  FlutterFlowTheme.primaryColor
                                ],
                                stops: [0.3, 1],
                                begin: AlignmentDirectional(0, -1),
                                end: AlignmentDirectional(0, 1),
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(32, 32, 32, 96),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  'Tunjukkan keahlianmu dan dapatkan hire_me dengan mudah',
                                  style: FlutterFlowTheme.title1.override(
                                    fontFamily: 'Poppins',
                                    color: FlutterFlowTheme.secondaryColor,
                                    fontSize: 28,
                                    fontWeight: FontWeight.w600,
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                      Stack(
                        children: [
                          Image.asset(
                            'assets/images/im_onboarding_2.png',
                            width: double.infinity,
                            height: double.infinity,
                            fit: BoxFit.cover,
                          ),
                          Container(
                            width: double.infinity,
                            height: double.infinity,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Color(0x00EA2327),
                                  FlutterFlowTheme.primaryColor
                                ],
                                stops: [0.3, 1],
                                begin: AlignmentDirectional(0, -1),
                                end: AlignmentDirectional(0, 1),
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(32, 32, 32, 96),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'Dapatkan penawaran kerja yang sesuai dengan keahlian',
                                  style: FlutterFlowTheme.title1.override(
                                    fontFamily: 'Poppins',
                                    color: FlutterFlowTheme.secondaryColor,
                                    fontSize: 28,
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                      Stack(
                        children: [
                          Image.asset(
                            'assets/images/im_onboarding_3.png',
                            width: double.infinity,
                            height: double.infinity,
                            fit: BoxFit.cover,
                          ),
                          Container(
                            width: double.infinity,
                            height: double.infinity,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Color(0x00EA2327),
                                  FlutterFlowTheme.primaryColor
                                ],
                                stops: [0.3, 1],
                                begin: AlignmentDirectional(0, -1),
                                end: AlignmentDirectional(0, 1),
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(32, 32, 32, 96),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'Terima uang setelah kerjaan berhasil dikirim',
                                  style: FlutterFlowTheme.title1.override(
                                    fontFamily: 'Poppins',
                                    color: FlutterFlowTheme.secondaryColor,
                                    fontSize: 28,
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                      Stack(
                        children: [
                          Image.asset(
                            'assets/images/onboarding_4.jpg',
                            width: double.infinity,
                            height: double.infinity,
                            fit: BoxFit.cover,
                          ),
                          Container(
                            width: double.infinity,
                            height: double.infinity,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Color(0x00FFFFFF),
                                  FlutterFlowTheme.secondaryColor
                                ],
                                stops: [0.2, 1],
                                begin: AlignmentDirectional(0, -1),
                                end: AlignmentDirectional(0, 1),
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(32, 32, 32, 96),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Siap Gawe,\nSiap Gajian!',
                                  style: FlutterFlowTheme.title1.override(
                                    fontFamily: 'Poppins',
                                    fontSize: 32,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 24, 0, 0),
                                  child: FFButtonWidget(
                                    onPressed: () async {
                                      setState(() => _loadingButton1 = true);
                                      try {
                                        await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => LoginPage(),
                                          ),
                                        );
                                      } finally {
                                        setState(() => _loadingButton1 = false);
                                      }
                                    },
                                    text: 'Masuk',
                                    options: FFButtonOptions(
                                      width: double.infinity,
                                      height: 48,
                                      color: FlutterFlowTheme.primaryColor,
                                      textStyle:
                                          FlutterFlowTheme.subtitle2.override(
                                        fontFamily: 'Poppins',
                                        color: Colors.white,
                                      ),
                                      borderSide: BorderSide(
                                        color: Colors.transparent,
                                        width: 1,
                                      ),
                                      borderRadius: 12,
                                    ),
                                    loading: _loadingButton1,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 16, 0, 0),
                                  child: FFButtonWidget(
                                    onPressed: () async {
                                      setState(() => _loadingButton2 = true);
                                      try {
                                        await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                RegistrationScreen(),
                                          ),
                                        );
                                      } finally {
                                        setState(() => _loadingButton2 = false);
                                      }
                                    },
                                    text: 'Daftar',
                                    options: FFButtonOptions(
                                      width: double.infinity,
                                      height: 48,
                                      color: FlutterFlowTheme.secondaryColor,
                                      textStyle:
                                          FlutterFlowTheme.subtitle2.override(
                                        fontFamily: 'Poppins',
                                        color: FlutterFlowTheme.primaryColor,
                                      ),
                                      borderSide: BorderSide(
                                        color: FlutterFlowTheme.primaryColor,
                                        width: 1,
                                      ),
                                      borderRadius: 12,
                                    ),
                                    loading: _loadingButton2,
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                  Align(
                    alignment: AlignmentDirectional(0, 1),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 32),
                      child: SmoothPageIndicator(
                        controller: pageViewController ??=
                            PageController(initialPage: 0),
                        count: 4,
                        axisDirection: Axis.horizontal,
                        onDotClicked: (i) {
                          pageViewController!.animateToPage(
                            i,
                            duration: Duration(milliseconds: 500),
                            curve: Curves.ease,
                          );
                        },
                        effect: ExpandingDotsEffect(
                          expansionFactor: 2,
                          spacing: 8,
                          radius: 16,
                          dotWidth: 16,
                          dotHeight: 16,
                          dotColor: Color(0x94FFFFFF),
                          activeDotColor: FlutterFlowTheme.secondaryColor,
                          paintStyle: PaintingStyle.fill,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
