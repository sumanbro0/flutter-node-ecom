const CartModel = require('../models/cart_model');
const cartController = {
    addToCart: async function (req, res) {
        try {
            const { product, user, quantity } = req.body;
            const foundCart = await CartModel.findOne({ user: user });
            if (!foundCart) {
                const newCart = new CartModel({ user: user });
                newCart.items.push({
                    product: product,
                    quantity: quantity
                });
                await newCart.save();
                return res.json({ success: true, message: "added to cart", data: newCart.items });
            }
            const deletedItem = await CartModel.findOneAndUpdate(
                {
                    user: user, "items.product": product,
                },
                {
                    "$pull": { items: { product: product } }
                },
                {
                    new: true
                }
            )
            const updatedCart = await CartModel.findOneAndUpdate({ user: user }, { $push: { items: { product: product, quantity: quantity } } }, { new: true }).populate("items.product");
            return res.json({ success: true, message: "added to cart", data: updatedCart.items });


        } catch (error) {
            console.log(error);
            return res.json({ success: false, message: "failed to add to cart", error: error });
        }
    },
    removeFromCart: async function (req, res) {
        try {
            const { product, user } = req.body;
            const foundCart = await CartModel.findOne({ user: user });
            if (!foundCart) {
                return res.json({ success: false, message: "no cart found" });
            }
            const updatedCart = await CartModel.findOneAndUpdate({ user: user }, { $pull: { items: { product: product } } }, { new: true }).populate("items.product");
            return res.json({ success: true, message: "removed from cart", data: updatedCart.items });
        } catch (error) {
            console.log(error);
            return res.json({ success: false, message: "failed to remove from cart", error: error });
        }
    },
    getCart: async function (req, res) {
        try {
            const id = req.params.id;
            const foundCart = await CartModel.findOne({ user: id }).populate("items.product");
            if (!foundCart) {
                return res.json({ success: true, message: "no cart found", data: [] });
            }
            return res.json({ success: true, message: "cart found", data: foundCart.items });
        } catch (error) {
            console.log(error);
            return res.json({ success: false, message: "failed to get cart", error: error });
        }
    },
}
module.exports = cartController;