const cartController = require('../controllers/cart_controller');
const cartRoutes = require('express').Router();

cartRoutes.post('/', cartController.addToCart);
cartRoutes.delete('/', cartController.removeFromCart);
cartRoutes.get('/:id', cartController.getCart);
module.exports = cartRoutes;