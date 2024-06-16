import { Request, Response } from "express";
import admin from "firebase-admin";
import * as fs from "fs";
import firebaseApp from "../../service/firebaseInit";
import prisma from "../../../prisma/prisma";

const bucket = firebaseApp.storage().bucket();

export async function uploadLogoStore(req: Request, res: Response) {
  console.log(req.file);
  if (!req.file) {
    return res.status(400).json({ message: "Image is required" });
  }

  const blob = bucket.file(req.file.originalname);
  const blobStream = blob.createWriteStream({
    metadata: {
      contentType: req.file.mimetype,
    },
  });

  blobStream.on("error", (err) => {
    res.status(500).send(err);
  });

  blobStream.on("finish", () => {
    console.log("Success upload image to storage");
  });

  blobStream.end(req.file.buffer);

  return res.status(200).json({
    message: "Store image successfully",
    fileName: `${blob.name}`,
  });
}

export async function addOn(req: Request, res: Response) {
  try {
    const { data, uid } = req.body;
    const barbedId = req.headers.barberid;

    const findUser = await prisma.profile.findUnique({
      where: {
        uid: uid,
      },
    });

    if (findUser.role !== "ADMIN") {
      return res.status(403).json({ message: "Unauthorized" });
    }

    const createAddOnMany = await prisma.listAddon.createMany({
      data: data.map((item: any) => {
        return {
          barberId: barbedId,
          name: item.name,
          price: item.price,
        };
      }),
    });

    return res.status(200).json({
      message: "Success add addOns barber",
      result: {
        data,
        count: createAddOnMany.count,
      },
    });
    // console.log(barbedId, data);
  } catch (error) {
    console.log(error);
    return res.status(500).json({ message: "Addon Duplicate" });
  }
}
export async function updateOrder(req: Request, res: Response) {
  try {
    const { id_order, uid, status } = req.body;

    const findUser = await prisma.profile.findUnique({
      where: {
        uid: uid,
      },
    });

    if (findUser.role !== "ADMIN") {
      return res.status(403).json({ message: "Unauthorized" });
    }

    await prisma.orders.update({
      where: {
        id_order: id_order,
      },
      data: {
        status_payment: status,
      },
    });

    return res.status(200).json({
      message: "Success update order",
      result: {
        id_order,
        status,
      },
    });
  } catch (error) {
    console.log(error);
    return res.status(500).json({ message: "Failed update order" });
  }
}
export async function createListModel(req: Request, res: Response) {
  try {
    const { model, uid } = req.body;
    const barbedId = req.headers.barberid;

    const findUser = await prisma.profile.findUnique({
      where: {
        uid: uid,
      },
    });

    if (findUser.role !== "ADMIN") {
      return res.status(403).json({ message: "Unauthorized" });
    }

    const createModelMany = await prisma.listModelSeller.createMany({
      data: model.map((item: any) => {
        return {
          barberId: barbedId,
          name: item,
        };
      }),
    });

    return res.status(200).json({
      message: "Success add list model barber",
      result: {
        data: model,
        count: createModelMany.count,
      },
    });
  } catch (error) {
    console.log(error);
    return res.status(500).json({ message: "List model duplicate" });
  }
}

export async function createBarberStore(req: Request, res: Response) {
  try {
    const idToken = req.headers.authorization;
    // content type : form-data
    const { store_name, lat, long, location, uid } = req.body;

    const findUser = await prisma.profile.findUnique({
      where: {
        uid: uid,
      },
    });

    if (findUser.role == "ADMIN") {
      const nameFile = req.file.originalname;

      const createNewBarber = await prisma.barber.create({
        data: {
          owner: uid,
          img_src: nameFile,
          name: store_name,
          lat: parseFloat(lat),
          long: parseFloat(long),
          location,
        },
      });

      const blob = bucket.file(req.file.originalname);
      const blobStream = blob.createWriteStream({
        metadata: {
          contentType: req.file.mimetype,
        },
      });

      blobStream.on("error", (err) => {
        res.status(500).send(err);
      });

      blobStream.on("finish", () => {
        console.log("Success upload image to storage");
      });

      blobStream.end(req.file.buffer);

      return res.status(200).json({
        message: "Success create new Barber Store",
        result: createNewBarber,
      });
    } else {
      return res.status(403).json({ message: "Unauthorized" });
    }
  } catch (error) {
    console.log(error);
    return res.status(500).json({ message: "Internal server error" });
  }
}
