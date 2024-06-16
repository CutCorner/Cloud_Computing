-- CreateEnum
CREATE TYPE "Role" AS ENUM ('ADMIN', 'USER');

-- CreateEnum
CREATE TYPE "Status" AS ENUM ('PENDING', 'SUCCESS', 'CANCEL');

-- CreateTable
CREATE TABLE "Profile" (
    "id" SERIAL NOT NULL,
    "uid" TEXT NOT NULL,
    "role" "Role" NOT NULL,
    "fullName" TEXT NOT NULL,
    "picture" TEXT,

    CONSTRAINT "Profile_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "BarberAdmin" (
    "id" SERIAL NOT NULL,
    "uid" TEXT NOT NULL,
    "barberId" TEXT NOT NULL,

    CONSTRAINT "BarberAdmin_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ListBarber" (
    "id" SERIAL NOT NULL,
    "barberId" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "lat" DOUBLE PRECISION NOT NULL,
    "long" DOUBLE PRECISION NOT NULL,
    "location" TEXT NOT NULL,

    CONSTRAINT "ListBarber_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ListAddon" (
    "id" SERIAL NOT NULL,
    "barberId" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "price" DOUBLE PRECISION NOT NULL,

    CONSTRAINT "ListAddon_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Orders" (
    "id" SERIAL NOT NULL,
    "uid" TEXT NOT NULL,
    "model" TEXT NOT NULL,
    "addon" TEXT NOT NULL,
    "price" DOUBLE PRECISION NOT NULL,
    "barberId" TEXT NOT NULL,
    "status_payment" "Status" NOT NULL,

    CONSTRAINT "Orders_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ListModel" (
    "id" SERIAL NOT NULL,
    "barberId" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "price" DOUBLE PRECISION NOT NULL,

    CONSTRAINT "ListModel_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Image" (
    "id" SERIAL NOT NULL,
    "url" TEXT NOT NULL,
    "barberId" TEXT NOT NULL,

    CONSTRAINT "Image_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Review" (
    "id" SERIAL NOT NULL,
    "uid" TEXT NOT NULL,
    "barberId" TEXT NOT NULL,
    "comment" TEXT NOT NULL,
    "rating" DOUBLE PRECISION NOT NULL,
    "model" TEXT NOT NULL,
    "addon" TEXT NOT NULL,
    "date" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Review_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "Profile_uid_key" ON "Profile"("uid");

-- CreateIndex
CREATE UNIQUE INDEX "BarberAdmin_barberId_key" ON "BarberAdmin"("barberId");

-- AddForeignKey
ALTER TABLE "ListBarber" ADD CONSTRAINT "ListBarber_barberId_fkey" FOREIGN KEY ("barberId") REFERENCES "BarberAdmin"("barberId") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ListAddon" ADD CONSTRAINT "ListAddon_barberId_fkey" FOREIGN KEY ("barberId") REFERENCES "BarberAdmin"("barberId") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Orders" ADD CONSTRAINT "Orders_barberId_fkey" FOREIGN KEY ("barberId") REFERENCES "BarberAdmin"("barberId") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ListModel" ADD CONSTRAINT "ListModel_barberId_fkey" FOREIGN KEY ("barberId") REFERENCES "BarberAdmin"("barberId") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Image" ADD CONSTRAINT "Image_id_fkey" FOREIGN KEY ("id") REFERENCES "ListModel"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Review" ADD CONSTRAINT "Review_uid_fkey" FOREIGN KEY ("uid") REFERENCES "Profile"("uid") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Review" ADD CONSTRAINT "Review_barberId_fkey" FOREIGN KEY ("barberId") REFERENCES "BarberAdmin"("barberId") ON DELETE RESTRICT ON UPDATE CASCADE;
