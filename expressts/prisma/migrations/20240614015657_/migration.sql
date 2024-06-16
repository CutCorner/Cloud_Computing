/*
  Warnings:

  - Added the required column `img` to the `Barber` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "Image" DROP CONSTRAINT "Image_barberId_fkey";

-- AlterTable
ALTER TABLE "Barber" ADD COLUMN     "img" TEXT NOT NULL;
