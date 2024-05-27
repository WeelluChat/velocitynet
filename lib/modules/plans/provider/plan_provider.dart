import 'package:flutter/material.dart';
import 'package:velocity_net/modules/plans/model/additional.dart';
import 'package:velocity_net/modules/plans/model/category_plan_model.dart';
import 'package:velocity_net/modules/plans/model/complement.dart';
import 'package:velocity_net/modules/plans/model/plan_model.dart';
import 'package:velocity_net/modules/plans/model/router_model.dart';
import 'package:velocity_net/modules/plans/repository/plans_repository.dart';

class PlanProvider extends ChangeNotifier {
  List<CategoryPlan>? category;
  List<PlanModel>? plans;
  List<AdditionalModel>? additionals;
  List<ComplementModel>? complements;
  List<RouterModel>? router;

  loadCategory() async {
    category = await PlansRespository().categoryPlans();
    notifyListeners();
  }

  loadPlan() async {
    plans = await PlansRespository().plan();
    notifyListeners();
  }

  loadAdditional() async {
    additionals = await PlansRespository().additional();
    notifyListeners();
  }

  loadComplement() async {
    complements = await PlansRespository().complement();
    notifyListeners();
  }

  loadRouter() async {
    router = await PlansRespository().router();
    notifyListeners();
  }
}
