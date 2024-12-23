a = open("a.txt","r")
aup = open("aup.txt", "r+")
for str in a:
    aup.write("00000000")
    aup.write(str)
aup.write("0000000000000001")
a.close()
aup.close() 