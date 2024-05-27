import 'package:brasil_fields/brasil_fields.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:velocity_net/constants/api_constants.dart';
import 'package:velocity_net/modules/plans/model/additional.dart';
import 'package:velocity_net/modules/plans/model/category_plan_model.dart';
import 'package:velocity_net/modules/plans/model/complement.dart';
import 'package:velocity_net/modules/plans/model/plan_model.dart';
import 'package:velocity_net/modules/plans/provider/plan_provider.dart';

class GroupMontedPlan extends StatefulWidget {
  const GroupMontedPlan({super.key});

  @override
  State<GroupMontedPlan> createState() => _GroupMontedPlanState();
}

class _GroupMontedPlanState extends State<GroupMontedPlan> {
  bool isCheckedMax = false;

  bool isCheckedTelecine = false;

  bool isCheckedPremiere = false;

  bool isCheckedDeezer = false;

  String? selectedValuePlano;

  String? selectedValueMb;

  int routerQuantity = 0;
  String categoryName = 'Selecione um plano';

  List<String> categoryPlanName = [];

  List<CategoryPlan>? categoryPlan;

  String plansName = 'Selecione';

  List<String>? plansNameList = [];

  List<PlanModel>? plans;

  List<String> teste = ['1', '2'];

  String testeName = '1';

  String imagePlanBase = '';

  String idPlanSelected = '';

  String imageLogoBase = '';

  String descriptionPlan = '';

  List<AdditionalModel> additionals = [];
  List additionalsList = [];

  List<bool> _isCheckedList = [];

  List<String> imagesAdditional = [];

  double valuePlan = 0.00;

  List<ComplementModel>? complements;

  List<ComplementModel>? complementsList;

  List<dynamic>? idComplements;

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  List<dynamic> planClientDetails = [];

  List<dynamic> nameAdditional = [];

