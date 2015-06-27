// Secciones

// *** A ***

~pA = Routine.new({
	~microRec.do(_.set(\recLevel, 0.5));
	~mesoRec.do(_.set(\recLevel, 0.5), \preLevel, 0.1);
	~supraRec.do(_.set(\recLevel, 0.5));
	~microPlay.do(_.set(\amp, 0.02)); // son valores encadenados...
	~mesoPlay.do(_.set(\amp, 0.4));
	
	1.wait;
	
	(
		type: \midi,
		midiout: ~midiOut,
		midinote: 93,
		amp: 0.5,
		dur: 5
	).play;
	
	2.wait;

	p = ~materialPiano.( // 50s aprox.
		octr: -12,
		offr: 10,
		reg: [60, 84, 60, 36, 48, 84, 36, 24, 24, 96, 96, 72],
		repp: [1],
		rept: 2,
		conjs: [[1, 2, 3], [4, 5, 6], [7, 8, 9], [10, 11, 0]],
		midiout: ~midiOut
	).play;
	
	if(~flautaWav) {
		38.wait;
		
		{ [2, ~flInBus].do { arg i; Out.ar(
			i,
			PlayBuf.ar(
				1,
				~wavBufferA,
				BufRateScale.kr(~wavBufferA),
				loop:0, doneAction:2
			) * ~wavGain
		)}}.play;
	};
});

//~pA.play;
//~pA.stop;
//p.stop;

// *** B ***

~pB = Routine.new({
	Ppar([
		Pbind(
			\type, \set,
			\id, ~microPlay.collect{ arg i; i.nodeID },
			\args, #[\amp],
			\amp, Pseg(
				Pseq([0.2, 0.3, 0.1, 0.3, 0.1, 0.4, 0]),
				Pseq([5, 2, 2, 2, 2, 8])
			),
			\dur, 0.05
		),
		Pbind(
			\type, \set,
			\id, ~mesoPlay.collect{ arg i; i.nodeID },
			\args, #[\amp],
			\amp, Pseg(
				Pseq([0.4, 0.1, 0.4, 0.1, 0.3, 0]),
				Pseq([5, 2, 2, 2, 10])
			),
			\dur, 0.05
		),
		Pbind(
			\type, \set,
			\id, ~supraPlay.collect{ arg i; i.nodeID },
			\args, #[\amp],
			\amp, Pseg(
				Pseq([0, 0, 0.5]),
				Pseq([20, 10, 1])
			),
			\dur, 0.05
		),
		Pbind(
			\type, \set,
			\id, (
				~microRec.collect{ arg i; i.nodeID } ++
				~mesoRec.collect{ arg i; i.nodeID } ++
				~supraRec.collect{ arg i; i.nodeID }
			),
			\args, #[\recLevel],
			\recLevel, Pseq([0.5, 0.001]),
			\dur, Pseq([25, 5])
		),
		~materialPiano.( // 35s aprox.
			octr: 0,
			offr: rrand(74, 92),
			reg: [24, 32, 48, 72, 60, 86, 72, 96, 24, 60, 48, 86],
			repp: [1, 2],
			rept: 2,
			conjs: [[0, 2, 3, 5], [1, 4, 6, 7], [8, 9, 10, 11]],
			midiout: ~midiOut
		)
	]).play;
});

//p = ~pB.play;
//p.stop;

// *** C ***

