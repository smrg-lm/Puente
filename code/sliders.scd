// Niveles
// archivo suelto

/*
// setup
// secciones
~setupGeneral.value;

Controles
~gflAmpFactor = 20; // piano interactivo
~ampReactGrain = 5; // electroacústica interactiva (afecta solo antes de empezar)
~ampReactFil = 1; // electroacústica interactiva (afecta solo antes de empezar)
~soundInSynth[0].set(\gain, 1); // fl
~soundInSynth[1].set(\gain, 1); // pno
~soundMixSynth.set(\pnoGain, 1, \flGain, 1); // mix
~allNotesOff.(); // pno midi
*/

~gflAmpFactor = 20;
~ampReactGrain = 5;
~ampReactFil = 1;

~niveles = {
	var window;
	var e = [
		(
			gVar: { arg self, v; ~gflAmpFactor = v; },
			sliderVal: 0.5, nboxVal: 20, loVal: 0, hiVal: 40,
			stringVal: "~gflAmpFactor"
		),
		(
			gVar: { arg self, v; ~ampReactGrain = v; },
			sliderVal: 0.25, nboxVal: 5, loVal: 0, hiVal: 20,
			stringVal: "~ampReactGrain"
		),
		(
			gVar: { arg self, v; ~ampReactFil = v; },
			sliderVal: 0.1, nboxVal: 1, loVal: 0, hiVal: 10,
			stringVal: "~ampReactFil"
		)
	];

	window = Window.new;
	window.addFlowLayout(Point(10, 10), Point(10, 10));

	e.do { arg i;
		var stext, slider, nbox;

		stext = StaticText(window, Rect(0, 0, 100, 20));
		slider = Slider(window, Rect(0, 0, 200, 20));
		nbox = NumberBox(window, Rect(0, 0, 60, 20));

		stext.string = i.stringVal;
		stext.align = \center;
		stext.background = Color.white;

		slider.value = i.sliderVal;
		nbox.value = i.nboxVal;

		slider.action = {
			nbox.value = i.gVar((slider.value * i.hiVal).trunc);
		};

		nbox.clipLo = i.loVal;
		nbox.clipHi = i.hiVal;
		nbox.action = {
			slider.value = i.gVar(nbox.value / i.hiVal);
		};
	};

	window.front;
};

~niveles.();