  @override
  void initState() {
    super.initState();
    context.read<PlanProvider>().loadCategory();
    context.read<PlanProvider>().loadPlan();
    context.read<PlanProvider>().loadAdditional();
    context.read<PlanProvider>().loadComplement();
    context.read<PlanProvider>().loadRouter();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 60, right: 40, top: 10, bottom: 10),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  'ESCOLHER OPÇÕES',
                  style: GoogleFonts.getFont('Poppins',
                      fontWeight: FontWeight.w600),
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
                      Consumer<PlanProvider>(builder: (
                        context,
                        controller,
                        _,
                      ) {
                        categoryPlan = controller.category;
                        if (categoryPlan == null) {
                          return const CircularProgressIndicator();
                        }

                        categoryPlanName = categoryPlan!
                            .map((e) => e.nome)
                            .cast<String>()
                            .toList();

                        categoryPlanName.insert(0, "Selecione um plano");
                        return DropdownButtonHideUnderline(
                          child: DropdownButton2<String>(
                            isExpanded: true,
                            // hint: const Row(
                            // children: [
                            // Expanded(
                            //   child: Text(
                            //     'Plano Residencial',
                            //     style: TextStyle(
                            //       fontSize: 14,
                            //       fontWeight: FontWeight.bold,
                            //     ),
                            //     overflow: TextOverflow.ellipsis,
                            //   ),
                            // ),
                            // ],
                            // ),
                            items: categoryPlanName
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
                            value: categoryName,
                            onChanged: (String? value) {
                              setState(() {
                                categoryName = value!;
                              });
                            },
                            buttonStyleData: ButtonStyleData(
                                height: 40,
                                width: 300,
                                padding:
                                    const EdgeInsets.only(left: 14, right: 14),
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
                                thumbVisibility:
                                    MaterialStateProperty.all<bool>(true),
                              ),
                            ),
                            menuItemStyleData: const MenuItemStyleData(
                              height: 40,
                              padding: EdgeInsets.only(left: 14, right: 14),
                            ),
                          ),
                        );
                      }),
                      const SizedBox(
                        height: 10,
                      ),
                      Consumer<PlanProvider>(builder: (context, controller, _) {
                        if (categoryName == "Selecione um plano") {
                          return Container(
                              alignment: Alignment.center,
                              width: double.infinity,
                              height: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: const Color(0xffD9D9D9),
                              ),
                              child: const Text('Selecione um plano'));
                        }
                        var category = controller.category!
                            .where((element) => element.nome == categoryName);

                        var idCategory = category.first.id;

                        plans = controller.plans;

                        var plansCast = plans!.where(
                            (element) => element.idCategoria == idCategory);

                        plansNameList!.addAll(plansCast
                            .map((e) => e.nome)
                            .cast<String>()
                            .toList());

                        plansNameList!.insert(0, 'Selecione');

                        return DropdownButtonHideUnderline(
                          child: DropdownButton2<String>(
                            isExpanded: true,
                            // hint: const Row(
                            // children: [
                            // Expanded(
                            //   child: Text(
                            //     '500 MB',
                            //     style: TextStyle(
                            //       fontSize: 14,
                            //       fontWeight: FontWeight.bold,
                            //     ),
                            //     overflow: TextOverflow.ellipsis,
                            //   ),
                            // ),
                            // ],
                            // ),
                            items: plansNameList!
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
                            value: plansName,
                            onChanged: (String? value) {
                              setState(() {
                                plansName = value!;
                                var plansInstance =
                                    plans!.where((e) => e.nome == plansName);
                                var planBase = [];
                                var imageLogo = [];
                                var price = [];
                                var description = [];
                                var idPlan = [];
                                planBase = plansInstance
                                    .map((e) => e.planoBase)
                                    .toList();
                                imageLogo =
                                    plansInstance.map((e) => e.imagem).toList();

                                price =
                                    plansInstance.map((e) => e.preco).toList();

                                description = plansInstance
                                    .map((e) => e.descricao)
                                    .toList();

                                idPlan =
                                    plansInstance.map((e) => e.id).toList();

                                var idComplementsPase = plansInstance
                                    .map((e) => e.complementar)
                                    .toList();

                                idComplements = idComplementsPase[0];

                                imagePlanBase = planBase.first;
                                imageLogoBase = imageLogo.first;
                                valuePlan +=
                                    double.parse(price[0]["\$numberDecimal"]);
                                descriptionPlan = description.first;

                                idPlanSelected = idPlan.first;
                              });
                            },
                            buttonStyleData: ButtonStyleData(
                              height: 40,
                              width: 300,
                              padding:
                                  const EdgeInsets.only(left: 14, right: 14),
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
                                thumbVisibility:
                                    MaterialStateProperty.all<bool>(true),
                              ),
                            ),
                            menuItemStyleData: const MenuItemStyleData(
                              height: 40,
                              padding: EdgeInsets.only(left: 14, right: 14),
                            ),
                          ),
                        );
                      }),
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
                      SizedBox(
                        height: 120,
                        child: Consumer<PlanProvider>(
                            builder: (context, controller, _) {
                          if (controller.additionals == null) {
                            return const CircularProgressIndicator();
                          }
                          additionals = controller.additionals!;

                          var result = additionals.where((element) {
                            var ids =
                                element.idPlans!.map((e) => e['id']).toList();
                            return ids.contains(idPlanSelected);
                          }).toList();

                          additionalsList = result;

                          if (_isCheckedList.length != additionals.length) {
                            _isCheckedList =
                                List<bool>.filled(additionals.length, false);
                          }

                          return ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: additionalsList.length,
                            itemBuilder: (context, index) {
                              return CheckboxListTile(
                                title: Text(additionalsList[index].nome!),
                                activeColor: Colors.black,
                                value: _isCheckedList[index],
                                onChanged: (bool? value) {
                                  setState(() {
                                    _isCheckedList[index] = value!;

                                    if (value) {
                                      imagesAdditional
                                          .add(additionalsList[index].image!);

                                      nameAdditional.add({
                                        "nomeAdicional":
                                            additionalsList[index].nome!,
                                        "precoAdicional": additionalsList[index]
                                            .preco!["\$numberDecimal"]
                                      });

                                      var price = additionalsList[index].preco;

                                      var priceDouble = double.parse(
                                          price!["\$numberDecimal"]);

                                      valuePlan += priceDouble;

                                      valuePlan = double.parse(
                                          valuePlan.toStringAsFixed(2));
                                    } else {
                                      var price = additionalsList[index].preco;
                                      imagesAdditional.remove(
                                          additionalsList[index].image!);

                                      var priceDoble = double.parse(
                                          price!["\$numberDecimal"]);

                                      var result = valuePlan - priceDoble;

                                      valuePlan = double.parse(
                                          result.toStringAsFixed(2));
                                    }
                                  });
                                },
                              );
                            },
                          );
                        }),
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
                                onPressed: () {
                                  var router =
                                      context.read<PlanProvider>().router;
                                  var price = router!.map((e) => e.preco);
                                  var value = double.parse(price
                                      .map((e) => e!["\$numberDecimal"])
                                      .first);

                                  setState(() {
                                    if (routerQuantity > 0) {
                                      routerQuantity--;
                                      var decrement = value;
                                      valuePlan -= double.parse(
                                          decrement.toStringAsFixed(2));
                                    }
                                  });
                                },
                                icon: const Icon(Icons.remove)),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            routerQuantity.toString(),
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
                                onPressed: () {
                                  var router =
                                      context.read<PlanProvider>().router;
                                  var price = router!.map((e) => e.preco);
                                  var value = double.parse(price
                                      .map((e) => e!["\$numberDecimal"])
                                      .first);

                                  setState(() {
                                    routerQuantity++;
                                    var increment = value;
                                    valuePlan += double.parse(
                                        increment.toStringAsFixed(2));
                                  });
                                },
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
                          controller: nameController,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.only(
                                bottom: 15, left: 10, right: 10),
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
                          controller: phoneController,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            TelefoneInputFormatter()
                          ],
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.only(
                                bottom: 15, left: 10, right: 10),
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
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                            backgroundColor: MaterialStateProperty.all(
                                const Color(0xffFFB000)),
                          ),
                          onPressed: () {
                            setState(() {
                              planClientDetails.add({
                                "nomePlano": plansName,
                                "categoria": categoryName,
                                "nomeCliente": nameController.text,
                                "contatoCliente": phoneController.text,
                                "adicionais": nameAdditional
                              });
                              print(planClientDetails);
                            });
                          },
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
            ),
          ),
          const SizedBox(
            width: 40,
          ),
          // const MountedCard(),
          Column(
            children: [
              Text(
                'MEU PLANO',
                style:
                    GoogleFonts.getFont('Poppins', fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                width: 280,
                height: 610,
                decoration: BoxDecoration(
                    color: const Color(0xff13294E),
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 25,
                    ),
                    SizedBox(
                      width: 220,
                      height: 120,
                      child: imageLogoBase.isEmpty
                          ? const SizedBox()
                          : Image.network(
                              "${ApiConstants.baseUrlUploads}/$imageLogoBase",
                              fit: BoxFit.cover,
                            ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: 220,
                      height: 20,
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(3)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          descriptionPlan.isEmpty
                              ? Container()
                              : Text(
                                  descriptionPlan,
                                  style: GoogleFonts.getFont(
                                    'Poppins',
                                    color: Colors.white,
                                    fontSize: 7,
                                  ),
                                ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: 220,
                      height: 190,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.white,
                        ),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Scrollbar(
                        child: ListView(
                          scrollDirection: Axis.vertical,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Opções Adicionais',
                                  style: GoogleFonts.getFont(
                                    'Poppins',
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                            imagesAdditional.isEmpty
                                ? Container()
                                : Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      ...imagesAdditional.map(
                                        (e) => Padding(
                                          padding:
                                              const EdgeInsets.only(top: 10),
                                          child: SizedBox(
                                            height: 25,
                                            child: Image.network(
                                              "${ApiConstants.baseUrlUploads}/$e",
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 35, top: 10),
                      width: double.infinity,
                      height: 80,
                      child: Consumer<PlanProvider>(
                        builder: (context, controller, _) {
                          complements = controller.complements;
                          if (complements == null) {
                            return const CircularProgressIndicator();
                          }
                          if (idComplements == null) {
                            return Container();
                          }
                          var idList =
                              idComplements!.map((e) => e['id']).toList();
                          complementsList = complements!
                              .where((element) => idList.contains(element.id))
                              .toList();

                          return complementsList == null
                              ? Container()
                              : ListView.builder(
                                  itemCount: complementsList!.length,
                                  itemBuilder: (context, index) {
                                    return Row(
                                      children: [
                                        SizedBox(
                                          width: 20,
                                          height: 20,
                                          child: Image.network(
                                            fit: BoxFit.cover,
                                            "${ApiConstants.baseUrlUploads}/${complementsList![index].image!}",
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 5,
                                          height: 30,
                                        ),
                                        Text(
                                          complementsList![index].nome!,
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 12),
                                        ),
                                      ],
                                    );
                                  },
                                );
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: 220,
                      height: 115,
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1.5,
                          color: Colors.amber,
                        ),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'R\$',
                                style: GoogleFonts.getFont('Poppins',
                                    color: Colors.amber,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600),
                              ),
                              Text(
                                valuePlan.toStringAsFixed(2),
                                style: GoogleFonts.getFont('Kanit',
                                    color: Colors.amber,
                                    fontSize: 55,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          Text(
                            'Até o vencimento',
                            style: GoogleFonts.getFont('Poppins',
                                color: Colors.amber,
                                fontSize: 10,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            width: 40,
          ),
          // const PreviewCard(),
          Column(
            children: [
              Text(
                'PLANO BÁSICO',
                style:
                    GoogleFonts.getFont('Poppins', fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 10,
              ),
              imagePlanBase == ""
                  ? SizedBox(
                      height: 615,
                      child: Image.asset(
                        'assets/card_500.png',
                        fit: BoxFit.cover,
                      ),
                    )
                  : SizedBox(
                      height: 615,
                      child: Image.network(
                        "${ApiConstants.baseUrlUploads}/$imagePlanBase",
                        fit: BoxFit.cover,
                      ),
                    ),
            ],
          )
        ],
      ),
    );
  }
}
