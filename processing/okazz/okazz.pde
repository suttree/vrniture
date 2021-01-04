// From https://www.openprocessing.org/sketch/952147

//let shapes = [];
//let circles = [];
//let colors = ["#FFD35C", "#FD4A8E", "#08A9E5", "#f0f0f0", "#202020"];
String[] shapes = [];
String[] circles = [];
String[] colors = ["#FFD35C", "#FD4A8E", "#08A9E5", "#f0f0f0", "#202020", "#fea621"];


void setup() {
	//createCanvas(800, 800);
	//size(640, 480, P3D);
	fullScreen();
	noCursor();
	rectMode(CENTER);
	generate();
}

void draw() {}

void generate() {
	tiling();

	shuffle(shapes, true);

	background(random(colors));
	stroke(0);
	fill(255);
	let hlen = int(shapes.length / 2);
	for (let i = 0; i < hlen; i++) {
		let x = shapes[i][0];
		let y = shapes[i][1];
		let w = shapes[i][2];
		let h = shapes[i][3];
		noStroke();
		fill(random(colors));
		if (random() < 0.5) {
			stroke(random(colors));
			noFill();
		}
		rect(x, y, w - 5, h - 5);
	}

	for (let i = 0; i < circles.length; i++) {
		let x = circles[i][0];
		let y = circles[i][1];
		let d = circles[i][2];
		let col = color(random(colors));
		let ac = TAU / (d * 3);
		if (random() < 0.5) {
			noStroke();
			fill(col);
			circle(x, y, d);
		}

		col.setAlpha(50);
		noFill();
		stroke(col);
		for (let a = 0; a < TAU; a += ac) {
			noiseCurve(x + d * 0.5 * cos(a), y + d * 0.5 * sin(a));
		}
	}

	for (let i = hlen; i < shapes.length; i++) {
		let x = shapes[i][0];
		let y = shapes[i][1];
		let w = shapes[i][2];
		let h = shapes[i][3];
		noStroke();
		fill(random(colors));
		if (random() < 0.5) {
			stroke(random(colors));
			noFill();
		}
		rect(x, y, w - 5, h - 5);
	}

	shapes.length = 0;
	circles.length = 0;
	noiseSeed(int(random(100000)));
}

void tiling() {
	let offset = 50;
	let gridCountW = 10;
	let gridCountH = gridCountW;
	let gridW = (width - (offset * 2)) / gridCountW;
	let gridH = (height - (offset * 2)) / gridCountH;
	let empty = gridCountW * gridCountH;
	let useGrid = [];

	for (let j = 0; j < gridCountW; j++) {
		let arr = []
		for (let i = 0; i < gridCountH; i++) {
			arr[i] = false;
		}
		useGrid[j] = arr;
	}

	while (empty > 0) {
		let w = int(random(1, 5));
		let h = int(random(1, 5));
		let x = int(random(gridCountW - w + 1));
		let y = int(random(gridCountH - h + 1));
		let colision = true;
		for (let j = 0; j < h; j++) {
			for (let i = 0; i < w; i++) {
				if (useGrid[x + i][y + j]) {
					colision = false;
					break;
				}
			}
		}

		if (colision) {
			for (let j = 0; j < h; j++) {
				for (let i = 0; i < w; i++) {
					useGrid[x + i][y + j] = true;
				}
			}
			let ww = w * gridW;
			let hh = h * gridH;
			let xx = offset + (x * gridW) + ww * 0.5;
			let yy = offset + (y * gridH) + hh * 0.5;
			if (ww != hh) {
				shapes.push([xx, yy, ww, hh]);
			} else {
				circles.push([xx, yy, ww]);
			}
			empty -= w * h;
		}
	}
}

void noiseCurve(x, y) {
	let c = 500;
	let px = x;
	let py = y;
	beginShape();
	for (let i = 0; i < c; i++) {
		let scl = 0.0005;
		let angle = noise(x * scl, y * scl, i * 0.0005) * 120;
		let w = map(i, 0, c - 1, 1, 0);
		vertex(x, y);
		px = x;
		py = y;
		x += cos(angle) * 5;
		y += sin(angle) * 5;
	}
	endShape();
}
