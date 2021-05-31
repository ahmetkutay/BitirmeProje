const express = require("express");
const router = express.Router();
var MongoClient = require("mongodb").MongoClient;
var mongo = require("mongodb");
var assert = require("assert");

// Film favori listeleme

router.get("/film_favori", function (req, res, err) {
  var query = { kullanici_Id: req.query._id };

  MongoClient.connect(
    process.env.DB_CONNECT,
    { useUnifiedTopology: true },
    function (err, db) {
      var dbo = db.db("test");
      dbo
        .collection("FilmFavori")
        .find(query)
        .toArray(function (err, result) {
          if (err) throw err;
          res.json({
            fav: result,
          });
          db.close();
        });
    }
  );
});

//Film favori alma

router.post("/film_insert_favori", function (req, res, next) {
  var item = {
    kullanici_Id: req.body._id,
    favori_Id: req.body.fav_Id,
    moviename: req.body.moviename,
    imgurl: req.body.imgurl,
    overview: req.body.overview,
    date: req.body.date,
    duration: req.body.duration,
    budget: req.body.budget,
  };

  MongoClient.connect(
    process.env.DB_CONNECT,
    { useUnifiedTopology: true },
    function (err, db) {
      assert.strictEqual(null, err);
      var dbo = db.db("test");
      dbo.collection("FilmFavori").insertOne(item, function (err, result) {
        assert.strictEqual(null, err);
        db.close();
      });
    }
  );
  res.send("Favori Eklendi");
});

// Film favori silme

router.post("/film_delete_favori", function (req, res, next) {
  var query = { favori_Id: req.body.fav_Id };

  MongoClient.connect(
    process.env.DB_CONNECT,
    { useUnifiedTopology: true },
    function (err, db) {
      assert.strictEqual(null, err);
      var dbo = db.db("test");
      dbo.collection("FilmFavori").deleteOne(query, function (err, result) {
        assert.strictEqual(null, err);
        db.close();
      });
    }
  );
  res.redirect("/film_favori");
});

// Kitap favori listeleme

router.get("/kitap_favori", function (req, res, err) {
  var query = { kullanici_Id: req.query._id };

  MongoClient.connect(
    process.env.DB_CONNECT,
    { useUnifiedTopology: true },
    function (err, db) {
      var dbo = db.db("test");
      dbo
        .collection("KitapFavori")
        .find(query)
        .toArray(function (err, result) {
          if (err) throw err;
          res.json({
            fav: result,
          });
          db.close();
        });
    }
  );
});

//Kitap favori alma

router.post("/kitap_insert_favori", function (req, res, next) {
  var item = {
    kullanici_Id: req.body._id,
    favori_Id: req.body.fav_Id,
    moviename: req.body.moviename,
    imgurl: req.body.imgurl,
    overview: req.body.overview,
    date: req.body.date,
    duration: req.body.duration,
    budget: req.body.budget,
  };

  MongoClient.connect(
    process.env.DB_CONNECT,
    { useUnifiedTopology: true },
    function (err, db) {
      assert.strictEqual(null, err);
      var dbo = db.db("test");
      dbo.collection("KitapFavori").insertOne(item, function (err, result) {
        assert.strictEqual(null, err);
        db.close();
      });
    }
  );
  res.redirect("/kitap_favori");
});

// favori silme bakılıcak asserion null error bak

router.post("/favori_delete", function (req, res, next) {
  var query = { kullanici_Id: req.query.kullanici_id };
  var query_2 = { urun_id: req.query.urun_id };
  var mongoId = req.body._id;

  MongoClient.connect(
    process.env.DB_CONNECT,
    { useUnifiedTopology: true },
    function (err, db) {
      assert.strictEqual(null, err);
      var dbo = db.db("test");
      dbo.collection("FilmFavori").find(query, function (err, result) {
        dbo
          .collection("FilmFavori")
          .deleteOne({ _id: mongo.ObjectId(mongoId) }, function (err, result) {
            db.close();
          });
      });

      dbo.collection("DiziFavori").find(query, function (err, result) {
        dbo
          .collection("DiziFavori")
          .deleteOne({ _id: mongo.ObjectId(mongoId) }, function (err, result) {
            db.close();
          });
      });

      dbo.collection("KitapFavori").find(query, function (err, result) {
        dbo
          .collection("KitapFavori")
          .deleteOne({ _id: mongo.ObjectId(mongoId) }, function (err, result) {
            db.close();
          });
      });
    }
  );
  res.send("Seçilen Veri Silindi.");
});

// Dizi favori listeleme

