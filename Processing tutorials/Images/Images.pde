PImage noise_img, rw_img;

void setup()
{
  size(600, 600);
  noise_img = loadImage("perlin_noise4.png");
  rw_img = loadImage("randomw1000-2.png");
}

void draw()
{
  background(0);
  tint(255);
  image(rw_img, 0, 0);
  tint(48, 249, 199, 234);
  image(noise_img, 0, 0);
}