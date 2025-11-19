import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prostarelectrical/core/widgets/custom_appbar.dart';
import 'package:prostarelectrical/core/widgets/custom_button.dart';
import 'package:prostarelectrical/presentation/screens/materials/bloc/materials_list_bloc.dart';
import 'package:prostarelectrical/presentation/screens/materials/bloc/materials_list_event.dart';
import 'package:prostarelectrical/presentation/screens/materials/bloc/materials_list_state.dart';
import 'package:prostarelectrical/presentation/screens/materials/widgets/material_list_item.dart';
import 'package:prostarelectrical/presentation/screens/products/product_detail_screen.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_images.dart';

class MaterialsListScreen extends StatelessWidget {
  const MaterialsListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MaterialsListBloc()..add(LoadMaterialsListEvent()),
      child: const MaterialsListView(),
    );
  }
}

class MaterialsListView extends StatelessWidget {
  const MaterialsListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.textwhite,
      appBar: CustomAppBar(
        title: 'Materials List',
        centerTitle: true,
        leadingImage: AppImages.backarrow,
        onLeadingPressed: () => Navigator.pop(context),
      ),
      body: BlocBuilder<MaterialsListBloc, MaterialsListState>(
        builder: (context, state) {
          if (state is MaterialsListLoading) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.primaryblue),
            );
          }

          if (state is MaterialsListEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.shopping_cart_outlined,
                    size: 80,
                    color: AppColors.bordergrey,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'No materials added yet',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Add products to your materials list',
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.textPrimary.withOpacity(0.6),
                    ),
                  ),
                ],
              ),
            );
          }

          if (state is MaterialsListError) {
            return Center(
              child: Text(
                state.message,
                style: const TextStyle(color: AppColors.red),
              ),
            );
          }

          if (state is MaterialsListLoaded) {
            return Column(
              children: [
                // Materials List
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    itemCount: state.materials.length,
                    itemBuilder: (context, index) {
                      final material = state.materials[index];

                      return MaterialListItem(
                        image: material['image']!,
                        title: material['title']!,
                        description: material['description']!,
                        quantity: material['quantity']!,
                        onIncrement: () {
                          context.read<MaterialsListBloc>().add(
                            IncrementQuantityEvent(material['id']!),
                          );
                        },
                        onDecrement: () {
                          context.read<MaterialsListBloc>().add(
                            DecrementQuantityEvent(material['id']!),
                          );
                        },
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ProductDetailScreen(
                                productId: material['id']!,
                                productTitle: material['title']!,
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),

                // Send Via Email/Whatsapp Button
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: CustomButton(
                    text: "Send Via Email/ Whatsapp",
                    onPressed: () {
                      _showSendOptionsDialog(context);
                    },
                  ),
                ),
              ],
            );
          }

          return const SizedBox();
        },
      ),
    );
  }

  void _showSendOptionsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Send Materials List'),
          content: const Text('Choose how you want to send the materials list'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
                // Handle Email sending
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Sending via Email...')),
                );
              },
              child: const Text('Email'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
                // Handle WhatsApp sending
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Sending via WhatsApp...')),
                );
              },
              child: const Text('WhatsApp'),
            ),
          ],
        );
      },
    );
  }
}
