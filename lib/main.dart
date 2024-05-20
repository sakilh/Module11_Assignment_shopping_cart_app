import 'package:flutter/material.dart';

class Product {
  String name;
  String color;
  String size;
  double price;
  int quantity;

  Product({
    required this.name,
    required this.color,
    required this.size,
    required this.price,
    this.quantity = 1, // Set initial quantity to 1
  });

  double get totalPrice => price * quantity;

  // Add a method to display the initial price
  String get initialPrice => '\$${price.toStringAsFixed(2)}';
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Bag',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ProductList(),
    );
  }
}

class ProductList extends StatefulWidget {
  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  final List<String> imageUrls = [
    'https://s3-alpha-sig.figma.com/img/6e2a/6075/d2aebb9b52db31deea621f309362bab4?Expires=1716768000&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=INX31Oi4omLO5svWjEQ~8CKbCVxDhiX6BwoxnRGHzC1E8qEJ039D1SS6XWN1oxnhbe3wQEWuvsVRE-pCSXfy3lVTdHjCgJ5C9b053Brs63k42cZ~LKbNd4WRq5l52MxWISTaJTDX9PiuwbXqgpJdAf6VKDw86XxZv~g2~0GfTiYelEbpgvobPtshSgN03zc~TFm1~YpVbXH-qH2abE~kr25CFXA4XCdPDPGfPsc9C~fealda~FRWWMTHGpRjYnWgisfJEBieqUia7ZbLThAzqUseeyp9TJYq59NEA1DMOBtwArZ0UQyec6Zma4Gs1Ce02Psplqe~609ryahVZyj9QQ__',
    'https://s3-alpha-sig.figma.com/img/5e93/8ec8/ffc8353c2e4119cf43ecf6db7e381d9d?Expires=1716768000&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=AOW41X2lZLKhWJbYWBA~lsERRXbNpPH~z8OVng-N8F1OK9gyL1PgwEUz5WBua2uuj7rW4Z92kLtSGMxgLWtkky0RpRctYr5mMHZFPTl7Tm4C8xvK51CeRgn5Nzv3kPSp1lnonfMGBFPvjWMkjONpQEo-XkRvnG9CzKA6R9~IEsx4lkPrFRlnMGsKVoWowoE0jX~mVsr~sQcINviFql2PkaWvpFXm1AjCZPRUPK8UzjtILEi7ACkdBCyJrN9cZKAApiqUDWAP~9GVERsYTqSJ6kIrlElJbsx2qtPGekHLFOf4VNyZijDLIP~l2wsjtcD35zTLMOlFpD4xeGL~j8R6IQ__',
    'https://s3-alpha-sig.figma.com/img/1821/5f62/e259b4c9081785e2fb7f4b553d1a8023?Expires=1716768000&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=V2cNFYhw-GsKjP2xFh73rGAH7UQqjpryJ3n4C0A~lLqd1g8CBzjsdCHBLaEokxbgN8r5xvY74yBlit8e1oVcynIuI0IDZy0RW8WmMuL4mUqMIOFVs~QcWd9C721fHMHjKasXvTtDfnHNxDzNvF24kQ3LXdgJfa8BLGizFI-dOA1gifHxmeUFpI~iDn7KFc4zmZ2TEFxmYZk1Bq4ZiOb8xGgsOb0tcT2z7SgCrQO683uneLCqzJ3F6eyk7PGP5tux9r4oueAX4954RpYTAs5~8q13e3vDoNR83LbffgHe5gQ9~gvosnUdmmsyMX~AnY-D5ZBlIzjjHhlYUDznJ4pLWw__',
  ];

  List<Product> products = [
    Product(name: 'Pullover', color: 'Black', size: 'L', price: 51.0),
    Product(name: 'T-Shirt', color: 'Gray', size: 'L', price: 30.0),
    Product(name: 'Sport Dress', color: 'Black', size: 'M', price: 43.0),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Bag'),
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (BuildContext context, int index) {
          return _buildProductCard(products[index]);
        },
      ),
    );
  }

  void _showCongratulationsDialog(Product product) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Congratulations!'),
          content: Text('You have added\n5\n${product.name} on your bag!'),
          actions: [
            TextButton(
              child: Text('OKAY'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildProductCard(Product product) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Image.network(
                imageUrls[products.indexOf(product)],
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              flex: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(product.name),
                  Text('Color: ${product.color}, Size: ${product.size}'),
                  Text('Price: ${product.initialPrice}'), // Display initial price
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.remove),
                        onPressed: () {
                          setState(() {
                            if (product.quantity > 1) {
                              product.quantity--;
                            }
                          });
                        },
                      ),
                      Text('${product.quantity}'),
                      IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () {
                          setState(() {
                            if (product.quantity < 5) {
                              product.quantity++;
                            }
                            if (product.quantity == 5) {
                              _showCongratulationsDialog(product);
                            }
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Text('\$${product.totalPrice.toStringAsFixed(2)}'),
            ),
          ],
        ),
      ),
    );
  }
}
