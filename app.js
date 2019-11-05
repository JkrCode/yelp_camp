var express     = require("express"),
    app         = express(),
    bodyParser  = require("body-parser"),
    mongoose    = require("mongoose"),
    Campground  = require("./models/campground"),
    Comment     = require("./models/comment"),
    seedDB      = require("./seeds"),
	passport 	= require("passport"),
	localStrategy = require("passport-local"),
	User 		= require("./models/user"),
	methodOverride= require("method-override")
//Requiring Routes
var commentRoutes	 = require("./routes/comments");
var campgroundRoutes = require("./routes/campgrounds");
var indexRoutes 		= require("./routes/index");
    
//SetUp App
mongoose.connect("mongodb+srv://dbUser:<Saturn!123>@cluster0-m6jjh.mongodb.net/test?retryWrites=true&w=majority",{useNewUrlParser: true})
app.use(methodOverride("_method"))
app.use(bodyParser.urlencoded({extended: true}));
app.use(express.static(__dirname + "/public"));
app.set("view engine", "ejs");

// Seed the Database
//seedDB();


//Passport Configuration
app.use(require("express-session")({
	secret:"Once again Rusty wins cutest dog!",
	resave:false,
	saveUninitialized:false
}))
app.use(passport.initialize());
app.use(passport.session());
passport.use(new localStrategy(User.authenticate()));
passport.serializeUser(User.serializeUser());
passport.deserializeUser(User.deserializeUser());
app.use(function(req, res, next){
	res.locals.currentUser = req.user;
	next();
})
app.use("/", indexRoutes);
app.use("/campgrounds", campgroundRoutes);
app.use("/campgrounds/:id/comments", commentRoutes);

//Start Server
app.listen(3000, function(){
   console.log("The YelpCamp Server Has Started!");
});