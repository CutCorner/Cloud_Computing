import express from "express";
import {
  addOn,
  createBarberStore,
  createListModel,
  updateOrder,
  uploadLogoStore,
} from "../../controllers/admin/admin_controller";
import multer from "multer";
import firebaseApp from "../../service/firebaseInit";
import { verifyToken } from "../../middleware/verifyToken";

const admin_route = express.Router();

const upload = multer({
  storage: multer.memoryStorage(),
});

admin_route.get("/", (req, res) => {
  res.json({ message: "Hello from the server!" });
});

// admin routes

admin_route.post(
  "/create_store_barber",
  upload.single("logo"),
  verifyToken,
  createBarberStore
);
admin_route.post("/add_list_model", verifyToken, createListModel);
admin_route.post("/addon", verifyToken, addOn);
admin_route.post("/updateOrder", verifyToken, updateOrder);

// auth routes
export default admin_route;