router.get("/dizi_favori", function (req, res, err) {
  var query = { kullanici_Id: req.query._id };

  MongoClient.connect(
    process.env.DB_CONNECT,
    { useUnifiedTopology: true },
    function (err, db) {
      var dbo = db.db("test");
      dbo
        .collection("DiziFavori")
        .find(query)
        .toArray(function (err, result) {
          if (err) throw err;
          res.json({
            fav: result,
          });
          db.close();
        });
    }
  );
});

//Dizi favori alma

router.post("/dizi_insert_favori", function (req, res, next) {
  var item = {
    kullanici_Id: req.body._id,
    favori_Id: req.body.fav_Id,
    moviename: req.body.moviename,
    imgurl: req.body.imgurl,
    overview: req.body.overview,
    date: req.body.date,
    duration: req.body.duration,
    budget: req.body.budget,
  };

  MongoClient.connect(
    process.env.DB_CONNECT,
    { useUnifiedTopology: true },
    function (err, db) {
      assert.strictEqual(null, err);
      var dbo = db.db("test");
      dbo.collection("DiziFavori").insertOne(item, function (err, result) {
        assert.strictEqual(null, err);
        db.close();
      });
    }
  );
  res.redirect("/dizi_favori");
});

// Dizi favori silme

router.post("/dizi_delete_favori", function (req, res, next) {
  var query = { favori_Id: req.body.fav_Id };

  MongoClient.connect(
    process.env.DB_CONNECT,
    { useUnifiedTopology: true },
    function (err, db) {
      assert.strictEqual(null, err);
      var dbo = db.db("test");
      dbo.collection("DiziFavori").deleteOne(query, function (err, result) {
        assert.strictEqual(null, err);
        db.close();
      });
    }
  );
  res.redirect("/dizi_favori");
});

// Yorum listeleme

router.get("/yorum", function (req, res, err) {
  var query = { kullanici_Id: req.query.kullanici_id };

  MongoClient.connect(
    process.env.DB_CONNECT,
    { useUnifiedTopology: true },
    function (err, db) {
      var dbo = db.db("test");
      dbo
        .collection("KullaniciYorum")
        .find(query)
        .toArray(function (err, result) {
          if (err) throw err;
          res.json({
            fav: result,
          });
          db.close();
        });
    }
  );
});

//Ürüm Yorum Listemele

router.get("/urun_yorum", function (req, res, err) {
  var query = { urun_Id: req.query.urun_Id };

  MongoClient.connect(
    process.env.DB_CONNECT,
    { useUnifiedTopology: true },
    function (err, db) {
      var dbo = db.db("test");
      dbo
        .collection("KullaniciYorum")
        .find(query)
        .toArray(function (err, result) {
          if (err) throw err;
          res.json({
            fav: result,
          });
          db.close();
        });
    }
  );
});

//yorum insert apisi

router.post("/yorum_insert", function (req, res, next) {
  var item = {
    kullanici_Id: req.body._id,
    urun_Id: req.body.fav_Id,
    kullanici_name: req.body.kullaniciAdi,
    kullanici_Yorum: req.body.yorum,
  };

  MongoClient.connect(
    process.env.DB_CONNECT,
    { useUnifiedTopology: true },
    function (err, db) {
      assert.strictEqual(null, err);
      var dbo = db.db("test");
      dbo.collection("KullaniciYorum").insertOne(item, function (err, result) {
        assert.strictEqual(null, err);
        db.close();
      });
    }
  );
  res.redirect("/yorum");
});

// yorum silme apisi

router.post("/yorum_delete", function (req, res, next) {
  var query = { yorum_Id: req.query.kullanici_id };
  var mongoId = req.body._id;

  MongoClient.connect(
    process.env.DB_CONNECT,
    { useUnifiedTopology: true },
    function (err, db) {
      assert.strictEqual(null, err);
      var dbo = db.db("test");
      dbo.collection("KullaniciYorum").find(query, function (err, result) {
        dbo
          .collection("KullaniciYorum")
          .deleteOne({ _id: mongo.ObjectId(mongoId) }, function (err, result) {
            assert.strictEqual(null, err);
            db.close();
          });
      });
      res.redirect("/yorum");
    }
  );
});

// yorum update api

