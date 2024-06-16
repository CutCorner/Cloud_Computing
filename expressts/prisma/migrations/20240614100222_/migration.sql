/*
  Warnings:

  - A unique constraint covering the columns `[id_order,uid]` on the table `Review` will be added. If there are existing duplicate values, this will fail.

*/
-- CreateIndex
CREATE UNIQUE INDEX "Review_id_order_uid_key" ON "Review"("id_order", "uid");
