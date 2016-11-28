class Mover(object):
    
    # CONSTRUCTOR........................
    
    def __init__(self):
        size = random(200)
        self.size = size
        
        x = size/2
        y = size/2
        self.position = PVector(x, y)
        
        self.velocity = PVector(0,0)
        self.acceleration = PVector(0,0)

    #......................................
                        
    def randomizePosition(self):
        size = self.size
        x = random(size/2, width-size/2)
        y = random(size/2, height-size/2)
        self.position = PVector(x, y)
        
    #.......................................
        
    def draw(self):
        ellipseMode(CENTER)
        
        fillColor = 255 * noise(0.05*frameCount + self.size)
        fill(fillColor)
        ellipse(self.position.x, self.position.y, self.size, self.size)
        
    #.......................................
    
    def applyForce(self, force):
        mass = self.size
        effect = PVector.div(force, mass)
        self.acceleration.add(effect)
        
    #........................................
    
    def move(self):
        self.velocity.add( self.acceleration )
        ##self.velocity.limit(7)
        self.position.add( self.velocity )
        self.bounce()
    
    #..........................................
    
    def update(self):
        mouse = PVector(mouseX, mouseY)
        mouseforce = PVector.sub(mouse, self.position)
        mouseforce.setMag(10)
        wind = PVector(0.5, 0)
        gravity = PVector(0, 0.1*self.size)
        
        #Apply forces and move
        self.acceleration.setMag(0)
        self.applyForce(wind)
        self.applyForce(gravity)
        #self.applyForce(mouseforce)
        self.move()
        
    #..........................................
        
    def bounce(self):
        size = self.size
        # Left
        if self.position.x < 0 + size/2 : 
            self.position.x = 0+size/2 
            self.velocity.x = -self.velocity.x
            
        # Right
        if self.position.x > width - size/2: 
            self.position.x = width - size/2
            self.velocity.x = -self.velocity.x
        
        # Top
        if self.position.y < 0 + size/2 : 
            self.position.y = 0 + size/2
            self.velocity.y = -self.velocity.y
            
        # Botom
        if self.position.y > height - size/2 : 
            self.position.y = height-size/2
            self.velocity.y = -self.velocity.y