~pC = Routine.new({
	Ppar([
		Pbind(
			\type, \set,
			\id, ~microPlay.collect{ arg i; i.nodeID },
			\args, #[\amp],
			\amp, Pseg(
				Pseq([0, 0.2, 0.4, 0.1, 0.4, 0.1, 0.4, 0.5]),
				Pseq([1, 5, 2, 2, 2, 2, 8, 1])
			),
			\dur, 0.05
		),
		Pbind(
			\type, \set,
			\id, ~mesoPlay.collect{ arg i; i.nodeID },
			\args, #[\amp],
			\amp, Pseg(
				Pseq([0, 0.3, 0.1, 0.4, 0.1, 0.4, 0.5]),
				Pseq([1, 5, 2, 2, 2, 10, 1])
			),
			\dur, 0.05
		),
		Pbind(
			\type, \set,
			\id, ~supraPlay.collect{ arg i; i.nodeID },
			\args, #[\amp],
			\amp, Pseg(
				Pseq([0.5, 0]),
				Pseq([3, 3])
			),
			\dur, 0.05
		),
		Pbind(
			\type, \set,
			\id, (
				~microRec.collect{ arg i; i.nodeID } ++
				~mesoRec.collect{ arg i; i.nodeID } ++
				~supraRec.collect{ arg i; i.nodeID }
			),
			\args, #[\recLevel],
			\recLevel, Pseq([0.001, 0.2]), // ver era 0.5
			\dur, Pseq([1, 1])
		)
	]).play;

	if(~flautaWav) {
		0.2.wait;
		
		{ [2, ~flInBus].do { arg i; Out.ar(
			i,
			PlayBuf.ar(
				1,
				~wavBufferC,
				BufRateScale.kr(~wavBufferC),
				loop:0, doneAction:2
			) * ~wavGain
		)}}.play;
	};
});

//p = ~pC.play;
//p.stop;

// *** D ***

~pD = Pseq([
	Ptpar([
		0,
		~materialPiano.(
			octr: 48,
			offr: 0,
			reg: [24, 72, 84, 96, 72, 84, 96, 72, 84, 96, 12, 12],
			repp: [1, 2, 3],
			rept: 6,
			conjs: [[8, 9, 10], [11, 0, 1], [2, 3, 4]],
			midiout: ~midiOut
		),
		3, // aprox. de la dur anterior
		Pbind(
			\type, \set,
			\id, ~supraPlay.collect{ arg i; i.nodeID },
			\args, #[\amp],
			\amp, Pseg(
				Pseq([0, 1, 1, 0]), // ver!!!
				Pseq([1, 6.5, 2.1, 0.05])
			),
			\dur, 0.001
		)
	]),
	4,
	// no se puede hacer Ptpar( Pseq([Ptpar(), 1, Ptpar()]) ), recursión fundamental...
	Pseq([
		~materialPiano.(
			octr: 48,
			offr: 0,
			reg: [24, 36, 48, 60, 72, 84, 96, 84, 72, 60, 48, 36],
			repp: [1],
			rept: 4,
			conjs: [[6, 7, 8], [9, 10, 11], [0, 2, 3], [5, 1, 4]],
			midiout: ~midiOut
	), 3], 2),
	0,
	Ptpar([
		0,
		~materialPiano.(
			octr: 48,
			offr: 0,
			reg: [24, 72, 84, 96, 72, 84, 96, 72, 84, 96, 12, 12],
			repp: [2, 3],
			rept: 5,
			conjs: [[8, 9, 10], [11, 0, 1], [2, 3, 4]],
			midiout: ~midiOut
		),
		2,
		Pbind(
			\type, \set,
			\id, ~supraPlay.collect{ arg i; i.nodeID },
			\args, #[\amp],
			\amp, Pseg(
				Pseq([0, 1, 1, 0]),
				Pseq([0.1, 6.9, 3.9, 0.05])
			),
			\dur, 0.001
		)
	]),
	1,
	~materialPiano.(
		octr: 12,
		offr: rrand(1, 120),
		reg: 24 + [0, 0, 12, 12, 24, 36, 36, 48, 60, 60, 72, 72].scramble,
		repp: [1],
		rept: 3,
		conjs: [[1, 2, 3], [4, 5, 6], [7, 8, 9], [10, 11, 0]],
		midiout: ~midiOut
	)
]);

//p = ~pD.play;
//p.stop;

// *** E ***

~pE = Routine.new({
	~microRec.do(_.set(\recLevel, 0.5));
	~mesoRec.do(_.set(\recLevel, 0.5));
	~supraRec.do(_.set(\recLevel, 0.5));
	~microPlay.do(_.set(\lagAmp, 2, \amp, 0.3)); // era 0.7!!!
	~mesoPlay.do(_.set(\lagAmp, 2, \amp, 0.3));
	~supraPlay.do(_.set(\lagAmp, 2, \amp, 0.3));
	
	if(~flautaWav) {
		0.2.wait;
		
		{ [2, ~flInBus].do { arg i; Out.ar(
			i,			
			PlayBuf.ar(
				1,
				~wavBufferE,
				BufRateScale.kr(~wavBufferE),
				loop:0, doneAction:2
			) * ~wavGain
		)}}.play;
	};
});

