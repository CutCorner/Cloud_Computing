import { Request, Response } from "express";
import firebaseApp from "../../service/firebaseInit";
import prisma from "../../../prisma/prisma";

export async function Register(req: Request, res: Response) {
  const { email, password, name } = req.body;

  try {
    const userRecord = await firebaseApp.auth().createUser({
      email: email,
      password: password,
      displayName: name,
    });

    await prisma.profile.create({
      data: {
        fullName: name,
        role: "USER",
        uid: userRecord.uid,
      },
    });

    console.log("Successfully created new user:", userRecord);
    res.status(200).json({
      message: "User registered successfully",
      result: {
        email: userRecord.email,
        name: userRecord.displayName,
        uid: userRecord.uid,
      },
    });
  } catch (error) {
    console.error("Error creating new user:", error);
    res.status(500).json({ error: error.message });
  }
}

export async function Login(req: Request, res: Response) {
  const { email, password } = req.body;

  try {
    // Melakukan sign in dengan Firebase Authentication
    const userRecord = await firebaseApp.auth().getUserByEmail(email);

    // Jika user ditemukan, coba melakukan sign in
    // await firebaseApp.auth().
    // Sign in berhasil
    console.log("User signed in:", userRecord);
    res.status(200).json({ message: "Sign in successful" });
  } catch (error) {
    // Error saat sign in
    console.error("Error signing in:", error);
    res.status(401).json({ error: "Authentication failed" });
  }
}
