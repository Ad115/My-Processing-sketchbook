# _*_ coding: utf-8 _*_ 

#..................................................
"""
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
"""
#...................................................
"""
# c = [-0.10470886261479917, 0.6508294307947811]
author = "Sebastian Jimenez Millan"

#Función que regresa z^2+c
def complexPol(a,b):
    return (a[0]**2 - a[1]**2 + b[0], 2*a[0]*a[1] + b[1])

'b)'

#Maximas iteraciones permitidas
nmax=250

#Función para encontrar número de iteraciones
def iterationsToGo(a,b,p):
    n=0
    while sqrt(a[0]**2 + a[1]**2) <= 10 and n <= nmax:
        z=p(a,b)
        a=z
        n+=1
    if n>nmax:
        return nmax+1
    else:
        return n
"""
#...................................................

# c = [-0.06285075941036436, 0.6495472880435106]
author = "Elizabeth Alejandra Ortiz Duran"

def complexPol(z,c): 
    r=[0,0]
    r[0]=z[0]**2-z[1]**2+c[0]
    r[1]=2*z[0]*z[1]+c[1]
    return r

def iterationsToGo(z,c,p):
    r = z
    n=1
    dis=.01
    while abs(dis)<10 and n<252:
        r= p(r,c);
        dis= sqrt(r[0]**2+r[1]**2)
        n=n+1
    if n<250:
        return n
    else:
        return 251