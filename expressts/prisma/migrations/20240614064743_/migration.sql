/*
  Warnings:

  - You are about to drop the column `barberId` on the `ListModel` table. All the data in the column will be lost.

*/
-- DropForeignKey
ALTER TABLE "ListModel" DROP CONSTRAINT "ListModel_barberId_fkey";

-- AlterTable
ALTER TABLE "ListModel" DROP COLUMN "barberId";

-- CreateTable
CREATE TABLE "ListModelSeller" (
    "id" SERIAL NOT NULL,
    "barberId" TEXT NOT NULL,
    "name" TEXT NOT NULL,

    CONSTRAINT "ListModelSeller_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "ListModelSeller_name_key" ON "ListModelSeller"("name");

-- AddForeignKey
ALTER TABLE "ListModelSeller" ADD CONSTRAINT "ListModelSeller_barberId_fkey" FOREIGN KEY ("barberId") REFERENCES "Barber"("barberId") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ListModel" ADD CONSTRAINT "ListModel_name_fkey" FOREIGN KEY ("name") REFERENCES "ListModelSeller"("name") ON DELETE CASCADE ON UPDATE CASCADE;
