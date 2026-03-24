import 'package:ecommers_app/core/utils/ui_constant.dart';
import 'package:ecommers_app/features/home_screen/presentation/screens/card_screen.dart';
import 'package:ecommers_app/features/home_screen/data/models/categorys_model.dart';
import 'package:ecommers_app/features/home_screen/data/models/product_model.dart';
import 'package:ecommers_app/features/home_screen/data/repositry/repositry_home.dart';
import 'package:ecommers_app/features/home_screen/presentation/screens/category_screen.dart';
import 'package:ecommers_app/features/home_screen/presentation/screens/favorite_screen.dart';
import 'package:ecommers_app/features/home_screen/presentation/widgets/bottom_nav_item.dart';
import 'package:ecommers_app/features/home_screen/presentation/widgets/category_item.dart';
import 'package:ecommers_app/features/home_screen/presentation/widgets/custom_bottom_navigation_bar.dart';
import 'package:ecommers_app/features/home_screen/presentation/widgets/custom_navigation_bar.dart';
import 'package:ecommers_app/features/home_screen/presentation/widgets/custom_search_bar.dart';
import 'package:ecommers_app/features/home_screen/presentation/widgets/product_card.dart';
import 'package:ecommers_app/features/home_screen/presentation/widgets/section_header.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, this.onDark});
  final Function()? onDark;
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    loadingDate();
  }

  int currentIndex = 0;
  bool isLoading = false;
  List<ProductModel> allProducts = [];
  List<CategoryModel> allCategorys = [];
  List<ProductModel> allProductsCard = [];

  Future<void> loadingDate() async {
    isLoading = false;
    setState(() {});

    allProducts = await RepositryHome.getProducts();
    allCategorys = await RepositryHome.getCategorys();
    isLoading = true;

    setState(() {});
  }

  int counterProductInCart() {
    final box = Hive.box<ProductModel>(UiConstant.nameBoxCard);
    allProductsCard = box.values.toList();
    int total = 0;
    for (var product in allProductsCard) {
      total += product.quantity!;
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Stack(
        alignment: AlignmentDirectional.topEnd,
        clipBehavior: Clip.none,
        children: [
          SizedBox(
            width: 75,
            height: 75,
            child: FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CardScreen()),
                ).then((_) {
                  setState(() {});
                });
              },
              shape: const CircleBorder(),
              child: Icon(Icons.card_travel_outlined, size: 40),
            ),
          ),
          Positioned(
            top: -10,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(20),
              ),

              child: Center(
                child: Text(
                  counterProductInCart().toString(),
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: ClipPath(
        clipper: CustomNavigationBar(),
        child: CustomBottomNavigationBar(
          actions: [
            BottomNavItem(
              icon: Icons.home,
              title: "Home",
              index: 0,
              currentIndex: currentIndex,
              onTap: (int p1) {
                currentIndex = p1;
                setState(() {});
              },
            ),
            BottomNavItem(
              icon: Icons.search,
              title: "Search",
              index: 1,
              currentIndex: currentIndex,
              onTap: (int p1) {
                currentIndex = p1;
                setState(() {});
              },
            ),

            SizedBox(width: 60),

            BottomNavItem(
              icon: Icons.favorite,
              title: "Fav",
              index: 2,
              currentIndex: currentIndex,
              onTap: (int p1) {
                currentIndex = p1;
                setState(() {});
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FavoriteScreen()),
                ).then((_) {
                  setState(() {});
                });
              },
            ),
            BottomNavItem(
              icon: Icons.person,
              title: "Profile",
              index: 3,
              currentIndex: currentIndex,
              onTap: (int p1) {
                currentIndex = p1;
                setState(() {});
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        actionsPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2),
          child: Card(
            color: Theme.of(context).colorScheme.primary,
            child: Icon(Icons.card_travel),
          ),
        ),

        title: Text(
          UiConstant.titleAppBar,
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        actions: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(6),
              child: FittedBox(
                child: IconButton(
                  icon: Icon(Icons.dark_mode),
                  onPressed: widget.onDark,
                ),
              ),
            ),
          ),
          SizedBox(width: 5),
          CircleAvatar(
            radius: 25,
            backgroundImage: NetworkImage(UiConstant.pathImageNet),
          ),
        ],
      ),
      body: Center(
        child: Container(
          margin: EdgeInsets.all(10),
          child: Column(
            children: [
              CustomSearchBar(),
              SizedBox(height: 20),
              SectionHeader(
                title: UiConstant.categoriesTitel,
                actionText: UiConstant.viewAll,
              ),

              Container(
                margin: EdgeInsets.symmetric(vertical: 8),
                height: 110,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: allCategorys.length,
                  itemBuilder: (context, index) {
                    final category = allCategorys[index];
                    return CategoryItem(
                      categoryModel: category,
                      onTap: () {
                        Navigator.of(context)
                            .push(
                              MaterialPageRoute(
                                builder: (context) {
                                  return CategoryScreen(
                                    categoryModel: category,
                                  );
                                },
                              ),
                            )
                            .then((_) {
                              setState(() {});
                            });
                      },
                    );
                  },
                ),
              ),

              SectionHeader(
                title: UiConstant.allProduct,
                actionText: UiConstant.viewAll,
              ),
              Expanded(child: gridViewBuilder()),
            ],
          ),
        ),
      ),
    );
  }

  Widget gridViewBuilder() {
    final box = Hive.box<ProductModel>(UiConstant.nameBoxCard);
    return (isLoading)
        ? (allProducts.isNotEmpty)
              ? GridView.builder(
                  padding: EdgeInsets.all(12),
                  itemCount: allProducts.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 0.75,
                  ),
                  itemBuilder: (context, index) {
                    final product = allProducts[index];
                    final boxLove = Hive.box<ProductModel>(
                      UiConstant.nameBoxLove,
                    );
                    bool isContainsKey = boxLove.values.any(
                      (p) => p.id == product.id,
                    );
                    return ProductCard(
                      product: product,
                      isContainsKey: isContainsKey,
                      favoriteIcon: () async {
                        final favIndex = boxLove.values.toList().indexWhere(
                          (p) => p.id == product.id,
                        );

                        if (favIndex != -1) {
                          await boxLove.deleteAt(favIndex);
                        } else {
                          // ✅ COPY بدل نفس الـ instance
                          await boxLove.add(
                            ProductModel(
                              id: product.id,
                              title: product.title,
                              description: product.description,
                              category: product.category,
                              price: product.price,
                              thumbnail: product.thumbnail,
                              images: product.images,
                              quantity: product.quantity,
                            ),
                          );
                        }

                        setState(() {});
                      },

                      // 🛒 Add To Cart
                      iconButtonAdd: () async {
                        final existingIndex = box.values.toList().indexWhere(
                          (p) => p.id == product.id,
                        );

                        if (existingIndex != -1) {
                          final existingProduct = box.getAt(existingIndex)!;

                          existingProduct.quantity =
                              (existingProduct.quantity ?? 0) + 1;

                          await existingProduct.save();
                        } else {
                          // ✅ COPY بدل نفس الـ instance
                          await box.add(
                            ProductModel(
                              id: product.id,
                              title: product.title,
                              description: product.description,
                              category: product.category,
                              price: product.price,
                              thumbnail: product.thumbnail,
                              images: product.images,
                              quantity: 1,
                            ),
                          );
                        }

                        setState(() {});
                      },
                    );
                  },
                )
              : Center(child: Text("The Empty Product"))
        : Center(child: CircularProgressIndicator());
  }
}
