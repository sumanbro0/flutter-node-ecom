const { Schema, model } = require('mongoose');
//create category model
const categorySchema = new Schema({
    title: { type: String, required: [true, 'title is required'] },
    description: { type: String, default: '' },
    updatedOn: { type: Date },
    createdOn: { type: Date },
});

// pre and update category model
categorySchema.pre('save', function (next) {
    this.updatedOn = new Date();
    this.createdOn = new Date();
    next();
})
categorySchema.pre(['update', 'updateOne', 'findOneAndUpdate'], function (next) {
    const update = this.getUpdate();
    delete update._id;
    this.updatedOn = new Date;
    next();
})



//export category model
const categoryModel = model('Category', categorySchema);
module.exports = categoryModel;
