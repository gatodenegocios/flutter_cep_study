import 'package:flutter/material.dart';
import 'package:flutter_cep_study/features/adress_by_cep/domain/entities/address.dart';
import 'package:google_fonts/google_fonts.dart';

class AddressDisplay extends StatelessWidget {
  const AddressDisplay({Key? key, required this.address}) : super(key: key);

  final Address address;

  Widget _getRow(String title, String content) {
    return Row(
      children: [
        Text("$title:", style: GoogleFonts.lato(fontSize: 20, fontWeight: FontWeight.bold),),
        SizedBox(width: 10),
        Text("$content",style: GoogleFonts.lato(fontSize: 17),),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      _getRow("Cep", address.cep),
      _getRow("State", address.state),
      _getRow("City", address.city),
      _getRow("Neighborhood", address.neighborhood),
      _getRow("Street", address.street),
    ]);
  }
}
