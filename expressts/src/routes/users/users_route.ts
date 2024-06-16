import express from "express";

import { verifyToken } from "../../middleware/verifyToken";
import {
  Checkout,
  Review,
  getDetailsBarber,
  getReviewBarber,
  searchBarber,
} from "../../controllers/users/users_controller";

const user_routes = express.Router();

user_routes.get("/", (req, res) => {
  res.json({ message: "Hello from the server!" });
});

user_routes.post("/checkout", verifyToken, Checkout);
user_routes.post("/addReview", verifyToken, Review);
user_routes.get("/getBarberStore", verifyToken, searchBarber);
user_routes.get("/getDetailsBarber", verifyToken, getDetailsBarber);
user_routes.get("/getReviewBarber", verifyToken, getReviewBarber);

// auth routes
export default user_routes;
