/*
  Warnings:

  - A unique constraint covering the columns `[barberId,name]` on the table `ListModelSeller` will be added. If there are existing duplicate values, this will fail.

*/
-- CreateIndex
CREATE UNIQUE INDEX "ListModelSeller_barberId_name_key" ON "ListModelSeller"("barberId", "name");
