// Partitura interactiva, solo dispara las secciones

~partituraInteractiva = { arg pngDir = "";
	var window, image = [], uview, hojaW, hojaH;
	var hoja = ["01", "02", "03", "04"], points;
	
	hoja.do { arg se;
		image = image ++ SCImage.new(pngDir ++ "/" ++ se ++ ".png");
//		image = image ++ SCImage.new(Document.current.dir ++ "/png/" ++ se ++ ".png");
	};
	
	hojaW = image[0].width * 0.3;
	hojaH = image[0].height * 0.3;
	
	window = Window.new("Puente", Rect(0, 0, hojaW, hojaH), scroll: true);
	uview = UserView.new(window, Rect(0, 0, hojaW, hojaH * 4));
	
	window.drawHook = {
		image.do { arg img, i;
			img.drawInRect(Rect(0, hojaH * i, hojaW, hojaH));
		};
	};
	
	points = [
		// a
		[[ 33, 63 ], [ 465, 244 ]],
		// b
		[[ 474, 69 ], [ 710, 242 ]],
		// c
		[[ 32, 278 ], [ 263, 501 ]],
		// d
		[[ 268, 278 ], [ 517, 499 ]],
		// e
		[[ 522, 276 ], [ 687, 497 ]],
		// f
		[[ 24, 567 ], [ 91, 704 ]],
		// g
		[[ 95, 566 ], [ 707, 709 ]],
		// h
		[[ 40, 740 ], [ 354, 872 ]],
		// i
		[[ 364, 739 ], [ 710, 893 ]],
		// j
		[[ 364, 1406 ], [ 713, 1559 ]],
		// k
		[[ 382, 1613 ], [ 709, 1800 ]],
		// l
		[[ 30, 1835 ], [ 688, 2022 ]]
	];
	
	points.do { arg p, i;
		var x;
		x = UserView.new(window, Rect.fromPoints(p[0].asPoint, p[1].asPoint));
		x.mouseDownAction = {
			("parte " ++ (65 + i).asAscii).postln;
			~pSec = ("~p" ++ (65 + i).asAscii ++ ".play;").interpret;
		};
	};
	
	//uview.mouseDownAction = { arg w, x, y; [x, y].postln };
	window.front;
	~ventanaInteractiva = window;
};

//~setupGeneral.value;
//Server.local.meter;
//~partituraInteractiva.();
