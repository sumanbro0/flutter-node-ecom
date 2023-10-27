const userModel = require("../models/User_model");
const bcrypt = require('bcrypt')
const userController = {
    createAccount: async function (req, res) {
        try {
            const userData = req.body;
            const newUser = new userModel(userData)
            await newUser.save();
            return res.json({ success: true, data: newUser, message: "user created" })
        } catch (error) {
            console.log(error)
            return res.json({ success: false, message: "failed to create account", error: error })
        }
    },
    signIn: async function (req, res) {
        try {
            const { email, password } = req.body;
            const foundUser = await userModel.findOne({ email: email });
            if (!foundUser) {
                return res.json({ success: true, message: "User Not Found!" });
            }

            const passwordMatch = bcrypt.compareSync(password, foundUser.password)
            if (!passwordMatch) {
                return res.json({ success: false, message: "Incorrect Password!" });

            }
            // remove password from foundUser
            foundUser.password = undefined
            return res.json({ success: true, data: foundUser });
        } catch (err) {
            console.log(err)
            return res.json({ success: false, error: err });
        }
    },
    updateUser: async function (req, res) {
        try {
            const userId = req.params.id;
            const updateData = req.body;
            const updatedUser = await userModel.findOneAndUpdate(
                { _id: userId },
                updateData,
                { new: true },
            )
            if (!updatedUser) {
                throw "user not found";
            }
            return res.json({ success: true, data: updatedUser, message: "user updated" })


        } catch (ex) {
            return res.json({ success: false, error: err, message: "failed to update" });

        }
    }

}
module.exports = userController;