// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member, unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:item_registration/Core/core.dart';
import 'package:item_registration/Model/item_category_model.dart';
import 'package:item_registration/Model/item_model.dart';

void addItemCategory(ItemCategoryModel c) async{
  final firebaseInstance = await FirebaseFirestore.instance.collection('category').add({
    'category_name':c.itemCategoryName
  });
  getAllItems();
  itemCategoryNotifier.notifyListeners();
}

void getAllItems() async{
  final documentsnapshot = await FirebaseFirestore.instance.collection('category').get();
  itemCategoryNotifier.value.clear();
  for (var doc in documentsnapshot.docs){
    ItemCategoryModel c=ItemCategoryModel(
      itemCategoryID: doc.id, 
      itemCategoryName: doc['category_name']
      );
      itemCategoryNotifier.value.add(c);

  }
  final snapshot = await FirebaseFirestore.instance.collection('item').get();
  itemNotifier.value.clear();

  for (var doc in snapshot.docs) {
    final item = ItemModel(
      itemId: doc.id, // Use document ID as unique ID
      itemCategoryID: doc['item_category'],
      itemName: doc['item_name'],
      itemMrp: doc['item_mrp'],
      itemSaleRate: doc['item_sale'],
    );
    itemNotifier.value.add(item);
  }

  itemNotifier.notifyListeners();

}

void addItem(ItemModel i) async {
  final firebaseInstance = await FirebaseFirestore.instance.collection('item').add({
    'item_name':i.itemName,
    'item_category':i.itemCategoryID,
    'item_mrp':i.itemMrp,
    'item_sale':i.itemSaleRate,
    'item_id':i.itemId
      });
  getAllItems(); 
}

void editItem(ItemModel i) async{
  await FirebaseFirestore.instance.collection('item').doc(i.itemId).update({
    'item_name': i.itemName,
    'item_category': i.itemCategoryID,
    'item_mrp': i.itemMrp,
    'item_sale': i.itemSaleRate,
  });
  final snapshot = await FirebaseFirestore.instance.collection('item').get();
  itemNotifier.value.clear();

  for (var doc in snapshot.docs) {
    final updatedItem = ItemModel(
      itemId: doc.id,
      itemCategoryID: doc['item_category'],
      itemName: doc['item_name'],
      itemMrp: doc['item_mrp'],
      itemSaleRate: doc['item_sale'],
    );
    itemNotifier.value.add(updatedItem);
  }
  itemNotifier.notifyListeners();
}

void deleteItem(String itemId)async {

 await FirebaseFirestore.instance.collection('item').doc(itemId).delete();

 final snapshot = await FirebaseFirestore.instance.collection('item').get();
  itemNotifier.value.clear();

  for (var doc in snapshot.docs) {
    final item = ItemModel(
      itemId: doc.id,
      itemCategoryID: doc['item_category'],
      itemName: doc['item_name'],
      itemMrp: doc['item_mrp'],
      itemSaleRate: doc['item_sale'],
    );
    itemNotifier.value.add(item);
  }
  itemNotifier.notifyListeners();
}

