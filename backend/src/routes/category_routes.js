// routes for categories
const categoryController = require('../controllers/category_controller');
const categoryRoutes = require('express').Router();


categoryRoutes.post('/', categoryController.createCategory)
categoryRoutes.get('/', categoryController.fetchAllCategories)
categoryRoutes.get('/:id', categoryController.fetchCategoryById)

module.exports = categoryRoutes;