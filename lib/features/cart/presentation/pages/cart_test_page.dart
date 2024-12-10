
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/test_data.dart';
import '../../data/datasources/cart_data_source.dart';
import '../../data/datasources/cart_product_data_source.dart';
import '../../data/model/cart_model.dart';
import '../../data/model/cart_product_model.dart';
import '../../domain/entities/cart.dart';
import '../../domain/entities/cart_product.dart';
import '../../domain/repositories/cart_product_repository.dart';
import '../../domain/repositories/cart_repository.dart';
import '../../domain/usecases/cart_product_use_case.dart';
import '../../domain/usecases/cart_use_case.dart';
import 'cart_page.dart';

class CartTestPage extends StatefulWidget {

  const CartTestPage({super.key});

  @override
  State<CartTestPage> createState() => _CartTestPageState();
}

class _CartTestPageState extends State<CartTestPage> {
  final String userId = TestData.loginedUser.id;

  @override
  Widget build(BuildContext context) {
    // Cart
    final cartModel = CartModel(
      userId: TestData.loginedUser.id,
      deliveryPolicyId: TestData.deliveryPolicy.id,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    final Cart cart = Cart(
      userId: TestData.loginedUser.id,
      deliveryPolicyId: TestData.deliveryPolicy.id,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );


    final cartRemoteDataSource = context.read<CartDataSource>();
    final cartRepository = context.read<CartRepository>();
    final createCartUseCase = context.read<SaveCartUseCase>();
    final updateCartUseCase = context.read<UpdateCartProductUseCase>();
    final fetchCartByUserIdUseCase = context.read<FetchCartByUserIdUseCase>();
    final clearCartUseCase = context.read<ClearCartUseCase>();
    final deleteCartUseCase = context.read<DeleteCartUseCase>();

    // CartProduct
    final cartProductRemoteDataSource = context.read<CartProductDataSource>();
    final cartProductRepository = context.read<CartProductRepository>();
    final saveCartProductUseCase = context.read<SaveCartProductUseCase>();
    final fetchCartProductsByCartIdUseCase = context.read<FetchCartProductsByCartIdUseCase>();
    final updateCartProductUseCase = context.read<UpdateCartProductUseCase>();
    final deleteCartProductUseCase = context.read<DeleteCartProductUseCase>();



    final cartProductModel = CartProductModel(
        productId: "test_product_id",
        quantity: 1,
        createdAt: DateTime.now());
    final cartProduct = CartProduct(
        productId: "test_product_id",
        quantity: 1,
        createdAt: DateTime.now());



    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          Text("장바구니"),

          OutlinedButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => CartPage()));
            },
            child: Text("장바구니 화면 이동"),
          ),

          Divider(),
          Text("DataSource"),

          OutlinedButton(
            onPressed: () async{
              final docRef = FirebaseFirestore.instance.collection('users').doc('test_user_id');
              try {
                final docSnapshot = await docRef.get();
                if (docSnapshot.exists) {
                  print("Document data: ${docSnapshot.data()}");
                } else {
                  print("No such document!");
                }
              } catch (e) {
                print("Error fetching document: $e");
              }
            },
            child: Text("유저 테스트"),
          ),


          OutlinedButton(
            onPressed: () async{
              await cartRemoteDataSource.saveCart(cartModel);
            },
            child: Text("장바구니 saveCart (데이터소스)"),
          ),

          OutlinedButton(
            onPressed: () async {
              final cartModelData =
                  await cartRemoteDataSource.fetchCartByUserId();
              showSnackBar(context, cartModelData!.id!);
            },
            child: Text("장바구니 fetchByUserId (DataSource)"),
          ),

          OutlinedButton(
            onPressed: () async{
              final cartModel = await cartRemoteDataSource.fetchCartByUserId();
              await cartRemoteDataSource.clearCart(cartModel!.id!);
            },
            child: Text("장바구니 clear (데이터소스)"),
          ),

          OutlinedButton(
            onPressed: () async {
              final cartModel = await cartRemoteDataSource.fetchCartByUserId();

              cartRemoteDataSource.deleteCart(cartModel!.id!);
            },
            child: Text("장바구니 deleteCart (데이터소스)"),
          ),

          Text("Repository"),
          OutlinedButton(
            onPressed: () async {
              cartRepository.saveCart(cart);
            },
            child: Text("장바구니 saveCart (Repository)"),
          ),

          OutlinedButton(
            onPressed: () async {
              final cartModelData =
                  await cartRepository.fetchCartByUserId();
              showSnackBar(context, cartModelData!.id!);
            },
            child: Text("장바구니 fetchByUserId (Repository)"),
          ),

          OutlinedButton(
            onPressed: () async {
              final cartModel = await cartRemoteDataSource.fetchCartByUserId();

              cartRepository.clearCart(cartModel!.id!);
            },
            child: Text("장바구니 clearCart (Repository)"),
          ),

          OutlinedButton(
            onPressed: () async {
              final cartModel = await cartRemoteDataSource.fetchCartByUserId();

              cartRepository.deleteCart(cartModel!.id!);
            },
            child: Text("장바구니 deleteCart (Repository)"),
          ),

          //----------------------------------------------------
          Text("UseCase"),
          OutlinedButton(
            onPressed: () {
              createCartUseCase.call(cart);
            },
            child: Text("장바구니 SaveCartUseCase (유스케이스)"),
          ),

          OutlinedButton(
            onPressed: () async{
              final cart = await fetchCartByUserIdUseCase.call(NoParams());

              showSnackBar(context, cart!.id!);
            },
            child: Text("장바구니 fetchCartByUserUseCase (유스케이스)"),
          ),

          OutlinedButton(
            onPressed: () async{
              final cartModel = await cartRemoteDataSource.fetchCartByUserId();

              clearCartUseCase(cartModel!.id!);

            },
            child: Text("장바구니 아이템 clearCartUseCase (유스케이스)"),
          ),

          OutlinedButton(
            onPressed: () async{
              final cartModel = await cartRemoteDataSource.fetchCartByUserId();

              deleteCartUseCase(cartModel!.id!);

            },
            child: Text("장바구니 아이템 deleteCartUseCase (유스케이스)"),
          ),


          //----------------------------------------------------------



          Divider(),
          Text("장바구니 아이템"),
          Divider(),
          Text("DataSource"),
          OutlinedButton(
            onPressed: () {
              cartProductRemoteDataSource.saveCartProduct(cartProductModel);
            },
            child: Text("장바구니 아이템 create (데이터소스)"),
          ),
          OutlinedButton(
            onPressed: () async {
              final cartModel = await cartRemoteDataSource.fetchCartByUserId();

              var cartProductList =
                  await cartProductRemoteDataSource.fetchCartProductsByCartId(cartModel!.id!);
              showSnackBar(context, cartProductList.first.id!);
            },
            child: Text("장바구니 아이템 리스트 fetchByCartId (데이터소스)"),
          ),

          //----------------------------------------------------

          Text("Repository"),
          OutlinedButton(
            onPressed: () {
              cartProductRepository.saveCartProduct(cartProduct);
            },
            child: Text("장바구니 아이템 save (Repository)"),
          ),

          OutlinedButton(

            onPressed: () async {
              final cartModel = await cartRemoteDataSource.fetchCartByUserId();

              var cartProducts = await cartProductRepository.fetchCartProductsByCartId(cartModel!.id!);
              showSnackBar(context, cartProducts.first.id!);

            },
            child: Text("장바구니 아이템 fetch (Repository)"),
          ),

          OutlinedButton(
            onPressed: () async {
              final cartModel = await cartRemoteDataSource.fetchCartByUserId();

              var cartProducts = await cartProductRepository.fetchCartProductsByCartId(cartModel!.id!);

              CartProduct newCartProduct = cartProducts.first.copyWith(quantity: 5,isChecked: false);

              await cartProductRepository.updateCartProduct(newCartProduct);

              showSnackBar(context, newCartProduct.isChecked.toString());

            },
            child: Text("장바구니 아이템 update (Repository)"),
          ),

          OutlinedButton(
            onPressed: () async {
              final cartModel = await cartRemoteDataSource.fetchCartByUserId();

              var cartProducts = await cartProductRepository.fetchCartProductsByCartId(cartModel!.id!);

              await cartProductRepository.deleteCartProduct(cartProducts.first.id!);

              showSnackBar(context, "삭제 완료 되었습니다");

            },
            child: Text("장바구니 아이템 delete (Repository)"),
          ),

          //----------------------------------------------------
          Text("UseCase"),

          OutlinedButton(
            onPressed: () async {
              final cartModel = await cartRemoteDataSource.fetchCartByUserId();

              var cartProducts = await cartProductRepository.fetchCartProductsByCartId(cartModel!.id!);

              await saveCartProductUseCase.call(cartProducts.first);

              showSnackBar(context,"유스케이스 장바구니 상품 save 성공");

            },
            child: Text("장바구니 아이템 save (Repository)"),
          ),

          OutlinedButton(
            onPressed: () async {
              final cartModel = await cartRemoteDataSource.fetchCartByUserId();

              final cartProducts = await fetchCartProductsByCartIdUseCase(cartModel!.id!);

              showSnackBar(context, cartProducts.first.id!);

            },
            child: Text("장바구니 아이템 fetchCartProductsByCartIdUseCase (Repository)"),
          ),

          OutlinedButton(
            onPressed: () async {
              final cartModel = await cartRemoteDataSource.fetchCartByUserId();

              var cartProducts = await cartProductRepository.fetchCartProductsByCartId(cartModel!.id!);

              CartProduct newCartProduct = cartProducts.first.copyWith(quantity: 7, isChecked: false);

              await updateCartProductUseCase.call(newCartProduct);

              showSnackBar(context, newCartProduct.isChecked.toString());


            },
            child: Text("장바구니 아이템 update (Repository)"),
          ),

          OutlinedButton(
            onPressed: () async {
              final cartModel = await cartRemoteDataSource.fetchCartByUserId();

              var cartProducts = await cartProductRepository.fetchCartProductsByCartId(cartModel!.id!);

              await deleteCartProductUseCase.call(cartProducts.first.id!);

              showSnackBar(context, "삭제 완료 되었습니다");

            },
            child: Text("장바구니 아이템 delete (Repository)"),
          ),

        ],
      ),
    );
  }

  void showSnackBar(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
        duration: Duration(seconds: 1), // 표시 시간
      ),
    );
  }
}
