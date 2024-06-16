import { Request, Response } from "express";
import prisma from "../../../prisma/prisma";

export async function Checkout(req: Request, res: Response) {
  try {
    const { uid, model, price, barberId, addon } = req.body;

    const createOrder = await prisma.orders.create({
      data: {
        id_order: `#${Math.floor(Math.random() * 1000000)}`,
        uid: uid,
        addon: addon.join(","),
        model: model,
        price: price,
        barberId: barberId,
        status_payment: "PENDING",
        reviewByIdOrder: {
          create: {
            uid: uid,
            addon: addon.join(","),
            model: model,
            barberId: barberId,
            comment: "",
            rating: 0,
          },
        },
      },
    });

    return res.status(200).json({
      message: "Success checkout",
      result: createOrder,
    });
  } catch (error) {
    console.log(error);
    return res.status(500).json({ message: "Failed checkout" });
  }
}

export async function Review(req: Request, res: Response) {
  try {
    const { id_order, comment, rating, uid } = req.body;

    if (rating < 1 || rating > 5) {
      return res
        .status(400)
        .json({ message: "Rating must be between 1 and 5" });
    }
    const updateReview = await prisma.review.update({
      where: {
        id_order: id_order,
      },
      data: {
        comment: comment,
        rating: rating,
      },
    });

    return res.status(200).json({
      message: "Success review",
      result: updateReview,
    });
  } catch (error) {
    console.log(error);
    return res.status(500).json({ message: "Failed review" });
  }
}

export async function searchBarber(req: Request, res: Response) {
  const { pages, limits, q } = req.query;

  try {
    const page = parseInt(pages as string) || 1;
    const limit = parseInt(limits as string) || 3;
    const offset = (page - 1) * limit;

    const totalCount = await prisma.barber.count({
      where: {
        name: {
          search: q as string,
        },
      },
    });

    console.log(req.query, "total");

    if (!totalCount) {
      return res.status(404).json({
        message: "Tidak ada hasil pencarian !!",
      });
    }

    const totalPages = Math.ceil(totalCount / limit);
    const hasNext = page < totalPages;

    const barber = await prisma.barber.findMany({
      where: {
        name: {
          search: q as string,
        },
      },
      take: limit,
      skip: offset,
    });

    return res.status(200).json({
      message: "Success get barber",
      result: {
        data: barber,
        totalData: totalCount,
        page: page,
        hasNext: hasNext,
      },
    });
  } catch (error) {
    console.log(error);
    return res.status(500).json({ message: "Failed get barber" });
  }
}

export async function getDetailsBarber(req: Request, res: Response) {
  const { id } = req.query;

  try {
    const barber = await prisma.barber.findUnique({
      where: {
        barberId: id as string,
      },
      include: {
        addons: true,
        modelsHairs: true,
      },
    });

    return res.status(200).json({
      message: "Success get details barber",
      result: barber,
    });
  } catch (error) {
    console.log(error);
    return res.status(500).json({ message: "Failed get details barber" });
  }
}

export async function getReviewBarber(req: Request, res: Response) {
  const { id } = req.query;

  try {
    const barber = await prisma.review.findMany({
      where: {
        barberId: id as string,
      },
      include: {
        review_to_user: true,
      },
    });

    const data = barber.map((item) => {
      return {
        id_order: item.id_order,
        model: item.model,
        addon: item.addon,
        comment: item.comment,
        rating: item.rating,
        user: item.review_to_user.fullName,
        img: item.review_to_user.picture,
      };
    });
    return res.status(200).json({
      message: "Success get details barber",
      result: data,
    });
  } catch (error) {
    console.log(error);
    return res.status(500).json({ message: "Failed get details barber" });
  }
}
