import 'package:cloud_firestore/cloud_firestore.dart';

class Car {
  final String lob;
  final String model;
  final String vc_no;
  final double exShowroomPrice;
  final double registration;
  final double tempRegistration;
  final double onRoadPrice;
  final double insurance;
  final double handlingServiceCharge;
  final double fleetedge;
  final double amc;
  final double cd;
  final double captive;
  final double loyalty;
  final double welcome;
  final double exchange;
  final double mithila_discount;
  final double amc_canc;
  final int gstPer;

  Car({
    required this.lob,
    required this.model,
    required this.vc_no,
    required this.exShowroomPrice,
    required this.registration,
    required this.tempRegistration,
    required this.onRoadPrice,
    required this.insurance,
    required this.handlingServiceCharge,
    required this.fleetedge,
    required this.amc,
    required this.cd,
    required this.captive,
    required this.loyalty,
    required this.welcome,
    required this.exchange,
    required this.mithila_discount,
    required this.amc_canc,
    required this.gstPer,
  });

  Map<String, dynamic> toMap() {
    return {
      'lob': lob,
      'model': model,
      'vc_no': vc_no,
      'exShowroomPrice': exShowroomPrice,
      'registration': registration,
      'tempRegistration': tempRegistration,
      'onRoadPrice': onRoadPrice,
      'insurance': insurance,
      'handlingServiceCharge': handlingServiceCharge,
      'fleetedge': fleetedge,
      'amc': amc,
      'cd': cd,
      'captive': captive,
      'loyatly': loyalty,
      'welcome': welcome,
      'exchange': exchange,
      'mithila_discount': mithila_discount,
      'amc_canc': amc_canc,
      'gstPer': gstPer,
    };
  }

  factory Car.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;

    return Car(
      lob: data?['lob'] ?? '',
      model: data?['model'] ?? '',
      vc_no: data?['vc_no'] ?? '',
      exShowroomPrice: data?['exShowroomPrice'] ?? 0,
      registration: data?['registration'] ?? 0,
      tempRegistration: data?['tempRegistration'] ?? 0,
      onRoadPrice: data?['onRoadPrice'] ?? 0,
      insurance: data?['insurance'] ?? 0,
      handlingServiceCharge: data?['handlingServiceCharge'] ?? 0,
      fleetedge: data?['fleetedge'] ?? 0,
      amc: data?['amc'] ?? 0,
      cd: data?['data'] ?? 0,
      captive: data?['captive'] ?? 0,
      loyalty: data?['loyalty'] ?? 0,
      welcome: data?['welcome'] ?? 0,
      exchange: data?['exchange'] ?? 0,
      mithila_discount: data?['mithila_discount'] ?? 0,
      amc_canc: data?['amc_canc'] ?? 0,
      gstPer: data?['gstPer'] ?? 0,
    );
  }
}
