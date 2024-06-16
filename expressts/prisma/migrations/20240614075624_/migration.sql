/*
  Warnings:

  - A unique constraint covering the columns `[barberId,name]` on the table `ListAddon` will be added. If there are existing duplicate values, this will fail.

*/
-- CreateIndex
CREATE UNIQUE INDEX "ListAddon_barberId_name_key" ON "ListAddon"("barberId", "name");
