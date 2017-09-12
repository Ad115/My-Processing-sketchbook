import math
import random
phi = 0.618033

class Plotter:
    """
    Class that handles showing a function to the screen
    """
    
    def __init__(self):
        # Available functions
        self.functions = self.makeFunctions()
        self.function = self.getFunction(0)
        self.resolution = 1
        self.showShadow = False
        self.next = None
    #---------------------------------------------------
        
    def makeFunctions(self):
        """
        Returns a list of functions available to plot
        """
        return [
            (lambda x: 0.001 * -x**2 + 150), # Parable
            (lambda x: 0.001 * (x**2 + 400*x) ), # Polinomial
            (lambda x: 200*math.exp(-0.00003 * x**2)), # Gaussian
            (lambda x: 0.001 * x**2 - math.exp(-0.01 * x)) # Exp
            ]
    #---------------------------------------------------
    
    def getFunction(self, n):
        """
        Return a function corresponding to the given number
        """
        return self.functions[n]
    #---------------------------------------------------
    
    def plot(self):
        # Prepare to transform
        pushMatrix()
        
        # Set the origin to the middle of the screen
        translate(width/2, height/2)
        
        # Draw the axis
        stroke(150)
        strokeWeight(2)
        line(-width/2, 0, width/2, 0)
        line(0, height/2, 0, -height/2)
        
        # Begin to draw the curve
        noFill()
        stroke(0)
        strokeWeight(5)
        x = -width/2
        while x < width/2:
            # Add point
            r = 5*(0.5 - noise(0.01*x + 10*frameCount))
            ellipse(x, - self.function(x) + r, 1+0.2*r,1+0.2*r)
            x += self.resolution
        
        popMatrix() # End of transformation
        
    def setFunction(self, n):
        self.function = self.getFunction(n % len(self.functions))
        
    def changeFunction(self, n = None):
        if n == None:
            self.function = random.choice(self.functions)
        else:
            self.setFunction(n)
        if self.mode == "goldenSectionSearch":
            self.beginSearch()
            
    def nextFunction(self):
        # Find the current function in the list of functions
        i = self.functions.index( self.function )
        self.changeFunction((i+1) % len(self.functions))
        
    def setMode(self, mode):
        if mode in [ 
                    "plot", 
                    "goldenSectionSearch",
                    "both"
                    ]:
            self.mode = mode
            if mode == "goldenSectionSearch":
                self.beginSearch()
            
    def beginSearch(self):
        # Set initial points
        a = -0.37*width
        b = 0.3*width
        c = b - phi*(b-a)
        next = a + phi*(b-a)
        self.search = {"interval": [a,c,b], "next": next}
        self.showSearch()
        self.plot()
        
    def showSearch(self):
        interval = self.search["interval"]
        next = self.search["next"]
        
        # Prepare to transform
        pushMatrix()
        
        # Set the origin to the middle of the screen
        translate(width/2, height/2)
        
        # Draw the axis
        stroke(150)
        strokeWeight(2)
        line(-width/2, 0, width/2, 0)
        line(0, height/2, 0, -height/2)
        
        # Draw the range background
        noStroke()
        fill(150, 100)
        rect(interval[0], -height/2, abs(min(interval)-max(interval)), height)
            
        # Begin to draw the lines
        stroke(220)
        strokeWeight(5)
        for xp in interval:
            line(xp, height/2, xp, -height/2)
            
        # Begin to draw the dots
        fill(200)
        stroke(100)
        strokeWeight(5)
        for n, xp in enumerate(interval):
            r = 5*(0.5 - noise(10*frameCount+xp))
            fill(200)
            stroke(100)
            ellipse(xp, -self.function(xp), 20 + r, 20 + r)
            fill(0); stroke(0)
            text(str(n), xp, -self.function(xp)+20)
            
        # Draw the next dot
        noStroke()
        fill(100)
        r = 7*(0.5 - noise(10*frameCount))
        ellipse(next, -self.function(next), 20 + r, 20 + r)
        
        # Draw the next interval
        a,c,b = self.nextInterval()["interval"]
        noStroke()
        fill(100, 100)
        if self.showShadow:
            rect(a, -height/2, b-a, height) 
        
        popMatrix() # End of transformation        
        
    def nextInterval(self):
        # Get important values
        interval = self.search["interval"]
        next = self.search["next"]
        a, c, b = interval
        f = self.function
        if f(next) > f(c):
            if next > c:
                # Rightmost interval
                a, c, b = c, next, b
                next = a + phi*(b-a)
            else :
                # Leftmost interval
                a, c, b = a, next, c
                next = b - phi*(b-a)
        else:
            if next > c:
                # Leftmost interval
                a, c, b = a, c, next
                next = b - phi*(b-a)
            else :
                # Rightmost interval
                a, c, b = next, c, b
                next = a + phi*(b-a)
        
        return {"interval": [a, c, b], "next": next}
    
    def advanceSearch(self):
        self.search = self.nextInterval()
        #self.toogleShadow(False)
        
    def toogleShadow(self, shadow = None):
        if shadow == None:
            self.showShadow = not self.showShadow
        else:
            self.showShadow = shadow    