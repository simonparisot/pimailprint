# Pi Mail-to-Print

Little project to implement a mail-to-print in my house.
I have an old printer that still works ok, but my wife can't connect to it (old drivers problem), physical access is not that easy and I cannot print from my phone.

## Hardware
 - RaspberryPi Zero W
 - Old printer (HP Photosmart C4200)

## Software
 - a dedicated email adress, to send what I need to print (I used Gmail)
 - fetchmail, ... well to fetch mail on this email adress onto the Pi
 - procmail, to process mail and extract the attachment
 - CUPS, to work with the printer
 - a small shell script, in a crontab, to fetch regularly and print whatever attachment is received

## How to
1. Flash Rapsbian light 
2. Enable SSH-over-USB: https://desertbot.io/blog/ssh-into-pi-zero-over-usb
3. Connect to wifi: https://pimylifeup.com/setting-up-raspberry-pi-wifi/
4. Install CUPS: sudo apt-get install cups
5. Install other mail services: sudo apt-get install fetchmail procmail uudeview
6. copy all files in ~/pimailprint directory
7. create an application password: https://myaccount.google.com/apppasswords
8. in fetchmail.conf fill the correct email adress and app password
9. chmod 700 ./fetchmail.conf
10. Connect printer
11. Start CUPS: sudo usermod -aG lpadmin pi && sudo /etc/init.d/cups start
12. Add permission for CUPS web app: sudo cupsctl --remote-any && sudo /etc/init.d/cups restart
13. Access CUPS web app: https://[PI_IP]:631/admin
14. Install printer: Administration > Add Printer >  HP Photosmart C4200 series (HP Photosmart C4200 series)
15. set this printer as default
16. test with ./printmail.sh
17. create a crontab: crontab -e -u pi

 ## What could be improved
 - print only attachment and not the media content in the email body (eg small images in signatures...)
 - print office documents (pptx, docx, ...)