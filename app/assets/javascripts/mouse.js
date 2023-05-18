let cursorSize = 50;

function setup() {
  createCanvas(windowWidth, windowHeight);
  noCursor();
}

function draw() {
  background(220);
  line(windowWidth / 2, 0, windowWidth / 2, windowHeight);
  line(0, windowHeight / 2, windowWidth, windowHeight / 2);

  if (mouseX < 50 && mouseY < 50) {
    cursor(CROSS);
  } else if (mouseX > 50 && mouseY < 50) {
    cursor('progress');
  } else if (mouseX > 50 && mouseY > 50) {
    cursor('https://avatars0.githubusercontent.com/u/1617169?s=16');
  } else {
    cursor('grab');
  }
}

function mouseMoved() {
  let cursorShape = document.querySelector('.custom-cursor');
  cursorShape.style.left = mouseX - cursorSize / 2 + 'px';
  cursorShape.style.top = mouseY - cursorSize / 2 + 'px';
}
