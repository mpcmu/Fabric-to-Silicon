f_read = open("test1.fasm", "r")
f_write = open("test1_modified.fasm", "w")
for x in f_read:
    f_write.write(x)
    if "MODE_ALU" in x:
        arr = x.split(".")
        y = arr[0]+".CLBBLE0.LUT.INIT[15:0]=16'b000000"+x[len(x)-9:len(x)-1]+"00\n"
        f_write.write(y)
f_read.close()
f_write.close()
