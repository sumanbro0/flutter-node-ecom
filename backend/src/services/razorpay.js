const razorpay = require('razorpay');
const instance = new razorpay({
    key_id: "rzp_test_tEqNZlBqO5bwyI",
    key_secret: "aqxXBN62gy6iuM6jXwn5M6jv",
});
module.exports = instance;