//~pE.play; // sync con ataque de flauta

// *** F ***

~pF = Routine.new({
	var offrA = [112, 0, 121];
	var regA = [
		[84, 24, 84, 72, 24, 48, 36, 60, 60, 96, 84, 36],
		[84, 84, 24, 72, 84, 48, 36, 60, 72, 96, 84, 36],
		[84, 24, 84, 72, 96, 48, 84, 36, 72, 84, 96, 48]
	];
	var ampA = [
		Prand((3..5) * 0.1, inf),
		Prand((3..6) * 0.1, inf),
		Prand((4..5) * 0.1, inf)
	];

	var solo = { arg midinote, durSolo;
		midinote.collect({ arg note, i;
			[
				durSolo[i],
				Pbind(
					\type, \midi,
					\midinote, note + 60,
					\midiout, ~midiOut,
					\dur, (note - 3).midicps.reciprocal, // por el piano/midi
					\amp, Pseg(
						Pseq([0, 0.5, 0]),
						Pseq([2, 4, 1])
					)
				)
			]
		}).flat;
	};
	var tutti = {
		([84, 24, 84, 72, 24, 48, 36, 60, 60, 96, 84, 36] +
		[1, 2, 4, 6, 3, 5, 7, 8, 9, 10, 11, 0])
		.collect { arg note;
			Pbind(
				\type, \midi,
				\midinote, note,
				\midiout, ~midiOut,
				\dur, (note % 12).midicps.reciprocal,
				\amp, Pseg(
					Pseq([0, 0.5, 0]),
					Pseq([rrand(1, 4), rrand(4, 8), 1])
				)
			)
		};
	};

	var offrB = [0, 151, 0, 1];
	var regB = [
		[84, 60, 96, 72, 96, 48, 84, 36, 72, 96, 84, 60],
		[84, 72, 96, 72, 96, 60, 84, 36, 72, 84, 96, 72],
		[96, 72, 96, 72, 96, 60, 84, 48, 72, 84, 84, 84],
		[84, 84, 96, 72, 96, 72, 84, 72, 72, 96, 84, 96]
	];
	var ampB = [
		Prand((3..7) * 0.1, inf),
		Prand((4..6) * 0.1, inf),
		Prand((4..7) * 0.1, inf),
		Prand((3..8) * 0.1, inf)
	];
	
	~microPlay.do(_.set(\lagAmp, 1, \amp, 0.001));
	~mesoPlay.do(_.set(\lagAmp, 1, \amp, 0.001));
	~supraPlay.do(_.set(\lagAmp, 1, \amp, 0.001));
	
	8.wait; // 4 segundos después del final del fis de flauta

	p = Pseq([
		Pseq(
			[[60, 2], [72, 1], [60, 2]].collect({ arg terep, i; ~materialPiano.(
				octr: terep[0],
				offr: offrA[i],
				reg: regA[i],
				repp: [1],
				rept: 30 * terep[1],
				conjs: [[1, 2, 4, 6], [3, 5, 7, 8], [9, 10, 11, 0]],
				midiout: ~midiOut,
				amp: ampA[i]
			)})
		),
		4, // G.P.
		Ptpar([
			0,
			Ptpar(solo.value([3, 2], [0, 3])),
			5,
			Ppar(tutti.value),
			12,
			Ptpar(solo.value([3, 2, 5, 4, 18], [0, 2, 4, 9, 11])),
			25,
			Ppar(tutti.value)
		]),
		0.25,
		Pseq(
			[[72, 1], [60, 2], [72, 1], [72, 1]].collect({ arg terep, i; ~materialPiano.(
				octr: terep[0],
				offr: offrB[i],
				reg: regB[i],
				repp: [1],
				rept: 30 * terep[1],
				conjs: [[1, 2, 4, 6], [3, 5, 7, 8], [9, 10, 11, 0]],
				midiout: ~midiOut,
				amp: ampB[i]
			)})
		)
	]).play;
});

//~pF.play;
//p.stop;

// *** G ***

