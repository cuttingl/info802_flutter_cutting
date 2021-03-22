import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;

Future<double> getFromSoap(int weight, int price) async {
  var envelope = '''
  <?xml version="1.0" encoding="utf-8"?>
  <soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
    <soap:Body>
      <calDelivFee xmlns="https://info802-soap.herokuapp.com/delivfeecalculator?wsdl">
          <weight>$weight</weight>
          <price>$price</price>
        </calDelivFee>
    </soap:Body>
  </soap:Envelope>
  ''';

  Uri uriPost = Uri.parse("https://info802-soap.herokuapp.com/delivfeecalculator?wsdl");
  http.Response response =
      await http.post(uriPost, headers: {'Content-Type': 'text/xml; charset=utf-8', 'SOAPAction': 'calDelivFee'}, body: envelope);
  var rawXmlResponse = response.body;
  xml.XmlDocument parsedXml = xml.parse(rawXmlResponse);
  var fraisText = parsedXml.findAllElements('tns:delivfee').map((node) => node.text).first;
  var frais = double.tryParse(fraisText);
  return frais;
}

main() async {
  double frais = await getFromSoap(10, 20);
  print(frais);
}
