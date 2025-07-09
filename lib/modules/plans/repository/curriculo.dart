import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:velocity_net/modules/appbar/app_bar_component.dart';
import 'package:velocity_net/modules/appbar/app_bar_component_resize.dart';
import 'package:velocity_net/modules/endDrawer/end_drawer.dart';
import 'package:velocity_net/modules/footer/footer.dart';

class TrabalheConosco extends StatefulWidget {
  const TrabalheConosco({super.key});

  @override
  _TrabalheConoscoState createState() => _TrabalheConoscoState();
}

class _TrabalheConoscoState extends State<TrabalheConosco> {
  String? _fileName;
  PlatformFile? _pickedFile;
  bool _isLoading = false;
  String? _selectedSector;
  bool mobile = false;
  final ScrollController scrollController = ScrollController();

  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _contesobrevoce = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  // Cores da Velocitynet
  final Color _primaryColor = const Color.fromARGB(255, 255, 255, 255);
  final Color _secondaryColor = const Color.fromARGB(255, 7, 32, 102);
  final Color _accentColor = const Color(0xFFF5A623);
  final Color _textColor = const Color.fromARGB(255, 7, 32, 102);
  final Color _lightBackground = const Color(0xFFF8F9FA);

  // Expressões regulares para validação
  final RegExp _emailRegExp = RegExp(
    r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
    caseSensitive: false,
    multiLine: false,
  );

  final RegExp _phoneRegExp = RegExp(
    r'^[0-9()+\-\s]+$',
  );

  // Lista de setores disponíveis
  final List<String> _sectors = [
    'Suporte Técnico',
    'Atendimento',
    'Financeiro',
    'Desenvolvimento',
    'Marketing',
    'Recursos Humanos',
    'Monitoramento de Ordem de Serviço',
    'Infraestrutura',
    'Noc',
    'Programação',
    'Marketing Empresarial',
    'Outros'
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    _nomeController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _contesobrevoce.dispose();
    super.dispose();
  }

