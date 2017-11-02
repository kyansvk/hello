import requests, time
headers = {'User-Agent':"Mozilla/5.0 (Windows NT 10.0; WOW64; rv:55.0) Gecko/20100101 Firefox/55.0"}

def recursionftwdude(theSession):
   try:
       theSession.close()
       theSession = None
       theSession = requests.Session()
       theSession.get("http://www.lazada.com.my/", headers=headers)
       return theSession
   except:
       recursionftwdude(theSession)

numberOfAttempt = 0
s = requests.Session()
s.get("http://www.lazada.com.my/", headers=headers)
url = "https://www.lazada.com.my/ajax/lottery/spinTheWheel/?lang=en&platform=desktop&wheelToken=7b03cfa1ba0da7194d771e2d262f54fc&dpr=1" # "http://www.lazada.com.my/ajax/lottery/spinTheWheel/?lang=en&platform=desktop&wheelToken=2566d34226c6835fc7ebeebe8d2fc7a4&dpr=2"
while 1:
   numberOfAttempt += 1
   if numberOfAttempt == 1500:
       s = recursionftwdude(s)
       numberOfAttempt = 0
   try:
       r = s.get(url, headers=headers).json()
   except ValueError:
       print "Server no give shit"
       time.sleep(5)  # give server rest, because i see 503 too often
       continue
   except requests.exceptions.ConnectionError:
       print "Server no give shit!!!"
       time.sleep(2)  # littlebit speacial
       continue
   try:
       print "Voucher: " + r["data"]["voucherCode"]
       s = recursionftwdude(s)
       with open("voucherCodeHi.txt", "a") as f:  # voucher code yang dijumpa ade kat dlm file name dier voucherCodeHi.txt
           f.write(time.ctime(int(time.time())) + " :  " + str(r["data"]["voucherCode"]) + "\n")
   except KeyError:
       if r and r["data"]:
           print "Everything is normal! " + str(numberOfAttempt)
           time.sleep(5)  # bende baru ade kat sini
       continue

