import 'package:flutter/material.dart';
import 'package:myshop/providers/product.dart';
import 'package:myshop/providers/products.dart';
// import 'package:myshop/widgets/drawer.dart';
import 'package:provider/provider.dart';

class EditProductScreen extends StatefulWidget {
  const EditProductScreen({Key? key}) : super(key: key);
  static const routeName = '/edit-product';
  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _imageFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  var _editedProduct = Product(
    id: '',
    description: '',
    imageUrl: '',
    price: 0,
    title: '',
    isFavourite: false,
  );
  var _isInit = true;

  Map<String, dynamic> _initValues = {
    'title': '',
    'description': '',
    'price': 0,
    'imageUrl': '',
  };

  @override
  void dispose() {
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlController.dispose();
    _imageFocusNode.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _imageFocusNode.addListener(() {
      _updateUrlListener();
    });
    super.initState();
  }

  void _updateUrlListener() {
    if (!_imageFocusNode.hasFocus &&
        !_checkUrlImage(_imageUrlController.text)) {
      setState(() {});
    }
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final pushRouteArgs =
          ModalRoute.of(context)?.settings.arguments as String?;
      if (pushRouteArgs != null) {
        final product = Provider.of<Products>(context).findById(pushRouteArgs);
        _editedProduct = product;
        _initValues = {
          'title': _editedProduct.title,
          'description': _editedProduct.description,
          'price': _editedProduct.price,
          // 'imageUrl': _editedProduct.imageUrl,
        };
        _imageUrlController.text = _editedProduct.imageUrl;
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  void _saveForm(BuildContext context) {
    final isAllValid = _form.currentState!.validate();
    if (!isAllValid) {
      return;
    }
    _form.currentState?.save();
    if (_editedProduct.id.isEmpty) {
      Provider.of<Products>(context, listen: false).addProduct(_editedProduct);
    } else {
      Provider.of<Products>(context, listen: false)
          .updateProduct(_editedProduct.id, _editedProduct);
    }
    Navigator.of(context).pop();
  }

  bool _checkUrlImage(String url) {
    RegExp urlPattern = RegExp(
        r'^https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&//=]*)$');
    if (!urlPattern.hasMatch(url)) {
      return false;
    }
    // if (!url.startsWith('http') && !url.startsWith('https')) {
    //   return false;
    // }
    if (!url.endsWith('.png') &&
        !url.endsWith('.jpg') &&
        !url.endsWith('.jpeg')) {
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit product'),
        actions: [
          IconButton(
              onPressed: () => _saveForm(context),
              icon: const Icon(Icons.save_rounded))
        ],
      ),
      // drawer: const SideDrawer(),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _form,
            child: ListView(
              children: <Widget>[
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Title'),
                  textInputAction: TextInputAction.next,
                  initialValue: _initValues['title'],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'This field is required';
                    }
                    return null;
                  },
                  onFieldSubmitted: (_) =>
                      FocusScope.of(context).requestFocus(_priceFocusNode),
                  onSaved: ((newValue) => _editedProduct = Product(
                        id: _editedProduct.id,
                        description: _editedProduct.description,
                        imageUrl: _editedProduct.imageUrl,
                        price: _editedProduct.price,
                        title: newValue!,
                        isFavourite: _editedProduct.isFavourite,
                      )),
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Price'),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  focusNode: _priceFocusNode,
                  initialValue: _initValues['price'].toString(),
                  validator: ((value) {
                    if (value == null || value.isEmpty) {
                      return 'This field is required';
                    }
                    // RegExp regExp = RegExp(r'^[0-9]+$');
                    // if (!regExp.hasMatch(value)) {
                    //   return 'Invalid number';
                    // }

                    if (double.tryParse(value) == null) {
                      return 'Invalid number';
                    }
                    if (double.parse(value) <= 0) {
                      return 'Invalid number';
                    }
                    return null;
                  }),
                  onFieldSubmitted: (_) => FocusScope.of(context)
                      .requestFocus(_descriptionFocusNode),
                  onSaved: ((newValue) => _editedProduct = Product(
                        id: _editedProduct.id,
                        description: _editedProduct.description,
                        imageUrl: _editedProduct.imageUrl,
                        price: double.parse(newValue!),
                        title: _editedProduct.title,
                        isFavourite: _editedProduct.isFavourite,
                      )),
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Desciption'),
                  // textInputAction: TextInputAction.next,
                  initialValue: _initValues['description'],
                  maxLines: 3,
                  keyboardType: TextInputType.multiline,
                  focusNode: _descriptionFocusNode,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'This field is required!';
                    }
                    if (value.length < 20) {
                      return 'Content must be long!';
                    }
                    return null;
                  },
                  onSaved: ((newValue) => _editedProduct = Product(
                        id: _editedProduct.id,
                        description: newValue!,
                        imageUrl: _editedProduct.imageUrl,
                        price: _editedProduct.price,
                        title: _editedProduct.title,
                        isFavourite: _editedProduct.isFavourite,
                      )),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      width: 100,
                      height: 100,
                      margin: const EdgeInsets.only(top: 8, right: 10),
                      child: _imageUrlController.text.isEmpty &&
                              !_checkUrlImage(_imageUrlController.text)
                          ? const Text(
                              'Enter a url',
                              textAlign: TextAlign.center,
                            )
                          : FittedBox(
                              child: Image.network(
                                _imageUrlController.text,
                                fit: BoxFit.cover,
                              ),
                            ),
                    ),
                    Expanded(
                      child: TextFormField(
                        decoration:
                            const InputDecoration(labelText: 'Image url'),
                        keyboardType: TextInputType.url,
                        textInputAction: TextInputAction.done,
                        controller: _imageUrlController,
                        validator: ((value) {
                          if (value == null || value.isEmpty) {
                            return 'This field is required!';
                          }
                          if (!_checkUrlImage(value)) {
                            return 'Invalid url image!';
                          }
                          return null;
                        }),
                        onEditingComplete: () => setState(() {}),
                        focusNode: _imageFocusNode,
                        onFieldSubmitted: (_) => _saveForm(context),
                        onSaved: ((newValue) => _editedProduct = Product(
                              id: _editedProduct.id,
                              description: _editedProduct.description,
                              imageUrl: newValue!,
                              price: _editedProduct.price,
                              title: _editedProduct.title,
                              isFavourite: _editedProduct.isFavourite,
                            )),
                      ),
                    )
                  ],
                )
              ],
            ),
          )),
    );
  }
}
