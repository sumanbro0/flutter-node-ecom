const OrderModel = require('../models/order_model');
const CartModel = require('../models/cart_model');
const razorpay = require('./../services/razorpay');

const orderController = {
    // 1. Create order
    createOrder: async (req, res) => {
        try {
            const { user, items, status, totalAmount } = req.body;

            const razorPayOrder = await razorpay.orders.create({
                amount: totalAmount * 100,
                currency: "INR",
            });

            const newOrder = new OrderModel({ user, items, status, totalAmount, razorPayOrderId: razorPayOrder.id });
            await newOrder.save();

            await CartModel.findOneAndUpdate(
                { user: user._id },
                { items: [] },
            )

            res.status(201).json({ success: true, data: newOrder, message: "Order created successfully" });
        } catch (error) {
            res.status(400).json({ success: false, message: "failed to create", error: error.message });
        }
    },
    fetchOrderForUser: async function (req, res) {
        try {
            const { id } = req.params;
            const orders = await OrderModel.find({ "user._id": id }).sort({ createdOn: -1 });
            res.status(200).json({ success: true, data: orders, message: "Orders fetched successfully" });
        } catch (error) {
            res.status(400).json({ success: false, message: "failed to fetch", error: error.message });
        }
    },
    updateOrderstatus: async function (req, res) {
        try {
            const { orderId, status, razorPayPaymentId, razorPaySignature } = req.body;
            const order = await OrderModel.findOneAndUpdate({ _id: orderId }, {
                $set: {
                    status: status,
                    razorPayPaymentId: razorPayPaymentId,
                    razorPaySignature: razorPaySignature,
                }
            }, { new: true });
            res.status(200).json({ success: true, data: order, message: "Order status updated successfully" });
        } catch (error) {
            res.status(400).json({ success: false, message: "failed to update", error: error.message });
        }
    }
};
module.exports = orderController;