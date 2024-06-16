/*
  Warnings:

  - You are about to drop the `BarberAdmin` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `ListBarber` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "BarberAdmin" DROP CONSTRAINT "BarberAdmin_uid_fkey";

-- DropForeignKey
ALTER TABLE "Image" DROP CONSTRAINT "Image_id_fkey";

-- DropForeignKey
ALTER TABLE "ListAddon" DROP CONSTRAINT "ListAddon_barberId_fkey";

-- DropForeignKey
ALTER TABLE "ListBarber" DROP CONSTRAINT "ListBarber_barberId_fkey";

-- DropForeignKey
ALTER TABLE "ListModel" DROP CONSTRAINT "ListModel_barberId_fkey";

-- DropForeignKey
ALTER TABLE "Orders" DROP CONSTRAINT "Orders_barberId_fkey";

-- DropForeignKey
ALTER TABLE "Review" DROP CONSTRAINT "Review_barberId_fkey";

-- DropTable
DROP TABLE "BarberAdmin";

-- DropTable
DROP TABLE "ListBarber";

-- CreateTable
CREATE TABLE "Barber" (
    "id" SERIAL NOT NULL,
    "owner" TEXT NOT NULL,
    "barberId" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "lat" DOUBLE PRECISION NOT NULL,
    "long" DOUBLE PRECISION NOT NULL,
    "location" TEXT NOT NULL,

    CONSTRAINT "Barber_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "Barber_barberId_key" ON "Barber"("barberId");

-- AddForeignKey
ALTER TABLE "Barber" ADD CONSTRAINT "Barber_owner_fkey" FOREIGN KEY ("owner") REFERENCES "Profile"("uid") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ListAddon" ADD CONSTRAINT "ListAddon_barberId_fkey" FOREIGN KEY ("barberId") REFERENCES "Barber"("barberId") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Orders" ADD CONSTRAINT "Orders_barberId_fkey" FOREIGN KEY ("barberId") REFERENCES "Barber"("barberId") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ListModel" ADD CONSTRAINT "ListModel_barberId_fkey" FOREIGN KEY ("barberId") REFERENCES "Barber"("barberId") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Image" ADD CONSTRAINT "Image_id_fkey" FOREIGN KEY ("id") REFERENCES "ListModel"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Review" ADD CONSTRAINT "Review_barberId_fkey" FOREIGN KEY ("barberId") REFERENCES "Barber"("barberId") ON DELETE CASCADE ON UPDATE CASCADE;
