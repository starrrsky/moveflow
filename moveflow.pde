float noise1 = 0.0125, noise2 = .0025;
ArrayList<Bit> bits, deadBits;
boolean moused = false;
float spawner = -50;

void setup()
{
  size(1280, 720);
  bits = new ArrayList<Bit>();
  deadBits = new ArrayList<Bit>();
  smooth();
  noStroke();
  background(20, 0, 20);
}

void draw() {
  if (spawner < width + 50)
  {
    Bit bot = new Bit(spawner, height/2 + (noise(spawner*noise2, height/2*noise2) - .5) * 700);
    bits.add(bot);
    spawner+=.5;
  }
  
  for (Bit bit : bits)
  {
    if (bit.dead)
    {
      deadBits.add(bit);
    }
    else
    {
      bit.update();
    }
  }
  
  for (Bit bit : deadBits)
  {
    bits.remove(bit);
  }
  deadBits.clear();
  
}

class Bit
{
  public PVector pos, dir;
  public boolean dead = false;
  
  public Bit(float x, float y)
  {
    pos = new PVector(x, y);
  }
  
  public void update()
  {
    if (pos.x < -50 || pos.y < -50 || pos.x > width + 50 || pos.y > height + 50)
    {
      dead = true;
    }
    else
    {
      dir = new PVector(noise((pos.x-9865)*noise1, (pos.y+737645)*noise1)-.5, noise((pos.x)*noise1, (pos.y+65356)*noise1)-.5);
      dir.mult(15);
      pos.add(dir);
      fill(255-dir.mag()*200/15,
           255-dir.mag()*255/15,
           255-dir.mag()*100/15);
      ellipse(pos.x, pos.y, 1, 1);
    }
  }
  
}
