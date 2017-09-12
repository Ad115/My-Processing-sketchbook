# _*_ coding: utf-8 _*_ 

#..................................................

author = "Sebastián Michel Mata"

def complexPol(a,b):
    s = [0,0]
    s[0] = (a[0]**2-a[1]**2)+b[0]
    s[1] = (2*a[0]*a[1])+b[1]
    return s

def iterationsToGo(a,b,p):
    z = complexPol(a,b)
    n = 0
    while sqrt( z[0]**2 + z[1]**2) < 10 and n<260:
        z = complexPol(z,b)
        n += 1
    if n>250:
        n = 250+1
    return n

#...................................................