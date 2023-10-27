const productModel = require('../models/product_model');
const ProductController = {
    createProduct: async function (req, res) {
        try {
            const productData = req.body;
            const newProduct = new productModel(productData);
            await newProduct.save();
            return res.json({ success: true, data: newProduct, message: "product created" })
        } catch (error) {
            console.log(error)
            return res.json({ success: false, message: "failed to create product", error: error })
        }
    },
    fetchAllProducts: async function (req, res) {
        try {
            const products = await productModel.find();
            return res.json({ success: true, data: products, message: "products fetched" })
        } catch (error) {
            console.log(error)
            return res.json({ success: false, message: "failed to fetch products", error: error })
        }
    },
    fetchProductById: async function (req, res) {
        try {
            const productId = req.params.id;
            const product = await productModel.findById(productId);
            if (!product) {
                return res.json({ success: false, message: "product not found" })
            }
            return res.json({ success: true, data: product, message: "product fetched" })
        } catch (error) {
            console.log(error)
            return res.json({ success: false, message: "failed to fetch product", error: error })
        }
    },
    fetchProductByCategoryId: async function (req, res) {
        try {
            const categoryId = req.params.id;
            const products = await productModel.find({ category: categoryId });
            return res.json({ success: true, data: products, message: "products fetched" })
        } catch (error) {
            console.log(error)
            return res.json({ success: false, message: "failed to fetch products", error: error })
        }
    }
};
module.exports = ProductController;