  Future<void> EnviarDados() async {
    if (!_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Por favor, preencha todos os campos obrigatórios'),
          backgroundColor: _accentColor,
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('https://api.velocitynet.com.br/api/v1/send-email'), 
      );

      request.fields['to'] = 'rh.velocitynet@gmail.com'; 
      request.fields['subject'] = 'Novo Candidato - ${_nomeController.text}';
      
      request.fields['text'] = '''
        NOVO CANDIDATO VELOCITYNET

        Nome: ${_nomeController.text}
        Email: ${_emailController.text}
        Telefone: ${_phoneController.text}
        Setor de Interesse: ${_selectedSector ?? 'Não informado'}
        
        Sobre o candidato:
        ${_contesobrevoce.text}
      ''';

      if (_pickedFile != null) {
        if (kIsWeb) {
          final bytes = _pickedFile!.bytes;
          final file = http.MultipartFile.fromBytes(
            'anexo',
            bytes!,
            filename: _pickedFile!.name,
          );
          request.files.add(file);
        } else {
          final file = File(_pickedFile!.path!);
          final mimeTypeData = lookupMimeType(file.path)?.split('/');
          request.files.add(await http.MultipartFile.fromPath(
            'anexo',
            file.path,
            contentType: MediaType(mimeTypeData![0], mimeTypeData[1]),
            filename: _pickedFile!.name,
          ));
        }
      }

      final response = await request.send();

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Currículo enviado com sucesso!'),
            backgroundColor: _secondaryColor,
          ),
        );

        _nomeController.clear();
        _emailController.clear();
        _phoneController.clear();
        _contesobrevoce.clear();
        setState(() {
          _pickedFile = null;
          _fileName = null;
          _selectedSector = null;
        });
      } else {
        final responseBody = await response.stream.bytesToString();
        throw Exception('Erro ao enviar: ${response.statusCode} - $responseBody');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro ao enviar currículo: ${e.toString()}'),
          backgroundColor: _accentColor,
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _pickFile() async {
    setState(() {
      _isLoading = true;
    });

    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'doc', 'docx', 'jpg', 'png'],
        allowMultiple: false,
      );

      if (result != null) {
        setState(() {
          _pickedFile = result.files.first;
          _fileName = _pickedFile!.name;
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro ao selecionar arquivo: $e'),
          backgroundColor: _accentColor,
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  String? _validateNome(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, insira seu nome';
    }

    if (value.length < 3) {
      return 'Nome muito curto';
    }

    if (RegExp(r'[0-9!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
      return 'Nome não pode conter números ou caracteres especiais';
    }

    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, insira seu e-mail';
    }

    if (value.contains(RegExp(r'[!#$%^&*={}|<>?~]'))) {
      return 'Caracteres especiais não permitidos (@ e . são permitidos)';
    }

    if (!_emailRegExp.hasMatch(value)) {
      return 'Por favor, insira um e-mail válido';
    }
    return null;
  }

  String? _validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, insira seu telefone';
    }

    if (value.contains(RegExp(r'[a-zA-Z!@#$%^&*_={}|<>?~]'))) {
      return 'Apenas números, +, -, () e espaços são permitidos';
    }

    if (!_phoneRegExp.hasMatch(value)) {
      return 'Por favor, insira um telefone válido';
    }

    final digitsOnly = value.replaceAll(RegExp(r'[^0-9]'), '');
    if (digitsOnly.length < 10) {
      return 'Telefone deve ter pelo menos 10 dígitos';
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    mobile = MediaQuery.of(context).size.width > 1200 ? false : true;
    final bool isSmallMobile = MediaQuery.of(context).size.width < 600;
    final double cardWidth = isSmallMobile ? double.infinity : 600;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: mobile == true
            ? const Size.fromHeight(80)
            : const Size.fromHeight(140),
        child: Container(
          margin: mobile == true
              ? const EdgeInsets.only(top: 15)
              : const EdgeInsets.only(top: 0),
          child: (mobile == true)
              ? const AppBarComponentResize()
              : AppBarComponent(scrollController: scrollController),
        ),
      ),
      endDrawer: mobile
          ? EndDrawer(
              scrollController: scrollController,
            )
          : null,
      body: SingleChildScrollView(
        controller: scrollController,
        child: SizedBox(
          width: double.infinity,
          child: Flex(
            direction: Axis.vertical,
            children: [
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                Color(0xFF13294E),
                Colors.blue.shade900,

                  ])
                ),
                child: SafeArea(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Logo e Título
                        Column(
                          children: [
                            SizedBox(height: 80),
                            Text(
                              'FAÇA PARTE DO NOSSO TIME',
                              style: GoogleFonts.bebasNeue(
                                fontSize: isSmallMobile ? 28 : 36,
                                color: _primaryColor,
                                letterSpacing: 2,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              'Envie seu currículo e venha trabalhar conosco!',
                              style: GoogleFonts.poppins(
                                fontSize: isSmallMobile ? 14 : 16,
                                color: Colors.white,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: isSmallMobile ? 30 : 40),

                        // Formulário
                        Container(
                          width: isSmallMobile ? 360 : cardWidth,
                          child: Card(
                            elevation: 16,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            color: _lightBackground,
                            child: Padding(
                              padding: EdgeInsets.all(isSmallMobile ? 15 : 30),
                              child: Form(
                                key: _formKey,
                                child: Column(
                                  children: [
                                    TextFormField(
                                      controller: _nomeController,
                                      decoration: InputDecoration(
                                        labelText: 'Nome Completo',
                                        labelStyle:
                                            GoogleFonts.poppins(color: _textColor),
                                        prefixIcon: Icon(Icons.person,
                                            color: _secondaryColor),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                          borderSide:
                                              BorderSide(color: _secondaryColor),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                              color: _secondaryColor, width: 2),
                                        ),
                                        hintText: 'Digite seu nome completo',
                                        hintStyle: GoogleFonts.poppins(
                                            color: _textColor.withOpacity(0.5)),
                                        filled: true,
                                        fillColor: Colors.white,
                                      ),
                                      style: GoogleFonts.poppins(color: _textColor),
                                      validator: _validateNome,
                                      keyboardType: TextInputType.name,
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                    ),
                                    SizedBox(height: 20),

                                    // Campo E-mail
                                    TextFormField(
                                      controller: _emailController,
                                      decoration: InputDecoration(
                                        labelText: 'E-mail',
                                        labelStyle:
                                            GoogleFonts.poppins(color: _textColor),
                                        prefixIcon:
                                            Icon(Icons.email, color: _secondaryColor),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                          borderSide:
                                              BorderSide(color: _secondaryColor),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                              color: _secondaryColor, width: 2),
                                        ),
                                        hintText: 'exemplo@dominio.com',
                                        hintStyle: GoogleFonts.poppins(
                                            color: _textColor.withOpacity(0.5)),
                                        filled: true,
                                        fillColor: Colors.white,
                                      ),
                                      style: GoogleFonts.poppins(color: _textColor),
                                      validator: _validateEmail,
                                      keyboardType: TextInputType.emailAddress,
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                    ),
                                    SizedBox(height: 20),

                                    // Campo Telefone
                                    TextFormField(
                                      controller: _phoneController,
                                      decoration: InputDecoration(
                                        labelText: 'Telefone',
                                        labelStyle:
                                            GoogleFonts.poppins(color: _textColor),
                                        prefixIcon:
                                            Icon(Icons.phone, color: _secondaryColor),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                          borderSide:
                                              BorderSide(color: _secondaryColor),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                              color: _secondaryColor, width: 2),
                                        ),
                                        hintText: '(00) 00000-0000',
                                        hintStyle: GoogleFonts.poppins(
                                            color: _textColor.withOpacity(0.5)),
                                        filled: true,
                                        fillColor: Colors.white,
                                      ),
                                      style: GoogleFonts.poppins(color: _textColor),
                                      validator: _validatePhone,
                                      keyboardType: TextInputType.phone,
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.deny(
                                            RegExp(r'[a-zA-Z!@#$%^&*_={}|<>?~]')),
                                      ],
                                    ),
                                    SizedBox(height: 20),

                                    // Campo Sobre Você
                                    TextFormField(
                                      controller: _contesobrevoce,
                                      decoration: InputDecoration(
                                        labelText: 'Conte-nos sobre você!',
                                        labelStyle:
                                            GoogleFonts.poppins(color: _textColor),
                                        alignLabelWithHint: true,
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                          borderSide:
                                              BorderSide(color: _secondaryColor),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                              color: _secondaryColor, width: 2),
                                        ),
                                        filled: true,
                                        fillColor: Colors.white,
                                      ),
                                      style: GoogleFonts.poppins(color: _textColor),
                                      maxLines: isSmallMobile ? 4 : 6,
                                    ),
                                    SizedBox(height: 20),

                                    // Dropdown Setor
                                    DropdownButtonFormField<String>(
                                      decoration: InputDecoration(
                                        labelText: 'Selecione seu setor de interesse',
                                        labelStyle:
                                            GoogleFonts.poppins(color: _textColor),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                          borderSide:
                                              BorderSide(color: _secondaryColor),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                              color: _secondaryColor, width: 2),
                                        ),
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 16, vertical: 16),
                                        filled: true,
                                        fillColor: Colors.white,
                                      ),
                                      dropdownColor: Colors.white,
                                      isExpanded: true,
                                      value: _selectedSector,
                                      icon: Icon(Icons.arrow_drop_down,
                                          color: _secondaryColor),
                                      style: GoogleFonts.poppins(
                                          color: _textColor,
                                          fontSize: isSmallMobile ? 14 : 16),
                                      items: _sectors.map((String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(
                                            value,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        );
                                      }).toList(),
                                      onChanged: (value) {
                                        setState(() {
                                          _selectedSector = value;
                                        });
                                      },
                                      validator: (value) =>
                                          value == null ? 'Selecione um setor' : null,
                                    ),
                                    SizedBox(height: 20),

                                    // image de Arquivo
                                    if (_fileName != null)
                                      Container(
                                        padding: EdgeInsets.all(12),
                                        decoration: BoxDecoration(
                                          color: _secondaryColor.withOpacity(0.1),
                                          borderRadius: BorderRadius.circular(10),
                                          border: Border.all(
                                              color:
                                                  _secondaryColor.withOpacity(0.3)),
                                        ),
                                        child: Row(
                                          children: [
                                            Icon(Icons.attach_file,
                                                color: _secondaryColor, size: 24),
                                            SizedBox(width: 12),
                                            Expanded(
                                              child: Text(
                                                _fileName!,
                                                style: GoogleFonts.poppins(
                                                  fontSize: 14,
                                                  color: _textColor,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            IconButton(
                                              icon: Icon(Icons.close,
                                                  size: 20, color: _accentColor),
                                              onPressed: () {
                                                setState(() {
                                                  _fileName = null;
                                                  _pickedFile = null;
                                                });
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    if (_fileName != null) SizedBox(height: 20),

                                    // Botão Anexar
                                    OutlinedButton.icon(
                                      icon: _isLoading
                                          ? SizedBox(
                                              width: 20,
                                              height: 20,
                                              child: CircularProgressIndicator(
                                                strokeWidth: 2,
                                                color: _secondaryColor,
                                              ),
                                            )
                                          : Icon(Icons.attach_file,
                                              color: _secondaryColor),
                                      label: Text(
                                        _isLoading
                                            ? 'CARREGANDO...'
                                            : 'ANEXAR CURRÍCULO',
                                        style: GoogleFonts.roboto(
                                          fontSize: isSmallMobile ? 14 : 16,
                                          color: _secondaryColor,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 0.5,
                                        ),
                                      ),
                                      onPressed: _isLoading ? null : _pickFile,
                                      style: OutlinedButton.styleFrom(
                                        foregroundColor: _secondaryColor,
                                        minimumSize: Size(double.infinity, 50),
                                        side: BorderSide(
                                            color: _secondaryColor, width: 2),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        padding: EdgeInsets.symmetric(horizontal: 24),
                                      ),
                                    ),
                                    SizedBox(height: 20),

                                    // Botão Enviar
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: _secondaryColor,
                                        foregroundColor: Colors.white,
                                        minimumSize: Size(double.infinity, 50),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        elevation: 4,
                                        shadowColor: _secondaryColor.withOpacity(0.4),
                                        padding: EdgeInsets.symmetric(horizontal: 24),
                                      ),
                                      onPressed: _isLoading ? null : EnviarDados,
                                      child: _isLoading
                                          ? CircularProgressIndicator(
                                              color: Colors.white)
                                          : Text(
                                              'ENVIAR CURRÍCULO',
                                              style: GoogleFonts.bebasNeue(
                                                fontSize: isSmallMobile ? 20 : 24,
                                                letterSpacing: 1.5,
                                              ),
                                            ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 40),
                      ],
                    ),
                  ),
                ),
              ),
              const Footer(),
            ],
          ),
        ),
      ),
    );
  }
}