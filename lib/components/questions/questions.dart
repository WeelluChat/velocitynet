import 'package:flutter/material.dart';

class Questions extends StatefulWidget {
  const Questions({super.key});

  @override
  State<Questions> createState() => _QuestionsState();
}

class _QuestionsState extends State<Questions> {
  bool _isExpanded = false;
  bool _isExpanded1 = false;
  bool _isExpanded2 = false;
  bool _isExpanded3 = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          const EdgeInsets.only(top: 100, bottom: 100, left: 20, right: 20),
      width: double.infinity,
      // decoration: const BoxDecoration(color: Colors.red),
      child: Wrap(
        spacing: 20.00,
        runSpacing: 20,
        alignment: WrapAlignment.center,
        children: [
          Container(
            width: MediaQuery.of(context).size.width < 600 ? 460 : 600,
            decoration: const BoxDecoration(
                // color: Colors.green,
                ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Text(
                        'Perguntas e Dúvidas\nFrequentes',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize:
                              MediaQuery.of(context).size.width < 600 ? 30 : 40,
                        ),
                      ),
                    ),
                  ],
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      _isExpanded = !_isExpanded;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color(0xffE1E6EE),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            _isExpanded ? Icons.remove : Icons.add,
                            color: Colors.black,
                          ),
                          Flexible(
                            child: Container(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                'Como funciona a Instalação?',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize:
                                      MediaQuery.of(context).size.width < 400
                                          ? 18
                                          : 22,
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                if (_isExpanded)
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Text(
                      'Após a escolha de um dos nossos plano, será feito uma analise de viabilidade, para verificar se sua residencia está dentro da nossa cobertura',
                      style: TextStyle(
                        color: const Color(0xff7A7A7A),
                        fontSize:
                            MediaQuery.of(context).size.width < 400 ? 18 : 22,
                      ),
                    ),
                  ),
                InkWell(
                  onTap: () {
                    setState(() {
                      _isExpanded1 = !_isExpanded1;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color(0xffE1E6EE),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            _isExpanded1 ? Icons.remove : Icons.add,
                            color: Colors.black,
                          ),
                          Flexible(
                            child: Container(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                'Como funciona o pagamento?',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize:
                                      MediaQuery.of(context).size.width < 400
                                          ? 18
                                          : 22,
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                if (_isExpanded1)
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Text(
                      'Você pode realizar o pagamento com pix ou boleto, via cartão de credito/débito e dinheiro',
                      style: TextStyle(
                        color: const Color(0xff7A7A7A),
                        fontSize:
                            MediaQuery.of(context).size.width < 400 ? 18 : 22,
                      ),
                    ),
                  ),
                InkWell(
                  onTap: () {
                    setState(() {
                      _isExpanded2 = !_isExpanded2;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xffE1E6EE)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            _isExpanded2 ? Icons.remove : Icons.add,
                            color: Colors.black,
                          ),
                          Flexible(
                            child: Container(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                'Qual é a diferença entre os planos Corporativo?',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize:
                                      MediaQuery.of(context).size.width < 400
                                          ? 18
                                          : 22,
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                if (_isExpanded2)
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Text(
                      'Flutter teste',
                      style: TextStyle(
                        color: const Color(0xff7A7A7A),
                        fontSize:
                            MediaQuery.of(context).size.width < 400 ? 18 : 22,
                      ),
                    ),
                  ),
                InkWell(
                  onTap: () {
                    setState(() {
                      _isExpanded3 = !_isExpanded3;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xffE1E6EE))),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            _isExpanded3 ? Icons.remove : Icons.add,
                            color: Colors.black,
                          ),
                          Container(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              'Benefícios',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize:
                                    MediaQuery.of(context).size.width < 400
                                        ? 18
                                        : 22,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                if (_isExpanded3)
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Text(
                      'Flutter teste',
                      style: TextStyle(
                        color: const Color(0xff7A7A7A),
                        fontSize:
                            MediaQuery.of(context).size.width < 400 ? 18 : 22,
                      ),
                    ),
                  ),
              ], // COLUMN
            ),
          ),
          Visibility(
            visible: MediaQuery.of(context).size.width > 1000,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 100),
                  child: SizedBox(
                    height: 400,
                    width: 400,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(250),
                      child: Image.network(
                        'https://scontent.fcks6-1.fna.fbcdn.net/v/t39.30808-6/313412083_487116486768328_8073133318826961181_n.jpg?_nc_cat=106&ccb=1-7&_nc_sid=a2f6c7&_nc_ohc=_qCi9k65-agAX_CWDKv&_nc_oc=AQlcs9DOhrU_bcUTOhfLHY5QkgQplrcn64M4kFZgI1oLSbOZjrewIIEoF5Iwe2w1bOI&_nc_ht=scontent.fcks6-1.fna&oh=00_AfBiDp40ppnLl0Ud8fk3H1Cmiklha8-wiDrqeQKIzJjWJQ&oe=6520D475',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
