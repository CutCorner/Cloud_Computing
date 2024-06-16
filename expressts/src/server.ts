import express, { Application } from "express";
import cors from "cors";

import admin_route from "./routes/admin/admin_route";
import auth_router from "./routes/auth/auth_route";
import { verifyToken } from "./middleware/verifyToken";
import user_routes from "./routes/users/users_route";
// import router from "./Routes/webhook.route";
// import bodyParser from "body-parser";
// import router from "./routes/admin/admin_route";

const app: Application = express();
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

var allowlist = ["http://localhost:3000"];
var corsOptionsDelegate = function (req, callback) {
  var corsOptions;
  if (allowlist.indexOf(req.header("Origin")) !== -1) {
    corsOptions = { origin: true }; // reflect (enable) the requested origin in the CORS response
  } else {
    corsOptions = { origin: false }; // disable CORS for this request
  }
  callback(null, corsOptions); // callback expects two parameters: error and options
};

app.use(cors(corsOptionsDelegate));
// app.use("/", router);
app.use("/api/admin", admin_route);
app.use("/api/auth", auth_router);
app.use("/api/user", user_routes);

app.listen(3000, () => {
  console.log("server running on 3000");
});
