import 'package:fliproadmin/core/utilities/app_colors.dart';
import 'package:fliproadmin/core/view_model/auth_provider/auth_provider.dart';
import 'package:fliproadmin/ui/widget/main_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:flutter/services.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';

class ForgotPasswordOtpScreen extends StatefulWidget {
  const ForgotPasswordOtpScreen({Key? key, required}) : super(key: key);

  static const routeName = '/ForgotPasswordOtpScreen';

  @override
  State<ForgotPasswordOtpScreen> createState() =>
      _ForgotPasswordOtpScreenState();
}

class _ForgotPasswordOtpScreenState extends State<ForgotPasswordOtpScreen> {
  TextEditingController otpController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  int endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 60;
  late CountdownTimerController controller;
  bool resend = false;

  @override
  void initState() {
    super.initState();
    if (mounted) {
      controller = CountdownTimerController(
          endTime: endTime,
          onEnd: () {
            setState(() {
              resend = true;
            });
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final verificationData = ModalRoute.of(context)!.settings.arguments as Map;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Account Verification"),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ListView(
            children: <Widget>[
              SizedBox(
                height: 10.h,
              ),
              SizedBox(
                height: 5.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      'An 6-digit code has been sent to ${verificationData['email']}',
                      style: Theme.of(context).textTheme.bodyText1,
                      maxLines: 2,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 5.h,
              ),
              Form(
                key: _formKey,
                child: PinCodeTextField(
                  length: 6,
                  appContext: context,
                  validator: (e) {
                    if (e!.length == 6 && GetUtils.isNum(e)) {
                      return null;
                    } else {
                      return "Please write OTP";
                    }
                  },
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  obscureText: false,
                  keyboardType: TextInputType.number,
                  autoDisposeControllers: false,
                  textStyle: const TextStyle(color: Colors.white),
                  animationType: AnimationType.fade,
                  pinTheme: PinTheme(
                    inactiveFillColor: AppColors.mainThemeBlue,
                      inactiveColor:AppColors.mainThemeBlue ,
                      shape: PinCodeFieldShape.box,
                      activeColor: Colors.white,
                      selectedFillColor: Colors.white,
                      selectedColor: AppColors.mainThemeBlue,
                      borderRadius: BorderRadius.circular(8),
                      fieldHeight: 50,
                      fieldWidth: 40,
                      activeFillColor: AppColors.mainThemeBlue),
                  animationDuration: const Duration(milliseconds: 300),

                  enableActiveFill: true,
                  // errorAnimationController: errorController,
                  controller: otpController,
                  onCompleted: (v) {},
                  onChanged: (_) {},
                  beforeTextPaste: (text) {
                    print("Allowing to paste $text");
                    //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                    //but you can show anything you want here, like your pop up saying wrong paste format or etc
                    return true;
                  },
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: CountdownTimer(
                      controller: controller,
                      onEnd: () {},
                      endTime: endTime,
                      widgetBuilder: (_, CurrentRemainingTime? time) {
                        if (time == null) {
                          //return Text('0', style: TextStyle(fontSize: 16, color: Color(0xFFCC9821),));

                          return Container();
                        }
                        return Text(
                          'Resend again in ${time.sec} Sec',
                        );
                      },
                    ),
                  ),
                  MaterialButton(
                    onPressed: authProvider.getLoadingState ==
                            LoadingState.loading
                        ? null
                        : resend
                            ? () {
                                authProvider.forgotPasswordOtpConfirmation(
                                    email: verificationData['email'],
                                    otp: otpController.text.trim(),
                                    doNavigation: false);
                                setState(() {
                                  resend = false;
                                  endTime =
                                      DateTime.now().millisecondsSinceEpoch +
                                          const Duration(seconds: 60)
                                              .inMilliseconds;
                                  controller = CountdownTimerController(
                                      endTime: endTime,
                                      onEnd: () {
                                        setState(() {
                                          resend = true;
                                        });
                                      });
                                  controller.start();
                                });
                              }
                            : () {},
                    color:
                        resend ? AppColors.mainThemeBlue : AppColors.lightGrey,
                    child: Text(
                      "Resend",
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          color: resend ? Colors.white : Colors.black),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                height: 5.h,
              ),
              MainButton(
                buttonText: "Verify",
                height: 7.h,
                userArrow: false,
                width: 14.w,
                isloading: authProvider.getLoadingState == LoadingState.loading,
                callback: () {
                  if (_formKey.currentState!.validate()) {
                    authProvider.forgotPasswordOtpConfirmation(
                        email: verificationData['email'],
                        otp: otpController.text.trim(),
                        doNavigation: true);
                  }
                },
              )
            ],
          )),
    );
  }

  @override
  void dispose() {
    otpController.dispose();
    controller.dispose();
    super.dispose();
  }
}
