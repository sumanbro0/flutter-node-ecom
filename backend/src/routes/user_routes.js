const userController = require('../controllers/user_controller');
const userRoutes = require('express').Router();


userRoutes.post('/createAccount', userController.createAccount)
userRoutes.post('/signIn', userController.signIn)
userRoutes.put('/:id', userController.updateUser)

module.exports = userRoutes;