def complexRandomPolar(radius):
    """
    Get random complex number in the circle of radius `radius`.
    Watch out! The random numbers tend to agglomerate at the center,
    so it may not be the random you seek for. 
    """
    # Get a random radius and angle
    r = random(radius)
    angle = random(2*TAU)
    # Assemble the complex number
    x = r * cos(angle)
    y = r * sin(angle)
    return [x, y]

def complexRandomRectangular(w, h):
    """
    Get random complex number in rectangular coordinates.
    x coordinate lies between -`w` and `w`, and
    y coordinate lies between -`h` and `h`. 
    """
    return [ random(-w, w), random(-h, h) ]

def complexRandomNoise(radius, rate = 0.005, t = 1):
    """
    Predictable random number that varies smoothly with t.
    """
    # Get a random radius and angle
    r = radius * noise( rate * t )
    angle = 2 * TAU * noise( 1000 + rate * t )
    # Assemble the complex number
    x = r * cos(angle)
    y = r * sin(angle)
    return [x, y]

def complexPerturbation(z, perturbation):
    """
    Adds random noise to `z` with a maximum magnitude of `perturbation`
    """
    px, py = complexRandomPolar(perturbation)
    zx, zy = z
    return [ zx+px, zy+py ]