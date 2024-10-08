import 'package:url_launcher/url_launcher.dart';

Future<void> openTelegram() async {
  const telegramUrl = 'tg://resolve?domain=hoseinTahan';
  if (await canLaunch(telegramUrl)) {
    await launch(telegramUrl);
  } else {
    const fallbackUrl = 'https://t.me/hoseinTahan';
    if (await canLaunch(fallbackUrl)) {
      await launch(fallbackUrl);
    }
  }
}
