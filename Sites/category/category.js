const express = require("express");
const router = express.Router();
var MongoClient = require("mongodb").MongoClient;

// Film Api

router.get("/film", function (req, res, err) {
    MongoClient.connect(
      process.env.DB_CONNECT,
      { useUnifiedTopology: true },
      function (err, db) {
        if (err) throw err;
        var dbo = db.db("test");
        dbo
          .collection("Category")
          .find({})
          .toArray(function (err, result) {
            if (err) throw err;
            res.json({
              cat: result,
            });
            db.close();
          });
      }
    );
  });
  
  // Dizi Api
  
  router.get("/dizi", function (req, res, err) {
    MongoClient.connect(
      process.env.DB_CONNECT,
      { useUnifiedTopology: true },
      function (err, db) {
        if (err) throw err;
        var dbo = db.db("test");
        dbo
          .collection("Diziler")
          .find({})
          .toArray(function (err, result) {
            if (err) throw err;
            res.json({
              cat: result,
            });
            db.close();
          });
      }
    );
  });
  
  // Kitap Api
  
  router.get("/kitap", function (req, res, err) {
    MongoClient.connect(
      process.env.DB_CONNECT,
      { useUnifiedTopology: true },
      function (err, db) {
        if (err) throw err;
        var dbo = db.db("test");
        dbo
          .collection("Kitaplar")
          .find({})
          .toArray(function (err, result) {
            if (err) throw err;
            res.json({
              cat: result,
            });
            db.close();
          });
      }
    );
  });

  module.exports=router;