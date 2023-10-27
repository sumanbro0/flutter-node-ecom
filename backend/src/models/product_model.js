const { Schema, model } = require('mongoose');
//create category model
const productSchema = new Schema({
    category: { type: Schema.Types.ObjectId, ref: 'Category', required: [true, 'category is required'] },
    title: { type: String, required: [true, 'title is required'] },
    description: { type: String, default: '' },
    price: { type: Number, required: true, },
    images: { type: Array, default: [] },
    updatedOn: { type: Date },
    createdOn: { type: Date },
});

// pre and update product model
productSchema.pre('save', function (next) {
    this.updatedOn = new Date();
    this.createdOn = new Date();
    next();
})
productSchema.pre(['update', 'updateOne', 'findOneAndUpdate'], function (next) {
    const update = this.getUpdate();
    delete update._id;
    this.updatedOn = new Date;
    next();
})



//export category model
const productModel = model('Product', productSchema);
module.exports = productModel;
