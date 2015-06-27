// Audio Setup (Entradas, mix, det, react)

~audioSetup = {
	
	// Audio Setup 0
	// input & det

	SynthDef(\soundIn, { arg chan, outBus, gain = 1;
		Out.ar(outBus, SoundIn.ar(chan) * gain);
	}).add;
	
	SynthDef(\mixfp, { arg pno, fl, fpBus, pnoGain = 1, flGain = 1;
		Out.ar(fpBus, In.ar(pno) + In.ar(fl));
	}).add;
	
	SynthDef(\ampDet, { arg in, outBus;
		var src = Amplitude.kr(In.ar(in));
		Out.kr(outBus, src);
	}).add;
	
	SynthDef(\freqDet, { arg in, outBus;
		var freq, hasFreq;
		#freq, hasFreq = Pitch.kr(In.ar(in));
		Out.kr(outBus, [freq, hasFreq]);
	}).add;
	
	SynthDef(\cpsmidiDet, { arg in;
		var freq, hasFreq, dust;
		#freq, hasFreq = Pitch.kr(In.ar(in));
		dust = Dust.kr(20) * EnvGen.kr(Env.asr(0.01, 1, 0.01), hasFreq);
		SendTrig.kr(dust, 0, freq.cpsmidi + TRand.kr(-1, 1, dust));
	}).add;
	
	s.sync;
	
	~inGroup = Group.tail(s);
	
	~detGroup1 = Group.tail(s);
	~detGroup2 = Group.tail(s);
	
	~pnoInBus = Bus.audio(s, 1);
	~flInBus = Bus.audio(s, 1);
	~fpInBus = Bus.audio(s, 1);
	
	~flAmpBus = Bus.control(s, 1);
	~flFreqBus = Bus.control(s, 2);
	
	~audioSetup0 = {
		~soundInSynth = [];
		~soundInSynth = ~soundInSynth ++ Synth(\soundIn, [chan: 0, outBus: ~flInBus], ~inGroup);
		~soundInSynth = ~soundInSynth ++ Synth(\soundIn, [chan: 1, outBus: ~pnoInBus], ~inGroup);
	
		~soundMixSynth = Synth(\mixfp, [pno: ~pnoInBus, fl: ~flInBus, fpBus: ~fpInBus], ~inGroup, \addToTail);
	
		~flAmpDetSynth = Synth(\ampDet, [in: ~flInBus, outBus: ~flAmpBus], ~detGroup1, \addToTail);
		~flFreqDetSynth = Synth(\freqDet, [in: ~flInBus, outBus: ~flFreqBus], ~detGroup1, \addToTail);
		~cpsmidiDetSynth = Synth(\cpsmidiDet, [in: ~flInBus], ~detGroup1, \addToTail);
	};
	~audioSetup0.value;

	// Audio Setup 1
	// buffers

	SynthDef(\recIn, { arg inBus, buffer, umbral = 0, recLevel = 0, lagRecLevel = 0.1, preLevel = 0.9;
		var input = In.ar(inBus);
		var ampGate = Amplitude.ar(input) > umbral; // 0.1 cpu crece... (porque recLevel es cero...)
		input = input * ampGate.lag(0.2);
		RecordBuf.ar(input, buffer, recLevel:recLevel.lag(lagRecLevel), preLevel:preLevel, loop: 1);
	}).add;
	
	SynthDef(\recBuff, { arg in, buffer, recLevel = 0, lagRecLevel = 0.1, preLevel = 0.9;
		var input = PlayBuf.ar(1, in, loop: 1);
		RecordBuf.ar(input, buffer, recLevel:recLevel.lag(lagRecLevel), preLevel:preLevel, loop: 1);
	}).add;
	
	SynthDef(\playBuff, { arg out = 0, buffer, amp = 0, lagAmp = 0.1;
		var record = PlayBuf.ar(1, buffer, loop: 1);
		Out.ar(out, record * amp.lag(lagAmp));
	}).add;
	
	s.sync;
	
	~ecoGroup1 = Group.tail(s);
	~ecoGroup2 = Group.tail(s);
	~ecoGroup3 = Group.tail(s);
	
	~micro = (12..23).midicps.reciprocal;
	~meso = (-25..-36).midicps.reciprocal;
	~supra = (-73..-84).midicps.reciprocal;
	
	~microBuffers = { arg i; Buffer.alloc(s, Server.default.sampleRate * ~micro[i], 1) }!~micro.size;
	~mesoBuffers = { arg i; Buffer.alloc(s, Server.default.sampleRate * ~meso[i], 1) }!~meso.size;
	~supraBuffers = { arg i; Buffer.alloc(s, Server.default.sampleRate * ~supra[i], 1) }!~supra.size;
	
	~audioSetup1 = {	
		~microRec = [];
		~microPlay = [];
		~micro.size.do { arg i;
			~microRec = ~microRec ++ Synth(\recIn, [inBus: ~fpInBus, buffer: ~microBuffers[i]], ~ecoGroup1);
			~microPlay = ~microPlay ++ Synth(\playBuff, [out: [0, 1].choose, buffer: ~microBuffers[i]], ~ecoGroup2);
		};
		
		~mesoRec = [];
		~mesoPlay = [];
		~meso.size.do { arg i;
			~mesoRec = ~mesoRec ++ Synth(\recIn, [inBus: ~fpInBus, buffer: ~mesoBuffers[i]], ~ecoGroup1);
			~mesoPlay = ~mesoPlay ++ Synth(\playBuff, [out: [0, 1].choose, buffer: ~mesoBuffers[i]], ~ecoGroup2);
		};
		
		~supraRec = [];
		~supraPlay = [];
		~supra.size.do { arg i;
			~supraRec = ~supraRec ++ Synth(\recBuff, [in: ~microBuffers[i], buffer: ~supraBuffers[i]], ~ecoGroup2);
			~supraPlay = ~supraPlay ++ Synth(\playBuff, [out: [0, 1].choose, buffer: ~supraBuffers[i]], ~ecoGroup3);
		};
	};
	~audioSetup1.value;
	
	/*
	~freeSoundIn = {
		(~soundInSynth ++ ~soundMixSynth).do(_.free);
	};
	
	~freeEcoSynths = {
		[~microRec, ~microPlay, ~mesoRec, ~mesoPlay, ~supraRec, ~supraPlay].do{ arg i; i.do(_.free) };
	};
	
	~freeEcoBuffers = {
		[~microBuffers, ~mesoBuffers, ~supraBuffers].do{ arg i; i.do(_.free) };
	};
	*/

	// Audio Setup 2
	// reactivos

	~ampReactGrain = 4;
	~ampReactFil = 1;
	
	SynthDef(\reactGrain, { arg out = 0, freq = 440, amp = 0.0005, buffer, kFreq, kAmp, banda = 0.5;
		var fgate = (
			(In.kr(kFreq) > (freq * (2 ** ((banda * -1)/12))))
			* (In.kr(kFreq) < (freq * (2 ** (banda/12))))
			* In.kr(kFreq, 2)[1]
		).lag(1);
	
		var grains = TGrains.ar(
			numChannels: 2,
			trigger: Impulse.ar(freq),
			bufnum: buffer,
			rate: 1,
			centerPos: Rand(0, BufDur.kr(buffer))
				* LFNoise2.ar(0.1 + (kAmp * fgate), 0.1, 0.1),
			dur: 1.25 / freq,
			pan: -1
		);
	
		var env = EnvGen.kr(Env.perc(2.5, 0.5), doneAction:2);
		amp = amp * (1 + (5 * fgate));
		
		Out.ar(out, grains * env * amp);
	}).add;
	
	SynthDef(\reactFil, { arg out = 0, freq = 440, amp = 0.0005, buffer, kFreq, kAmp, banda = 0.5; // kAmp
		var bw = (freq * (2 ** (banda/12)));
		var fgate = (
			(In.kr(kFreq) > (freq * (2 ** ((banda * -1)/12))))
			* (In.kr(kFreq) < bw)
			* In.kr(kFreq, 2)[1]
		).lag(1);
	
		var src = PlayBuf.ar(1, buffer, startPos: Rand(0, BufDur.kr(buffer)), loop: 1);
		var env = EnvGen.kr(Env.perc(2.5, 0.5), doneAction:2);
	
		bw = bw * 0.1;
		src = Resonz.ar(src, freq, bw/freq);
		amp = amp * (1 + (5 * fgate));
	
		Out.ar(out, src * env * amp);
	}).add;
	
	s.sync;
	
	// Audio Setup 3
	// ~flResponder
	
	~audioSetup3 = {
		~gflAmp = 0.1;
		~gflAmpFactor = 8;
		
		~flResponder = OSCresponder(s.addr, \tr, { arg time, resp, msg;
			~flAmpBus.get({arg i; ~gflAmp = i});
			(
				midinote: msg.last.round,
				dur: 0.1,
				amp: rrand(0.01, ~gflAmp * ~gflAmpFactor),
				type: \midi,
				midiout: ~midiOut
			).play;
		});
	};
	~audioSetup3.value;
	
	"audio listo".postln;
}; // EOF ~audioSetup

