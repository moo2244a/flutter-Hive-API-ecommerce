import 'package:ecommers_app/core/utils/ui_constant.dart';
import 'package:ecommers_app/features/card%20screen/presentation/logic/card_provider.dart';
import 'package:ecommers_app/features/card%20screen/presentation/screens/card_screen.dart';
import 'package:ecommers_app/features/favorite%20screen/presentation/screens/favorite_screen.dart';
import 'package:ecommers_app/features/home%20screen/presentation/logic/cubit/product_cubit.dart';
import 'package:ecommers_app/features/home%20screen/presentation/widgets/bottom_nav_item.dart';
import 'package:ecommers_app/features/home%20screen/presentation/widgets/categorys_list_view.dart';
import 'package:ecommers_app/features/home%20screen/presentation/widgets/custom_bottom_navigation_bar.dart';
import 'package:ecommers_app/features/home%20screen/presentation/widgets/custom_navigation_bar.dart';
import 'package:ecommers_app/features/home%20screen/presentation/widgets/custom_search_bar.dart';
import 'package:ecommers_app/features/home%20screen/presentation/widgets/grid_view_products.dart';
import 'package:ecommers_app/features/home%20screen/presentation/widgets/section_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, this.onDark});
  final Function()? onDark;

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
                );
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
                  Provider.of<CardProvider>(
                    context,
                  ).calculateProductInCart().toString(),
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: ClipPath(
        clipper: CustomNavigationBar(),
        child: BlocBuilder<ProductCubit, ProductState>(
          builder: (context, state) {
            final cubit = ProductCubit.get(context);
            return CustomBottomNavigationBar(
              actions: [
                BottomNavItem(
                  icon: Icons.home,
                  title: "Home",
                  index: 0,
                  currentIndex: cubit.currentIndex,
                  onTap: (p1) => cubit.setCurrentIndex(p1),
                ),
                BottomNavItem(
                  icon: Icons.search,
                  title: "Search",
                  index: 1,
                  currentIndex: cubit.currentIndex,
                  onTap: (p1) => cubit.setCurrentIndex(p1),
                ),

                SizedBox(width: 60),

                BottomNavItem(
                  icon: Icons.favorite,
                  title: "Fav",
                  index: 2,
                  currentIndex: cubit.currentIndex,

                  onTap: (int p1) {
                    cubit.setCurrentIndex(p1);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => FavoriteScreen()),
                    );
                  },
                ),
                BottomNavItem(
                  icon: Icons.person,
                  title: "Profile",
                  index: 3,
                  currentIndex: cubit.currentIndex,
                  onTap: (p1) => cubit.setCurrentIndex(p1),
                ),
              ],
            );
          },
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
                  onPressed: onDark,
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
                child: BlocBuilder<ProductCubit, ProductState>(
                  builder: (context, state) {
                    final allCategorys = ProductCubit.get(context).allCategorys;
                    if (state is GetDataProductsLoading) {
                      return Center(child: CircularProgressIndicator());
                    } else if (state is GetDataProductsError) {
                      return Center(child: Text(state.message));
                    }

                    return CategorysListView(allCategorys: allCategorys);
                  },
                ),
              ),

              SectionHeader(
                title: UiConstant.allProduct,
                actionText: UiConstant.viewAll,
              ),
              Expanded(
                child: BlocBuilder<ProductCubit, ProductState>(
                  builder: (context, state) {
                    final allProducts = ProductCubit.get(context).allProducts;
                    if (state is GetDataProductsLoading) {
                      return Center(child: CircularProgressIndicator());
                    } else if (state is GetDataProductsError) {
                      return Center(child: Text(state.message));
                    }

                    return GridViewProducts(allProducts: allProducts);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
