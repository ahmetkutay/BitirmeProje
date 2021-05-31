const express = require("express");
const mongoose = require("mongoose");
const bodyparser = require("body-parser");
const cookieParser = require("cookie-parser");
const dotenv = require("dotenv");

const app = express();
// app use
app.use(bodyparser.urlencoded({ extended: false }));
app.use(bodyparser.json());
app.use(cookieParser());

// database connection
dotenv.config();

mongoose.connect(
  process.env.DB_CONNECT,
  {
    useUnifiedTopology: true,
    useNewUrlParser: true,
  },
  () => console.log("connected db")
);

app.get("/", function (req, res) {
  res.status(200).send(`Bitirme Ödevimize Hoşgeldiniz`);
});

// listening port
const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`app is live at ${PORT}`);
});


app.use("/api",require("./Sites/Login/login"))
app.use("/api/category",require("./Sites/category/category"))
app.use("/api/users",require("./Sites/users/users"))