int scale = 20;
int offset = 10;
int rows;
int cols;
int[][] cells;
int[][] new_cells;
boolean isRunning = false;
int fps = 20;

void setup() {
  frameRate(fps);
  size(1200, 800);

  rows = (width / scale) + (offset * 2);
  cols = (height / scale) + (offset * 2);

  cells = new int[rows][cols];
  for (int i=0; i<rows; i++) {
    for (int j=0; j<cols; j++) {
      cells[i][j] = 0;
    }
  }

  new_cells = new int[rows][cols];
  for (int i=0; i<rows; i++) {
    for (int j=0; j<cols; j++) {
      cells[i][j] = 0;
    }
  }
}

void draw() {
  background(100, 100, 100);
  stroke(0, 0, 0);

  for (int i=0; i<rows-10; i++) {
    for (int j=0; j<cols-10; j++) {
      if (cells[i+10][j+10] == 1) {
        rect(i*scale, j*scale, scale, scale);
      }
    }
  }

  for (int i=0; i<rows; i++) {
    for (int j=0; j<cols; j++) {
      line(0, i*scale, width, i*scale);
      line(j*scale, 0, j*scale, height);
    }
  }

  if (isRunning) {
    gameLogic();
  }
}

void gameLogic() {
  int neighborCount = 0;

  for (int i=0; i<rows; i++) {
    for (int j=0; j<cols; j++) {

      //clean up cells outside the screen every 10 seconds
      if (frameCount % (fps * 10) == 0) {
        if (i<=offset || i>=rows-offset-1 || j<=offset || j>=cols-offset-1) {
          cells[i][j] = 0;
          new_cells[i][j] = 0;
        }
      }

      neighborCount = neighbors(i, j);
      if (cells[i][j] == 1) {
        if (neighborCount < 2 || neighborCount > 3) {
          new_cells[i][j] = 0;
        } else {
          new_cells[i][j] = 1;
        }
      } else if (cells[i][j] == 0) {
        if (neighborCount == 3) {
          new_cells[i][j] = 1;
        }
      }
    }
  }

  for (int i=0; i<rows; i++) {
    for (int j=0; j<cols; j++) {
      cells[i][j] = new_cells[i][j];
    }
  }
}

int neighbors(int x, int y) {
  int count = 0;

  if (x>0 && x<rows-1 && y>0 && y<cols-1) {
    if (cells[x-1][y-1] == 1) {
      count++;
    }
    if (cells[x][y-1] == 1) {
      count++;
    }
    if (cells[x+1][y-1] == 1) {
      count++;
    }
    if (cells[x-1][y] == 1) {
      count++;
    }
    if (cells[x+1][y] == 1) {
      count++;
    }
    if (cells[x-1][y+1] == 1) {
      count++;
    }
    if (cells[x][y+1] == 1) {
      count++;
    }
    if (cells[x+1][y+1] == 1) {
      count++;
    }
  }

  return count;
}

void mousePressed() {
  if (!isRunning) {
    if (mouseButton == LEFT) {
      cells[mouseX/scale+offset][mouseY/scale+offset] = 1;
    }
    if (mouseButton == RIGHT) {
      cells[mouseX/scale+offset][mouseY/scale+offset] = 0;
    }
  }
}

void mouseDragged() {
  if (!isRunning) {
    if (mouseButton == LEFT) {
      cells[mouseX/scale+offset][mouseY/scale+offset] = 1;
    }
    if (mouseButton == RIGHT) {
      cells[mouseX/scale+offset][mouseY/scale+offset] = 0;
    }
  }
}

void keyPressed() {
  if (key == ' ') {
    isRunning = !isRunning;
  }

  if (!isRunning) {
    if (key == 'r' || key == 'R') {
      for (int i=0; i<rows; i++) {
        for (int j=0; j<cols; j++) {
          cells[i][j] = 0;
          new_cells[i][j] = 0;
        }
      }
    }
  }
}
