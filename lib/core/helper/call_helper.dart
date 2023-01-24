import 'package:url_launcher/url_launcher.dart';

launchCaller(String contactNumber) async {
  String url = "tel:$contactNumber";
  if (await canLaunchUrl(Uri.parse(url))) {
    await launchUrl((Uri.parse(url)));
  } else {
    throw 'Could not launch $url';
  }
}
