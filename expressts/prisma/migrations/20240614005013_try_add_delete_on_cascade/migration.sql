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

-- AddForeignKey
ALTER TABLE "ListBarber" ADD CONSTRAINT "ListBarber_barberId_fkey" FOREIGN KEY ("barberId") REFERENCES "BarberAdmin"("barberId") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ListAddon" ADD CONSTRAINT "ListAddon_barberId_fkey" FOREIGN KEY ("barberId") REFERENCES "BarberAdmin"("barberId") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Orders" ADD CONSTRAINT "Orders_barberId_fkey" FOREIGN KEY ("barberId") REFERENCES "BarberAdmin"("barberId") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ListModel" ADD CONSTRAINT "ListModel_barberId_fkey" FOREIGN KEY ("barberId") REFERENCES "BarberAdmin"("barberId") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Review" ADD CONSTRAINT "Review_barberId_fkey" FOREIGN KEY ("barberId") REFERENCES "BarberAdmin"("barberId") ON DELETE CASCADE ON UPDATE CASCADE;
