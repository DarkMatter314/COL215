wbfile = open("weights_bias.txt","r")
wbufile = open("weights_bias_update.txt","r+")
lines = [["" for _ in range(0,65)] for _ in range(0,785)]
for i in range(0,785):
    for j in range(0,65):
        lines[i][j] = wbfile.readline()
for j in range(0,65):
    for i in range(0,785):
        wbufile.write(lines[i][j])
for i in range(0,65):
    for j in range(0,10):
        lines[i][j] = wbfile.readline()
for j in range(0,10):
    for i in range(0,65):
        wbufile.write(lines[i][j])
wbfile.close()
wbufile.close()