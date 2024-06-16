/*
  Warnings:

  - You are about to drop the column `img` on the `Barber` table. All the data in the column will be lost.
  - Added the required column `img_src` to the `Barber` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "Barber" DROP COLUMN "img",
ADD COLUMN     "img_src" TEXT NOT NULL;
