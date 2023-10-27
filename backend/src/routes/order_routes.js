const orderController = require('../controllers/order_controller');
const orderRoutes = require('express').Router();

orderRoutes.post('/', orderController.createOrder);
orderRoutes.get('/:id', orderController.fetchOrderForUser);
orderRoutes.put('/updateStatus', orderController.updateOrderstatus);
module.exports = orderRoutes;