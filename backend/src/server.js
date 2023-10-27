const express = require("express");
const bodyParser = require('body-parser');
const helmet = require('helmet');
const morgan = require('morgan');
const cors = require('cors');
const mongoose = require('mongoose');


const app = express();



app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: false }));
app.use(helmet());
app.use(morgan('dev'))
app.use(cors())

mongoose.connect("mongodb://127.0.0.1:27017/ecom");

const userRoutes = require('./routes/user_routes')
app.use("/api/user", userRoutes);

const categoryRoutes = require('./routes/category_routes')
app.use("/api/category", categoryRoutes);

const productRoutes = require('./routes/product_routes')
app.use("/api/product", productRoutes);

const cartRoutes = require('./routes/cart_routes');
app.use("/api/cart", cartRoutes);

const orderRoutes = require("./routes/order_routes");
app.use("/api/order", orderRoutes);

app.get('/', function (req, res) {
    res.json({ success: true, message: "Hello world" });
})


app.listen(5000, () => console.log('Server started at port : 5000'));


