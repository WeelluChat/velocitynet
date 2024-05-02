import 'package:brasil_fields/brasil_fields.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class MountYourCard extends StatefulWidget {
  const MountYourCard({super.key});

  @override
  State<MountYourCard> createState() => _MountYourCardState();
}

class _MountYourCardState extends State<MountYourCard> {
  bool isCheckedMax = false;
  bool isCheckedTelecine = false;
  bool isCheckedPremiere = false;
  bool isCheckedDeezer = false;
  final List<String> items = [
    'Plano Residencial',
    'Plano Empresarial',
    // 'Plano Dedicado'
  ];
  String? selectedValuePlano;
  final List<String> itemsMb = [
    '500 MB',
    '600 MB',
    '700 MB',
    '900 MB',
    '1000 MB',
  ];
  String? selectedValueMb;

  int _contador = 0;

  void _incrementCounter() {
    setState(() {
      _contador++;
    });
  }

  void _decrementCounter() {
    setState(() {
      if (_contador > 0) {
        _contador--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'ESCOLHER OPÇÕES',
          style: GoogleFonts.getFont('Poppins', fontWeight: FontWeight.w600),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          padding: const EdgeInsets.all(20),
          width: 300,
          height: 610,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: const Color(0xff002C5C))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Escolha seu plano',
                style: GoogleFonts.getFont(
                  'Poppins',
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              DropdownButtonHideUnderline(
                child: DropdownButton2<String>(
                  isExpanded: true,
                  hint: const Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Plano Residencial',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  items: items
                      .map((String item) => DropdownMenuItem<String>(
                            value: item,
                            child: Text(
                              item,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ))
                      .toList(),
                  value: selectedValuePlano,
                  onChanged: (String? value) {
                    setState(() {
                      selectedValuePlano = value;
                    });
                  },
                  buttonStyleData: ButtonStyleData(
                      height: 40,
                      width: 300,
                      padding: const EdgeInsets.only(left: 14, right: 14),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: const Color(0xffD9D9D9),
                      ),
                      elevation: 1),
                  iconStyleData: const IconStyleData(
                    icon: Icon(
                      Icons.expand_more_outlined,
                      size: 30,
                    ),
                    iconSize: 14,
                    iconEnabledColor: Colors.black,
                    iconDisabledColor: Colors.grey,
                  ),
                  dropdownStyleData: DropdownStyleData(
                    maxHeight: 200,
                    width: 250,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.grey[200]),
                    offset: const Offset(-20, 0),
                    scrollbarTheme: ScrollbarThemeData(
                      radius: const Radius.circular(40),
                      thickness: MaterialStateProperty.all<double>(6),
                      thumbVisibility: MaterialStateProperty.all<bool>(true),
                    ),
                  ),
                  menuItemStyleData: const MenuItemStyleData(
                    height: 40,
                    padding: EdgeInsets.only(left: 14, right: 14),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              DropdownButtonHideUnderline(
                child: DropdownButton2<String>(
                  isExpanded: true,
                  hint: const Row(
                    children: [
                      Expanded(
                        child: Text(
                          '500 MB',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  items: itemsMb
                      .map((String item) => DropdownMenuItem<String>(
                            value: item,
                            child: Text(
                              item,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ))
                      .toList(),
                  value: selectedValueMb,
                  onChanged: (String? value) {
                    setState(() {
                      selectedValueMb = value;
                    });
                  },
                  buttonStyleData: ButtonStyleData(
                    height: 40,
                    width: 300,
                    padding: const EdgeInsets.only(left: 14, right: 14),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: const Color(0xffD9D9D9),
                    ),
                    elevation: 1,
                  ),
                  iconStyleData: const IconStyleData(
                    icon: Icon(
                      Icons.expand_more_outlined,
                      size: 30,
                    ),
                    iconSize: 14,
                    iconEnabledColor: Colors.black,
                    iconDisabledColor: Colors.grey,
                  ),
                  dropdownStyleData: DropdownStyleData(
                    maxHeight: 200,
                    width: 250,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.grey[200],
                    ),
                    offset: const Offset(-20, 0),
                    scrollbarTheme: ScrollbarThemeData(
                      radius: const Radius.circular(40),
                      thickness: MaterialStateProperty.all<double>(6),
                      thumbVisibility: MaterialStateProperty.all<bool>(true),
                    ),
                  ),
                  menuItemStyleData: const MenuItemStyleData(
                    height: 40,
                    padding: EdgeInsets.only(left: 14, right: 14),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Opções Adicionais',
                style: GoogleFonts.getFont(
                  'Poppins',
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Checkbox(
                      activeColor: Colors.black,
                      value: isCheckedMax,
                      onChanged: (bool? value) {
                        setState(() {
                          isCheckedMax = value!;
                        });
                      }),
                  Text(
                    'Max',
                    style: GoogleFonts.getFont(
                      'Poppins',
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Checkbox(
                      activeColor: Colors.black,
                      value: isCheckedTelecine,
                      onChanged: (bool? value) {
                        setState(() {
                          isCheckedTelecine = value!;
                        });
                      }),
                  Text(
                    'Telecine',
                    style: GoogleFonts.getFont(
                      'Poppins',
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Checkbox(
                      activeColor: Colors.black,
                      value: isCheckedDeezer,
                      onChanged: (bool? value) {
                        setState(() {
                          isCheckedDeezer = value!;
                        });
                      }),
                  Text(
                    'Deezer',
                    style: GoogleFonts.getFont(
                      'Poppins',
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Checkbox(
                      activeColor: Colors.black,
                      value: isCheckedPremiere,
                      onChanged: (bool? value) {
                        setState(() {
                          isCheckedPremiere = value!;
                        });
                      }),
                  Text(
                    'Premiere',
                    style: GoogleFonts.getFont(
                      'Poppins',
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Repetidor/Roteador Adicional',
                style: GoogleFonts.getFont(
                  'Poppins',
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: const Color(0xffd9d9d9),
                        borderRadius: BorderRadius.circular(50)),
                    child: IconButton(
                        onPressed: _decrementCounter,
                        icon: const Icon(Icons.remove)),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    '$_contador',
                    style: GoogleFonts.getFont(
                      'Poppins',
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: const Color(0xffd9d9d9),
                        borderRadius: BorderRadius.circular(50)),
                    child: IconButton(
                        onPressed: _incrementCounter,
                        icon: const Icon(Icons.add)),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Nome Completo',
                style: GoogleFonts.getFont(
                  'Poppins',
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                width: 300,
                height: 40,
                decoration: BoxDecoration(
                  color: const Color(0xffD9D9D9),
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                    color: const Color.fromARGB(255, 197, 197, 197),
                  ),
                ),
                child: TextFormField(
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    contentPadding:
                        EdgeInsets.only(bottom: 15, left: 10, right: 10),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Telefone para contato',
                style: GoogleFonts.getFont(
                  'Poppins',
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                width: 300,
                height: 40,
                decoration: BoxDecoration(
                  color: const Color(0xffD9D9D9),
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                    color: const Color.fromARGB(255, 197, 197, 197),
                  ),
                ),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    TelefoneInputFormatter()
                  ],
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    contentPadding:
                        EdgeInsets.only(bottom: 15, left: 10, right: 10),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: 300,
                height: 40,
                child: ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    backgroundColor:
                        MaterialStateProperty.all(const Color(0xffFFB000)),
                  ),
                  onPressed: () {},
                  child: Text(
                    'ENVIAR MENSAGEM',
                    style: GoogleFonts.getFont('Poppins',
                        color: const Color(0xff13294E),
                        fontWeight: FontWeight.w600),
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
