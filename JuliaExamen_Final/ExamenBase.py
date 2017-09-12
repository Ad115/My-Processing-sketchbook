"""
Exam 1, part 2
"""

def complexSum(a, b):
    """
    Sum the complex numbers `a` and `b`
    For this, remember the rule for complex number addition:
        (ax + i ay) + (bx + i by) = (ax + bx) + i(ay + by)
    """
    # Unpack the complex numbers
    ax, ay = a
    bx, by = b
    return [ax+bx, ay+by]


def complexMultiplication(a, b):
    """
    Multiply the complex numbers `a` and `b`
    For this, remember the rule for complex number multiplication:
        (ax + i ay)(bx + i by) = (ax bx - ay by) + i(ax by + ay bx)
    """
    # Unpack the complex numbers
    ax, ay = a
    bx, by = b
    # (ax + i ay) * (bx + i by) = (ax bx - ay by) + i (ax by + ay bx)
    return [ (ax * bx - ay * by), (ax * by + ay * bx) ]


def complexSqModulus(a):
    """
    Returns the squared modulus of the complex number `a`
    For this, remember the definition of the complex modulus:
        |ax + i ay|^2 = ax^2 + ay^2 
    """
    # Unpack the complex number
    ax, ay = a
    return (ax*ax + ay*ay)

# MAIN FUNCTIONS________________________________________________________________

def complexPol( z, c ):
    """
    Return z^2 + c, where `z` and `c` are complex numbers 
    """
    return complexSum( complexMultiplication(z,z), c )


def iterationsToGo( z0, c, f, maxIterations=250 ):
    """
    Iterates through zn = f(z_n-1, c) starting from z0.
    Returns n so that |zn|>10.
    If n > maxIterations returns maxIterations+1.
      maxIterations can be specified as an optional argument (default 250) 
    """
    zMax = 100.0 # Maximum |zn|^2
    z = z0
    for n in range(maxIterations): # Iterate `maxIteration` times at most
        z = f(z, c)
        if complexSqModulus(z) >= zMax: # |zn| < 10 ?
            return n
    else: # Out of for loop  ==>  n > maxIterations
        return maxIterations + 1