~pG = Routine.new({
	~allNotesOff.value;
	~microRec.do(_.set(\recLevel, 0.001));
	~mesoRec.do(_.set(\recLevel, 0.001));
	~supraRec.do(_.set(\recLevel, 0.001));
	~flResponder.add;
	
	if(~flautaWav) {
		0.2.wait;
		
		{ [2, ~flInBus].do { arg i; Out.ar(
			i,
			PlayBuf.ar(
				1,
				~wavBufferG,
				BufRateScale.kr(~wavBufferG),
				loop:0, doneAction:2
			) * ~wavGain
		)}}.play;
	};
});

//~pG.play;
//~gflAmpFactor = 20;

// *** H ***

~pH = Routine.new({
	var dens = 24;
	var dens2 = 36;
	var repe;
	var alte = 2;

	~flResponder.remove;

	~microRec.do(_.set(\recLevel, 0.000001));
	~mesoRec.do(_.set(\recLevel, 0.000001));
	~supraRec.do(_.set(\recLevel, 0.000001));
	~microRec.do(_.set(\preLevel, 0.4));
	~mesoRec.do(_.set(\preLevel, 0.4));
	~supraRec.do(_.set(\preLevel, 0.2));
	~microPlay.do(_.set(\amp, 0.0));
	~mesoPlay.do(_.set(\amp, 0.0));
	~supraPlay.do(_.set(\amp, 0.0));

	alte.do { arg i;
		repe = [3, 4, 5, 6].choose.postln;
		p = Ptpar([
			{ rrand(0.2, repe) }!dens,
			{ Pbind(
				\instrument, \reactGrain,
				\group, ~detGroup2,
				\out, Prand([0, 1], repe),
				\midinote, Pxrand((48..96), repe),
				\amp, ~ampReactGrain,
				\buffer, ~supraBuffers.choose,
				\kFreq, ~flFreqBus,
				\kAmp, ~flAmpBus,
				\banda, 2,
				\dur, Pxrand([0.5, 1.0, 1.5] * rrand(1.0, 2.0), repe)
			)}!dens
		].flop.flat).play;
		(repe * 1.5).wait;

		repe = [5, 6, 7, 8].choose.postln;
		p = Ptpar([
			{ rrand(0.2, repe) }!dens2,
			{ Pbind(
				\instrument, \reactFil,
				\group, ~detGroup2,
				\out, Prand([0, 1], repe),
				\midinote, Pxrand((36..108), repe),
				\amp, ~ampReactFil,
				\buffer, ~supraBuffers.choose,
				\kFreq, ~flFreqBus,
				\kAmp, ~flAmpBus,
				\banda, 4,
				\dur, Pxrand([0.5, 1.0, 1.5] * rrand(1.0, 2.0), repe)
			)}!dens2
		].flop.flat).play;
		(repe * 1.5).wait;
	};
});

//~pH.play;
//~pH.stop;
//p.stop;

// *** I ***

~pI = Routine.new({
	var dens = 48;

	~microRec.do(_.set(\recLevel, 0.5));
	~mesoRec.do(_.set(\recLevel, 0.5));
	~supraRec.do(_.set(\recLevel, 0.5));
	~microPlay.do(_.set(\amp, 0.0));
	~mesoPlay.do(_.set(\amp, 0.0));
	~supraPlay.do(_.set(\amp, 0.0));

	p = Ptpar([
		{ rrand(0.2, 20) }!dens, // puede ser una función no evaluada
		{ Pbind(
			\instrument, \reactGrain,
			\group, ~detGroup2,
			\out, Prand([0, 1], inf),
//			\midinote, Pxrand((24..108), inf),
			\midinote, Pseq([
				Pxrand((24..108)),
				Pxrand((38..98)),
				Pxrand((52..88)),
				Pxrand((66..79))
			], inf),
			\amp, ~ampReactGrain,
			\buffer, ~supraBuffers.choose,
			\kFreq, ~flFreqBus,
			\kAmp, ~flAmpBus,
			\banda, 1,
			\dur, Pxrand([0.5, 1.0, 1.5] * rrand(1.0, 2.0), inf)
		)}!dens
	].flop.flat).play;
	
	if(~flautaWav) {
		1.5.wait;
		
		{ [2, ~flInBus].do { arg i; Out.ar(
			i,
			PlayBuf.ar(
				1,
				~wavBufferI,
				BufRateScale.kr(~wavBufferI),
				loop:0, doneAction:2
			) * ~wavGain
		)}}.play;
	};
});

