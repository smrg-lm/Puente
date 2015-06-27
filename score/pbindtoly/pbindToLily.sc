// Parte H-I (pbind to lily)

(
thisThread.randSeed = 3008;

~dur = 80; // 1' a 0.8
~wcDur = Pseries(0.1, 0.00125, inf).asStream; // 0.4 / (80 * 4) (0.1 a 0.5 en 80 pasos)
~wcOct = Pseries(0.1, 0.00175, inf).asStream; // 0.56 / (80 * 4) (0.1 a 0.66 en 80 pasos)
~transp = 74;

p = Pbind(
	\midinote,
		Pxrand([0, 1, 2, 3], ~dur * 4) + ~transp
		+
		Pfunc({
			var next = ~wcOct.next;
			[0, 14, -13].wchoose([1 - next, next/2, next/2])
		}),
	\dur, Pfunc({
		var next = ~wcDur.next;
		[0.2, 0.3].wchoose([1 - next, next])// * 0.8
	})
);

~midilily = { arg midinote;
  var names = ["c", "cis", "d", "dis", "e", "f", "fis", "g", "gis", "a", "ais", "b"];
  var octv =  midinote - 48 div: 12;
  var pc =  midinote % 12;
  
  names[pc] ++ (if(octv < 0) {
    ",".dup(octv.abs).join;
  } {
    "'".dup(octv.abs).join;
  } ? "");
};

~movimientoCromatico = { arg note, prox;
  var sharpNames = ["c", "cis", "d", "dis", "e", "f", "fis", "g", "gis", "a", "ais", "b"];
  var flatNames = ["c", "des", "d", "ees", "e", "f", "ges", "g", "aes", "a", "bes", "b"];
  var auxNote, auxProx, auxOctv, noteIndx, proxIndx;
  
  auxNote = note.findRegexp("[a-g](is|es)");
  auxOctv = note.findRegexp("['|,]+");
  auxProx = prox.findRegexp("[a-g](is|es)?");

  if(auxNote != [] && { auxProx != [] }) {
    noteIndx = sharpNames.indexOfEqual(auxNote[0][1]) ? flatNames.indexOfEqual(auxNote[0][1]);
    proxIndx = sharpNames.indexOfEqual(auxProx[0][1]) ? flatNames.indexOfEqual(auxProx[0][1]);
    auxNote = auxNote[0][1];
    if((noteIndx - proxIndx).abs == 1) {
      if(noteIndx < proxIndx) { auxNote = sharpNames[noteIndx] } { auxNote = flatNames[noteIndx] };
    } {
      if(noteIndx - proxIndx == 0) { auxNote = auxProx[0][1] };
    };
    if( auxOctv != []) {
      auxNote = auxNote ++ auxOctv[0][1];
    };
    auxNote;
  } {
    note;
  };
};

~streamToLily = { arg stream;
	var outString, outBarString;
	var n16 = 0, duras = ["8", "8."];
	var event, prevEvent;
	var openLegato = true;
	var closeLegato = false;
	var toOpen = false;
	var toClose = false;

	outString = "{\n";
	outBarString = "";
	prevEvent = stream.next(());
	while({ (event = stream.next(())) != nil }, {
		outBarString = outBarString ++
		    ~movimientoCromatico.(~midilily.(prevEvent[\midinote]), ~midilily.(event[\midinote]));
		// al final del while deja afuera el último event
		prevEvent = event;

		outBarString = outBarString ++ if(event[\dur] == 0.2, {
			if(openLegato && closeLegato.not, {
				toOpen = true;
				openLegato = false;
				closeLegato = true;
			});
			n16 = n16 + 2;
			duras[0];
		}, {
			if(closeLegato && openLegato.not, {
				toClose = true;
				openLegato = true;
				closeLegato = false
			});
			n16 = n16 + 3;
			duras[1];
		});
		if(toOpen, { outBarString = outBarString ++ "(["; toOpen = false; });
		if(toClose, {
			outBarString = outBarString ++ ")]";
			// deja afuera al último incompleto...
			outString = outString ++ " \\time " ++ n16 ++ "/16 " ++ outBarString ++ "\n";
			outBarString = "";
			n16 = 0;
			toClose = false;
		});
		outBarString = outBarString ++ " ";
	});
	// if toClose cerrar
	// puede abrir uno al final
	outString = outString ++ "\n}";
	outString;
};
)

o = ~streamToLily.(p.asStream);
