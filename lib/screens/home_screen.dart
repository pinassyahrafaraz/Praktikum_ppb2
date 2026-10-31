
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/product_providers.dart';

// ==================== WARNA TEMA PINK PASTEL ====================

const Color primaryColor = Color(0xFFD987AA);
const Color appBarColor = Color(0xFFF8DDE8);
const Color backgroundColor = Color(0xFFFFF7FA);
const Color categoryColor = Color(0xFFFCEAF1);
const Color cardColor = Color(0xFFFFFFFF);
const Color textColor = Color(0xFF59434D);
const Color secondaryColor = Color(0xFF927D86);
const Color borderColor = Color(0xFFEBD0DC);

// ==================== HALAMAN DETAIL PRODUK ====================

class ProductDetailScreen extends StatelessWidget {
  final dynamic product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text(
          product.title ?? 'Detail Produk',
          style: const TextStyle(
            fontSize: 16,
            color: textColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: appBarColor,
        foregroundColor: textColor,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 250,
              width: double.infinity,
              color: categoryColor,
              child: Image.network(
                product.thumbnail ?? '',
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) =>
                    const Center(
                  child: Icon(
                    Icons.image_outlined,
                    size: 50,
                    color: secondaryColor,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.title ?? '',
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '\$${product.price ?? 0}',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Divider(color: borderColor),
                  const SizedBox(height: 16),
                  const Text(
                    'Deskripsi Produk',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    product.description ??
                        'Tidak ada deskripsi untuk produk ini.',
                    style: const TextStyle(
                      fontSize: 14,
                      color: secondaryColor,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 80),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.all(16),
        color: backgroundColor,
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Produk dimasukkan ke keranjang!'),
                    ),
                  );
                },
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: primaryColor),
                  backgroundColor: categoryColor,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  '+ Keranjang',
                  style: TextStyle(
                    color: textColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Menuju halaman checkout...'),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Beli Sekarang',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ==================== HALAMAN UTAMA ====================

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController =
      TextEditingController();

  String _selectedSort = 'Default';

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ProductProvider>(
        context,
        listen: false,
      ).fetchProduct();

      Provider.of<ProductProvider>(
        context,
        listen: false,
      ).fetchCategories();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);

    List<String> categories = [
      'ALL',
      ...productProvider.categoryList,
    ];

    // Mengatur urutan produk berdasarkan harga
    final products = List.of(productProvider.product);

    if (_selectedSort == 'Termurah') {
      products.sort(
        (a, b) => (a.price as num).compareTo(b.price as num),
      );
    } else if (_selectedSort == 'Termahal') {
      products.sort(
        (a, b) => (b.price as num).compareTo(a.price as num),
      );
    }

    return Scaffold(
      backgroundColor: backgroundColor,

      // ==================== APP BAR BARU ====================

      appBar: AppBar(
        elevation: 0,
        backgroundColor: appBarColor,
        toolbarHeight: 75,
        title: Row(
          children: [
            // Logo berbentuk lingkaran
            Container(
              width: 45,
              height: 45,
              decoration: const BoxDecoration(
                color: Color(0xFFEFC5D6),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.storefront_rounded,
                color: Color(0xFFB96D8D),
                size: 25,
              ),
            ),

            const SizedBox(width: 12),

            // Nama aplikasi
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Pink Boutique',
                  style: TextStyle(
                    color: textColor,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.3,
                  ),
                ),
                SizedBox(height: 3),
                Text(
                  'Everything you love, in one place',
                  style: TextStyle(
                    color: secondaryColor,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          // Tombol favorit
          Container(
            margin: const EdgeInsets.only(right: 8),
            decoration: const BoxDecoration(
              color: Color(0xFFFCEAF1),
              shape: BoxShape.circle,
            ),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.favorite_border_rounded,
                color: Color(0xFFC47D9B),
                size: 21,
              ),
            ),
          ),

          // Tombol keranjang
          Container(
            margin: const EdgeInsets.only(right: 15),
            decoration: const BoxDecoration(
              color: Color(0xFFFCEAF1),
              shape: BoxShape.circle,
            ),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.shopping_basket_outlined,
                color: Color(0xFFC47D9B),
                size: 21,
              ),
            ),
          ),
        ],
      ),

      // ==================== BODY ====================

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          // ==================== SEARCH BAR BARU ====================