//~pI.play;
//p.stop;

// *** J ***

~pJ = Routine.new({
	p.stop;
	~flResponder.add;
	
	if(~flautaWav) {
		3.wait;
		
		{ [2, ~flInBus].do { arg i; Out.ar(
			i,
			PlayBuf.ar(
				1,
				~wavBufferJ,
				BufRateScale.kr(~wavBufferJ),
				loop:0, doneAction:2
			) * ~wavGain
		)}}.play;
	};
});

//~pJ.play;

// *** K ***

~pK = Routine.new({
	~flResponder.remove;

	~microRec.do(_.set(\recLevel, 0.5));
	~mesoRec.do(_.set(\recLevel, 0.5));
	~supraRec.do(_.set(\recLevel, 0.5));
	~microRec.do(_.set(\preLevel, 0.9));
	~mesoRec.do(_.set(\preLevel, 0.9));
	~supraRec.do(_.set(\preLevel, 0.9));
	~microPlay.do(_.set(\amp, 0.0));
	~mesoPlay.do(_.set(\amp, 0.5));
	~supraPlay.do(_.set(\amp, 0.0));
	
	0.01.wait;

	p = ~materialPiano.(
		octr: 0,
		offr: 271,
		reg: [0, 0, 0, 0, 24, 72, 36, 84, 0, 92, 0, 0],
		repp: [1],
		rept: 3,
		conjs: [[4, 6], [5, 7], [9]],
		midiout: ~midiOut
	).play
});

//~pK.play;
//p.stop;

// *** L ***

~pL = Routine.new({
	var dens = 48;
	var dens2 = 36;
	var repe;
	var alte = 4; // 4 es ca. 1'15''

	~microRec.do(_.set(\recLevel, 0.5));
	~mesoRec.do(_.set(\recLevel, 0.5));
	~supraRec.do(_.set(\recLevel, 0.5));
	
	Pbind(
		\type, \set,
		\id, ~mesoPlay.collect{ arg i; i.nodeID },
		\args, #[\amp],
		\amp, Pseg(
			Pseq([0.8, 0.0]), // valor previo
			Pseq([10, 1])
		),
		\dur, 0.05
	).play;
	
	if(~flautaWav) {
		fork {
			0.5.wait;
			
			{ [2, ~flInBus].do { arg i; Out.ar(
				i,
				PlayBuf.ar(
					1,
					~wavBufferL,
					BufRateScale.kr(~wavBufferL),
					loop:0, doneAction:2
				) * ~wavGain
			)}}.play;
		}
	};
	
	alte.do { arg i;
		repe = [4, 5, 6, 7].choose.postln;
		p = Ptpar([
			{ rrand(0.2, repe) }!dens,
			{ Pbind(
				\instrument, \reactGrain,
				\group, ~detGroup2,
				\out, Prand([0, 1], repe),
				\midinote, Pxrand((48..96), repe),
				\amp, ~ampReactGrain,
				\buffer, ~supraBuffers.choose,
				\kFreq, ~flFreqBus,
				\kAmp, ~flAmpBus,
				\banda, 2,
				\dur, Pxrand([0.5, 1.0, 1.5] * rrand(1.0, 2.0), repe)
			)}!dens
		].flop.flat).play;
		(repe * 1.5).wait;

		repe = [6, 7, 8, 9].choose.postln;
		p = Ptpar([
			{ rrand(0.2, repe) }!dens2,
			{ Pbind(
				\instrument, \reactFil,
				\group, ~detGroup2,
				\out, Prand([0, 1], repe),
				\midinote, Pxrand((24..108), repe),
				\amp, ~ampReactFil,
				\buffer, ~supraBuffers.choose,
				\kFreq, ~flFreqBus,
				\kAmp, ~flAmpBus,
				\banda, 4,
				\dur, Pxrand([0.5, 1.0, 1.5] * rrand(1.0, 2.0), repe)
			)}!dens2
		].flop.flat).play;
		(repe * 1.5).wait;
	};
});

//~pL.play;
//~pL.stop;
//p.stop;
