-- DropForeignKey
ALTER TABLE "Review" DROP CONSTRAINT "Review_id_order_fkey";

-- AddForeignKey
ALTER TABLE "Review" ADD CONSTRAINT "Review_id_order_fkey" FOREIGN KEY ("id_order") REFERENCES "Orders"("id_order") ON DELETE CASCADE ON UPDATE CASCADE;
