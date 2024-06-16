import { NextFunction, Request, Response } from "express";
import firebaseApp from "../service/firebaseInit";

export async function verifyToken(
  req: Request,
  res: Response,
  next: NextFunction
) {
  const idToken = req.headers.authorization;

  try {
    const token = idToken?.split(" ");
    const decodedToken = await firebaseApp.auth().verifyIdToken(token[1]);
    console.log(decodedToken, "verifyToken");
    req.body.uid = decodedToken.user_id;

    next();
  } catch (error) {
    console.error("Error verifying token:", error);
    res.status(403).json({ error: "Unauthorized" });
  }
}
