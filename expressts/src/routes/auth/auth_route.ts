import express from "express";

import { Login, Register } from "../../controllers/auth/auth_controller";

const auth_router = express.Router();

auth_router.get("/", (req, res) => {
  res.json({ message: "Hello from the server!" });
});

// auth routes
auth_router.post("/register", Register);
auth_router.post("/login", Login);

// auth routes
export default auth_router;
