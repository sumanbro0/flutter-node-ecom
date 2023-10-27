// controller for category
// Path: src/controllers/category_controller.js
const categoryModel = require('../models/category_model');
const categoryController = {
    createCategory: async function (req, res) {
        try {
            const categoryData = req.body;
            const newCategory = new categoryModel(categoryData);
            await newCategory.save();
            return res.json({ success: true, data: newCategory, message: "category created" })
        } catch (error) {
            console.log(error)
            return res.json({ success: false, message: "failed to create category", error: error })
        }
    },
    fetchAllCategories: async function (req, res) {
        try {
            const categories = await categoryModel.find();
            return res.json({ success: true, data: categories, message: "categories fetched" })
        } catch (error) {
            console.log(error)
            return res.json({ success: false, message: "failed to fetch categories", error: error })
        }
    },
    fetchCategoryById: async function (req, res) {
        try {
            const categoryId = req.params.id;
            const category = await categoryModel.findById(categoryId);
            if (!category) {
                return res.json({ success: false, message: "category not found" })
            }
            return res.json({ success: true, data: category, message: "category fetched" })
        } catch (error) {
            console.log(error)
            return res.json({ success: false, message: "failed to fetch category", error: error })
        }
    },
}
module.exports = categoryController;
