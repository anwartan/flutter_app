
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:http/io_client.dart';
import 'package:http/src/response.dart';

class CustomIOClient extends IOClient {

  Future<SecurityContext> get globalContext async {
    final sslCert = await rootBundle.load('certificates/certificated.cer');
    SecurityContext securityContext = SecurityContext(withTrustedRoots: false);
    securityContext.setTrustedCertificatesBytes(sslCert.buffer.asInt8List());
    return securityContext;
  }

  @override
  Future<Response> get(Uri url, {Map<String, String>? headers}) async {
    HttpClient client = HttpClient(context: await globalContext);
    client.badCertificateCallback =
        (X509Certificate cert, String host, int port) => false;
    IOClient ioClient = IOClient(client);
    
    return ioClient.get(url);
  }
}