          Container(
            color: appBarColor,
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 18),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
                border: Border.all(
                  color: const Color(0xFFF3D5E1),
                ),
              ),
              child: Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 16),
                    child: Icon(
                      Icons.search_rounded,
                      color: primaryColor,
                      size: 22,
                    ),
                  ),

                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      style: const TextStyle(
                        color: textColor,
                        fontSize: 13,
                      ),
                      decoration: const InputDecoration(
                        hintText: 'Cari produk favorit kamu...',
                        hintStyle: TextStyle(
                          color: secondaryColor,
                          fontSize: 12,
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 14,
                        ),
                      ),
                      onChanged: (query) {
                        setState(() {});
                        productProvider.searchProducts(query);
                      },
                    ),
                  ),

                  // Tombol filter
                  Container(
                    margin: const EdgeInsets.only(right: 7),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFCEAF1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: IconButton(
                      constraints: const BoxConstraints(
                        minWidth: 38,
                        minHeight: 38,
                      ),
                      padding: EdgeInsets.zero,
                      onPressed: () {},
                      icon: const Icon(
                        Icons.tune_rounded,
                        color: primaryColor,
                        size: 19,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ==================== HEADER KATEGORI DAN SORTING ====================

          Container(
            color: categoryColor,
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Kategori',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
                Container(
                  height: 30,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: borderColor),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: _selectedSort,
                      icon: const Icon(
                        Icons.swap_vert_rounded,
                        size: 14,
                        color: primaryColor,
                      ),
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: textColor,
                      ),
                      onChanged: (String? newValue) {
                        if (newValue != null) {
                          setState(() {
                            _selectedSort = newValue;
                          });
                        }
                      },
                      items: <String>[
                        'Default',
                        'Termurah',
                        'Termahal',
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text('Harga: $value'),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // ==================== HORIZONTAL CATEGORY LIST ====================

          Container(
            color: categoryColor,
            height: 48,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final category = categories[index];

                final isSelected =
                    (productProvider.selectedCategory == category) ||
                    (category == 'ALL' &&
                        productProvider.selectedCategory == null);

                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 4,
                    vertical: 4,
                  ),
                  child: ChoiceChip(
                    label: Text(category.toUpperCase()),
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.white : textColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 11,
                    ),
                    selected: isSelected,
                    selectedColor: primaryColor,
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: BorderSide(
                        color: isSelected
                            ? primaryColor
                            : borderColor,
                      ),
                    ),
                    onSelected: (bool selected) {
                      if (category == 'ALL') {
                        productProvider.fetchProduct();
                      } else if (selected) {
                        productProvider.filterByCategory(category);
                      }
                    },
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 8),

          // ==================== HEADER DAFTAR PRODUK ====================

          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 4,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Daftar Produk',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
                Text(
                  '${products.length} item',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
          ),

          // ==================== GRID VIEW PRODUK ====================

          Expanded(
            child: productProvider.loading
                ? const Center(
                    child: CircularProgressIndicator(
                      color: primaryColor,
                    ),
                  )
                : products.isEmpty
                    ? const Center(
                        child: Text(
                          'Produk tidak ditemukan',
                          style: TextStyle(
                            color: secondaryColor,
                            fontSize: 15,
                          ),
                        ),
                      )
                    : GridView.builder(
                        padding: const EdgeInsets.all(12),
                        gridDelegate:
                            const SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 220,
                          childAspectRatio: 0.68,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                        ),
                        itemCount: products.length,
                        itemBuilder: (context, index) {
                          final product = products[index];

                          return InkWell(
                            borderRadius: BorderRadius.circular(12),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      ProductDetailScreen(
                                    product: product,
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: cardColor,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: borderColor,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: primaryColor.withOpacity(0.07),
                                    blurRadius: 6,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                                  // GAMBAR PRODUK DAN RATING

                                  Expanded(
                                    flex: 6,
                                    child: Stack(
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              const BorderRadius.vertical(
                                            top: Radius.circular(12),
                                          ),
                                          child: Container(
                                            color: const Color(0xFFFFF0F5),
                                            width: double.infinity,
                                            height: double.infinity,
                                            child: Image.network(
                                              product.thumbnail ?? '',
                                              fit: BoxFit.cover,
                                              errorBuilder:
                                                  (context, error, stackTrace) =>
                                                      const Center(
                                                child: Icon(
                                                  Icons.image_outlined,
                                                  color: secondaryColor,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),

                                        // BADGE RATING

                                        Positioned(
                                          top: 6,
                                          right: 6,
                                          child: Container(
                                            padding:
                                                const EdgeInsets.symmetric(
                                              horizontal: 6,
                                              vertical: 2,
                                            ),
                                            decoration: BoxDecoration(
                                              color: const Color(0xFFFFF7FA)
                                                  .withOpacity(0.95),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                const Icon(
                                                  Icons.star,
                                                  color: Color(0xFFE9B66B),
                                                  size: 10,
                                                ),
                                                const SizedBox(width: 2),
                                                Text(
                                                  '${product.rating ?? 4.0}',
                                                  style: const TextStyle(
                                                    color: textColor,
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  // INFORMASI PRODUK DAN KERANJANG

                                  Expanded(
                                    flex: 5,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                (product.category ?? '')
                                                    .toString()
                                                    .toUpperCase(),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                  fontSize: 9,
                                                  fontWeight: FontWeight.bold,
                                                  color: primaryColor,
                                                ),
                                              ),
                                              const SizedBox(height: 2),
                                              Text(
                                                product.title ?? '',
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 11,
                                                  color: textColor,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                '\$${product.price ?? 0}',
                                                style: const TextStyle(
                                                  color: primaryColor,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12,
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  ScaffoldMessenger.of(
                                                    context,
                                                  ).showSnackBar(
                                                    SnackBar(
                                                      content: Text(
                                                        '${product.title} ditambahkan ke keranjang!',
                                                      ),
                                                      duration:
                                                          const Duration(
                                                        seconds: 1,
                                                      ),
                                                    ),
                                                  );
                                                },
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.all(4),
                                                  decoration:
                                                      const BoxDecoration(
                                                    color: primaryColor,
                                                    shape: BoxShape.circle,
                                                  ),
                                                  child: const Icon(
                                                    Icons.add,
                                                    color: Colors.white,
                                                    size: 14,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }
}
