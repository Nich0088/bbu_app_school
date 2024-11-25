import 'package:url_launcher/url_launcher.dart';

void openUrl(String url) async {
  final Uri webUri = Uri.parse(url);
  await launchUrl(
    webUri,
  );
}

void dialPhoneNumber(String phoneNumber) async {
  final Uri phoneUri = Uri(scheme: 'tel', path: phoneNumber);
  if (await canLaunchUrl(phoneUri)) {
    await launchUrl(phoneUri);
  }
}
