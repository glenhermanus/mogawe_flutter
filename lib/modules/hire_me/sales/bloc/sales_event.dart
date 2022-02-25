import 'dart:io';

abstract class SalesEvent {}

class GetSalesEvent extends SalesEvent {}

class GetSalesFavorite extends SalesEvent{}

class GetSalesFavoriteUpdate extends SalesEvent{}

class GetSalesStatusEvent extends SalesEvent {}
