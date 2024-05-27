import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:velocity_net/constants/api_constants.dart';
import 'package:velocity_net/modules/plans/model/additional.dart';
import 'package:velocity_net/modules/plans/model/category_plan_model.dart';
import 'package:velocity_net/modules/plans/model/complement.dart';
import 'package:velocity_net/modules/plans/model/plan_model.dart';
import 'package:velocity_net/modules/plans/model/router_model.dart';

class PlansRespository {
  List<CategoryPlan> category = [];
  List<PlanModel> plans = [];
  List<AdditionalModel> additionals = [];
  List<ComplementModel> complements = [];
  List<RouterModel> routers = [];

  List<CategoryPlan> parserCategoryPlan(String responseBody) {
    var list = json.decode(responseBody) as List<dynamic>;
    var categories = list.map((e) => CategoryPlan.fromJson(e)).toList();
    return categories;
  }

  List<PlanModel> parserPlan(String responseBody) {
    var list = json.decode(responseBody) as List<dynamic>;
    var plans = list.map((e) => PlanModel.fromJson(e)).toList();
    return plans;
  }

  List<AdditionalModel> parserAdditional(String responseBody) {
    var list = json.decode(responseBody) as List<dynamic>;
    var additional = list.map((e) => AdditionalModel.fromJson(e)).toList();
    return additional;
  }

  List<ComplementModel> parserComplement(String responseBody) {
    var list = json.decode(responseBody) as List<dynamic>;
    var complement = list.map((e) => ComplementModel.fromJson(e)).toList();
    return complement;
  }

  List<RouterModel> parserRouter(String responseBody) {
    var list = json.decode(responseBody) as List<dynamic>;
    var router = list.map((e) => RouterModel.fromJson(e)).toList();
    return router;
  }

  Future<List<CategoryPlan>> categoryPlans() async {
    final response = await http.get(
      Uri.parse('${ApiConstants.baseApi}/category-plan'),
    );

    if (response.statusCode == 200) {
      category = await compute(parserCategoryPlan, response.body);
      return category;
    } else {
      throw Exception(response.statusCode);
    }
  }

  Future<List<PlanModel>> plan() async {
    final response = await http.get(
      Uri.parse('${ApiConstants.baseApi}/plans'),
    );

    if (response.statusCode == 200) {
      plans = await compute(parserPlan, response.body);
      return plans;
    } else {
      throw Exception(response.statusCode);
    }
  }

  Future<List<AdditionalModel>> additional() async {
    final response = await http.get(
      Uri.parse('${ApiConstants.baseApi}/additional'),
    );

    if (response.statusCode == 200) {
      additionals = await compute(parserAdditional, response.body);
      return additionals;
    } else {
      throw Exception(response.statusCode);
    }
  }

  Future<List<ComplementModel>> complement() async {
    final response = await http.get(
      Uri.parse('${ApiConstants.baseApi}/complement'),
    );

    if (response.statusCode == 200) {
      complements = await compute(parserComplement, response.body);
      return complements;
    } else {
      throw Exception(response.statusCode);
    }
  }

  Future<List<RouterModel>> router() async {
    final response = await http.get(
      Uri.parse('${ApiConstants.baseApi}/router'),
    );

    if (response.statusCode == 200) {
      routers = await compute(parserRouter, response.body);
      return routers;
    } else {
      throw Exception(response.statusCode);
    }
  }
}
