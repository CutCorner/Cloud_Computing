-- AddForeignKey
ALTER TABLE "BarberAdmin" ADD CONSTRAINT "BarberAdmin_uid_fkey" FOREIGN KEY ("uid") REFERENCES "Profile"("uid") ON DELETE RESTRICT ON UPDATE CASCADE;
