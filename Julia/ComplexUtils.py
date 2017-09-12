def complexRandomPolar(radius):
    # Get a random radius and angle
    r = random(radius)
    angle = random(2*TAU)
    # Assemble the complex number
    x = r * cos(angle)
    y = r * sin(angle)
    return [x, y]

def complexRandomRectangular(w, h):
    return [ random(-w, w), random(-h, h)]

def complexRandomNoise(radius, rate = 0.005, t = 1):
    # Get a random radius and angle
    r = radius * noise( rate * t )
    angle = 2 * TAU * noise( 1000 + rate * t )
    # Assemble the complex number
    x = r * cos(angle)
    y = r * sin(angle)
    return [x, y]

def complexPerturbation(z, perturbation):
    px, py = complexRandomPolar(perturbation)
    zx, zy = z
    return [ zx+px, zy+py ]