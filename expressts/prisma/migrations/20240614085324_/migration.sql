/*
  Warnings:

  - A unique constraint covering the columns `[id_order]` on the table `Orders` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[id_order]` on the table `Review` will be added. If there are existing duplicate values, this will fail.
  - The required column `id_order` was added to the `Orders` table with a prisma-level default value. This is not possible if the table is not empty. Please add this column as optional, then populate it before making it required.
  - Added the required column `id_order` to the `Review` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "Orders" ADD COLUMN     "id_order" TEXT NOT NULL;

-- AlterTable
ALTER TABLE "Review" ADD COLUMN     "id_order" TEXT NOT NULL;

-- CreateIndex
CREATE UNIQUE INDEX "Orders_id_order_key" ON "Orders"("id_order");

-- CreateIndex
CREATE UNIQUE INDEX "Review_id_order_key" ON "Review"("id_order");

-- AddForeignKey
ALTER TABLE "Orders" ADD CONSTRAINT "Orders_id_order_fkey" FOREIGN KEY ("id_order") REFERENCES "Review"("id_order") ON DELETE RESTRICT ON UPDATE CASCADE;