router.post("/yorum_update", function (req, res, next) {
  var item = {
    kullanici_Id: req.body.kullanici_id,
    urun_Id: req.body.fav_Id,
    kullanici_name: req.body.kullaniciAdi,
    kullanici_Yorum: req.body.yorum,
  };

  var mongoId = req.body._id;

  MongoClient.connect(
    process.env.DB_CONNECT,
    { useUnifiedTopology: true },
    function (err, db) {
      assert.strictEqual(null, err);
      var dbo = db.db("test");
      dbo
        .collection("KullaniciYorum")
        .updateOne(
          { _id: mongo.ObjectId(mongoId) },
          { $set: item },
          function (err, result) {
            assert.strictEqual(null, err);
            db.close();
          }
        );
    }
  );
  res.redirect("/yorum");
});

router.get("/tweet", function (req, res, err) {
  MongoClient.connect(
    process.env.DB_CONNECT,
    { useUnifiedTopology: true },
    function (err, db) {
      if (err) throw err;
      var dbo = db.db("test");
      var tweet = dbo.collection("tweet");

      tweet.find({}).sort({_id:-1}).toArray(function (err, result) {
        if (err) throw err;
        res.json({
          tweets: result,
        });
        db.close();
      });
    }
  );
});

router.post("/tweet_insert", function (req, res, next) {
  var query = { TYPE: req.query.type };
  var tweetId = { tweetId_id: req.query.tweet_Id };
  var mongoId = req.body._id;

  var item = {
    kullanici_Id: req.body._id,
    kullanici_name: req.body.kullaniciAdi,
    kullanici_tweet: req.body.tweet,
  };

  var updatedItem = {
    kullanici_tweet: req.body.tweet,
  };

  MongoClient.connect(
    process.env.DB_CONNECT,
    { useUnifiedTopology: true },
    function (err, db) {
      assert.strictEqual(null, err);
      var dbo = db.db("test");
      if (query.TYPE === "INSERT") {
        dbo.collection("tweet").insertOne(item, function (err, result) {
          assert.strictEqual(null, err);
          db.close();
        });
        res.send("Veri Eklendi.");
      }

      if (query.TYPE === "DELETE") {
        dbo.collection("tweet").find(tweetId, function (err, result) {
          dbo
            .collection("tweet")
            .deleteOne(
              { _id: mongo.ObjectId(mongoId) },
              function (err, result) {
                db.close();
              }
            );
        });
        res.send("Seçilen Veri Silindi.");
      }

      if (query.TYPE === "UPDATE") {
        dbo.collection("tweet").find(tweetId, function (err, result) {
          dbo
            .collection("tweet")
            .updateOne(
              { _id: mongo.ObjectId(mongoId) },
              { $set: updatedItem },
              function (err, result) {
                assert.strictEqual(null, err);
                db.close();
              }
            );
        });
        res.send("Seçilen Veri Güncellendi.");
      }
    }
  );
});

router.get("/tweet", function (req, res, err) {
  var tweet_Id = { kullanici_Id: req.query.id };

  MongoClient.connect(
    process.env.DB_CONNECT,
    { useUnifiedTopology: true },
    function (err, db) {
      var dbo = db.db("test");
      dbo
        .collection("tweet")
        .find({ kullanici_Id: tweet_Id.kullanici_Id })
        .toArray(function (err, result) {
          if (err) throw err;
          let myArray = [];
          for (let index = result.length - 1; index > 0; index--) {
            myArray.push(result[index]);
          }
          res.json({
            tweet: myArray,
          });

          db.close();
        });
    }
  );
});

router.post("/insert_follow", async function (req, res, next) {
  var query = { TYPE: req.query.type };
  var followedItem = {
    kullanici_Id: req.body.kullanici_Id,
    followed_user_Id: req.body.followed_user_Id,
    kullanici_Adi: req.body.kullanici_Adi,
  };

  MongoClient.connect(
    process.env.DB_CONNECT,
    { useUnifiedTopology: true },
    function (err, db) {
      assert.strictEqual(null, err);
      var dbo = db.db("test");
      if (query.TYPE === "FOLLOW") {
        var followers = dbo.collection("followers");
        var followed = dbo.collection("followed");
        var users = dbo.collection("users");
        
        followed.insertOne(followedItem, function (err, result) {if(err) throw err;});

        users.find({_id:mongo.ObjectId(followedItem.kullanici_Id)}).toArray(function (err,result) {
            if(err) throw err;
            followers.insertOne({kullanici_Id:followedItem.kullanici_Id,followed_user_Id:followedItem.followed_user_Id,kullanici_Adi:result[0].name},function (err,res) {
              if(err) throw err;
            });
        })      

        res.send("Veri Eklendi.");
      }
    }
  );
});

