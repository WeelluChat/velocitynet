import 'package:url_launcher/url_launcher.dart';

class Url {
  Future<void> urlWhatsApp() async {
    await launchUrl(
      Uri.parse(
          "https://api.whatsapp.com/send?phone=+559499132-6169&text=Óla tudo bem ?"),
    );
  }

  Future<void> urlCentralAssinante() async {
    await launchUrl(
      Uri.parse(
          "https://sistema.velocitynet.com.br/central_assinante_web/login"),
    );
  }

  Future<void> urlSpeedTest() async {
    await launchUrl(
      Uri.parse("https://www.speedtest.net/pt"),
    );
  }

  Future<void> urlInstagram() async {
    await launchUrl(
      Uri.parse("https://www.instagram.com/velocitynet_oficial/"),
    );
  }

  Future<void> urlFacebook() async {
    await launchUrl(
      Uri.parse("https://www.facebook.com/velocitynettelecom"),
    );
  }

  Future<void> urlMaps() async {
    await launchUrl(
      Uri.parse("https://maps.app.goo.gl/AYWLVsUVsNWPtz2E6"),
    );
  }
}