// Piano Setup

~midiSetup = { arg midiOutput = 0;

	~midiOut = MIDIOut(midiOutput);
	
	~materialPiano = { arg octr = 0, offr = 62, reg = {60}!12,
		                   repp = [1, 2, 3, 4, 5], rept = 4,
		                   conjs = [[1, 2, 3], [4, 5, 6], [7, 8, 9], [10, 11, 0]],
		                   midiout, legato = 0.9, chan = 0, amp = 0.5;
	
		var peri = ((-60..-49) + octr).collect({ arg i; i.midicps.reciprocal });
		var offset = peri - (offr % peri);
	
		Post << "offr = " << offr << "\n"
			<< "reg = " << reg << "\n";
		
		Ptpar(
			conjs.flop.collect({ arg i, j;
				var ad = i.collect({ arg i;
					var r = repp.choose; [Pn(i + reg[i], r), Pn(peri[i], r)]
				}).flop;
				[
					offset[i[0]],
					Pbind(
						\midinote, Pseq(ad[0], rept),
						\dur, Pseq(ad[1], rept),
						\amp, amp,
						\legato, legato,
						\type, \midi,
						\midiout, midiout,
						\chan, chan
					)
				];
			}).flat;
		);
	};
	
	~allNotesOff = { (0..16).do { arg i; ~midiOut.allNotesOff(i) } };
	
	"midi listo".postln;
}; // EOF ~midiSetup