router.post("/delete_follow", function (req, res, next) {
  var query = { TYPE: req.query.type };
  var mongoId = req.body._id;
  var kullanici_Id = { kullanici_Id: req.body.kullanici_Id };
  var followed_user_Id = { followed_user_Id: req.body.followed_user_Id };

  MongoClient.connect(
    process.env.DB_CONNECT,
    { useUnifiedTopology: true },
    function (err, db) {
      assert.strictEqual(null, err);
      var dbo = db.db("test");
      var followed = dbo.collection("followed");
      var followers = dbo.collection("followers");

      if (query.TYPE === "DELETE") {
        followers.deleteOne(
          {
            kullanici_Id: kullanici_Id.kullanici_Id,
            followed_user_Id: followed_user_Id.followed_user_Id,
          },
          function (err, res) {
            if (err) throw err;
          }
        );

        followed.deleteOne(
          { _id: mongo.ObjectId(mongoId) },
          function (err, result) {}
        );
        res.send("Veri Silindi.");
      }
    }
  );
});

router.get("/followers", function (req, res, err) {
  var kullanici_Id = { kullanici_Id: req.query.kullanici_Id };

  MongoClient.connect(
    process.env.DB_CONNECT,
    { useUnifiedTopology: true },
    function (err, db) {
      var dbo = db.db("test");
      var followers = dbo.collection("followers");

      followers
        .find({ followed_user_Id: kullanici_Id.kullanici_Id })
        .toArray(function (err, result) {
          if (err) throw err;

          res.json({
            followers: result,
          });
          db.close();
        });
    }
  );
});

router.get("/followed", function (req, res, err) {
  var kullanici_Id = { kullanici_Id: req.query.kullanici_Id };

  MongoClient.connect(
    process.env.DB_CONNECT,
    { useUnifiedTopology: true },
    function (err, db) {
      var dbo = db.db("test");
      dbo
        .collection("followed")
        .find({ kullanici_Id: kullanici_Id.kullanici_Id })
        .toArray(function (err, result) {
          if (err) throw err;

          res.json({
            followed: result,
          });
          db.close();
        });
    }
  );
});

router.get("/followedusers_tweet", function (req, res, err) {
  var kullanici_Id = { kullanici_Id: req.query.kullanici_Id };
  MongoClient.connect(
    process.env.DB_CONNECT,
    { useUnifiedTopology: true },
    function (err, db) {
      var dbo = db.db("test");
      let users = dbo.collection("followed");
      let tweets = dbo.collection("tweet");
      users
        .find({ kullanici_Id: kullanici_Id.kullanici_Id })
        .toArray(function (err, userResult) {
          if (err) throw err;

          userResult.map(
            (followed_user) => 
             tweets
                .find({ kullanici_Id: followed_user.followed_user_Id })
                .toArray(function (err, tweetResult) {
                  if(err) throw err;
                  let myArray = [];
                  for (let index = tweetResult.length - 1; index > 0; index--) {
                    myArray.push(tweetResult[index]);
                  }
                  res.json({
                    followedTweet: myArray,
                  });
                  db.close();
                })
          );
        });
    }
  );
});

/*router.post("/like_and_dislike", function (req, res, next) {
  var query = { TYPE: req.query.type };
  var kullanici_Id = { kullanici_Id: req.body.kullanici_Id };
  var content_Id = { content_Id: req.body.content_Id };
  var category = {category:req.body.category}

  MongoClient.connect(
    process.env.DB_CONNECT,
    { useUnifiedTopology: true },
    function (err, db) {
      assert.strictEqual(null, err);
      var dbo = db.db("test");
      var followed = dbo.collection("followed");
      var followers = dbo.collection("followers");

      if (query.TYPE === "LIKE") {
        followers.deleteOne(
          {
            kullanici_Id: kullanici_Id.kullanici_Id,
            followed_user_Id: followed_user_Id.followed_user_Id,
          },
          function (err, res) {
            if (err) throw err;
          }
        );

        followed.deleteOne(
          { _id: mongo.ObjectId(mongoId) },
          function (err, result) {}
        );
        res.send("Ürün Beğenildi.");
      }
      else if (query.TYPE === "DISLIKE") {
        followers.deleteOne(
          {
            kullanici_Id: kullanici_Id.kullanici_Id,
            followed_user_Id: followed_user_Id.followed_user_Id,
          },
          function (err, res) {
            if (err) throw err;
          }
        );

        followed.deleteOne(
          { _id: mongo.ObjectId(mongoId) },
          function (err, result) {}
        );
        res.send("Ürünü Beğenmekten Vazgeçildi.");
      }
    }
  );
});*/

module.exports = router;