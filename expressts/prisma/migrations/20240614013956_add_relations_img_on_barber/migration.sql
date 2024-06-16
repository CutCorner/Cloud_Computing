-- AddForeignKey
ALTER TABLE "Image" ADD CONSTRAINT "Image_barberId_fkey" FOREIGN KEY ("barberId") REFERENCES "Barber"("barberId") ON DELETE CASCADE ON UPDATE CASCADE;
