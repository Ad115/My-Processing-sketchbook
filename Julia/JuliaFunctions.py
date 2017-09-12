def complexSum(a, b):
    # Unpack the complex numbers
    ax, ay = a
    bx, by = b
    return [ax+bx, ay+by]

def complexMultiplication(a, b):
    # Unpack the complex numbers
    ax, ay = a
    bx, by = b
    # (ax + i ay) * (bx + i by) = (ax bx - ay by) + i (ax by + ay bx)
    return [ (ax * bx - ay * by), (ax * by + ay * bx) ]

def complexSqModulus(a):
    # Unpack the complex number
    ax, ay = a
    return (ax*ax + ay*ay)

def juliaF( z, c=(-0.1, 0.65) ):
    return complexSum( complexMultiplication(z,z), c )

def iterationsToGo( z0, c=(-0.1, 0.65), maxIterations=250 ):
    zMax = 100.0
    maxIterations = 250
    z = z0
    for n in range(maxIterations):
        z = juliaF(z, c)
        if complexSqModulus(z) >= zMax:
            return n
    return maxIterations + 1