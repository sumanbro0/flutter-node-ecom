// routes for categories
const productController = require('../controllers/product_controller');
const productRoutes = require('express').Router();


productRoutes.post('/', productController.createProduct)
productRoutes.get('/', productController.fetchAllProducts)
productRoutes.get('/:id', productController.fetchProductById)
productRoutes.get('/category/:id', productController.fetchProductByCategoryId)

module.exports = productRoutes;