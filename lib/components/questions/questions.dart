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
    return Padding(
      padding: const EdgeInsets.only(top: 80, bottom: 40),
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 400,
              width: 600,
              decoration: const BoxDecoration(
                // color: Colors.green,
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // const Text(
                          //   'We are everywhere',
                          //   style: TextStyle(
                          //       color: Colors.black,
                          //       fontSize: 40),
                          // ),
                          // const Text(
                          //   textAlign: TextAlign.justify,
                          //   'Home Internet customers that did not provide an email address for\n service notifications',
                          //   style: TextStyle(
                          //       color: Colors.black,
                          //       fontSize: 18),
                          // ),
                          SizedBox(
                            height: 400,
                            width: 600,
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  'https://scontent.fcks6-1.fna.fbcdn.net/v/t39.30808-6/313412083_487116486768328_8073133318826961181_n.jpg?_nc_cat=106&ccb=1-7&_nc_sid=a2f6c7&_nc_ohc=_qCi9k65-agAX_CWDKv&_nc_oc=AQlcs9DOhrU_bcUTOhfLHY5QkgQplrcn64M4kFZgI1oLSbOZjrewIIEoF5Iwe2w1bOI&_nc_ht=scontent.fcks6-1.fna&oh=00_AfBiDp40ppnLl0Ud8fk3H1Cmiklha8-wiDrqeQKIzJjWJQ&oe=6520D475',
                                  fit: BoxFit.cover,
                                )),
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 100,
            ),
            Container(
              width: 600,
              decoration: const BoxDecoration(
                // color: Colors.green,
              ),
              child: Column(
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: 20),
                        child: Text(
                          'Perguntas e Dúvidas\nFrequentes',
                          style: TextStyle(color: Colors.black, fontSize: 40),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xffE1E6EE)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                _isExpanded = !_isExpanded;
                              });
                            },
                            child: Icon(
                              _isExpanded ? Icons.remove : Icons.add,
                              color: Colors.black,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(10.0),
                            child: const Text(
                              'Como funciona a instalação?',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 22),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (_isExpanded)
                    const Padding(
                      padding: EdgeInsets.all(15),
                      child: Text(
                        'Após a escolha de um dos nossos plano, será feito uma analise de viabilidade, para verificar se sua residencia está dentro da nossa cobertura',
                        style:
                            TextStyle(color: Color(0xff7A7A7A), fontSize: 18),
                      ),
                    ),
                  Container(
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
                          InkWell(
                            onTap: () {
                              setState(() {
                                _isExpanded1 = !_isExpanded1;
                              });
                            },
                            child: Icon(
                              _isExpanded1 ? Icons.remove : Icons.add,
                              color: Colors.black,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(10.0),
                            child: const Text(
                              'Como funciona o pagamento?',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 22),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (_isExpanded1)
                    const Padding(
                      padding: EdgeInsets.all(15),
                      child: Text(
                        'Você pode realizar o pagamento com pix ou boleto, via cartão de credito/débito e dinheiro',
                        style:
                            TextStyle(color: Color(0xff7A7A7A), fontSize: 18),
                      ),
                    ),
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xffE1E6EE))),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                _isExpanded2 = !_isExpanded2;
                              });
                            },
                            child: Icon(
                              _isExpanded2 ? Icons.remove : Icons.add,
                              color: Colors.black,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(10.0),
                            child: const Text(
                              'Qual é a diferença entre os planos Corporativo?',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 22),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (_isExpanded2)
                    const Padding(
                      padding: EdgeInsets.all(15),
                      child: Text(
                        'Flutter teste',
                        style:
                            TextStyle(color: Color(0xff7A7A7A), fontSize: 18),
                      ),
                    ),
                    Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xffE1E6EE))),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                _isExpanded3 = !_isExpanded3;
                              });
                            },
                            child: Icon(
                              _isExpanded3 ? Icons.remove : Icons.add,
                              color: Colors.black,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(10.0),
                            child: const Text(
                              'Benefícios',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 22),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (_isExpanded3)
                    const Padding(
                      padding: EdgeInsets.all(15),
                      child: Text(
                        'Flutter teste',
                        style:
                            TextStyle(color: Color(0xff7A7A7A), fontSize: 18),
                      ),
                    ),
                ], // COLUMN
              ),
            ),
            
          ],
        ),
      ),
    );
  }
}
