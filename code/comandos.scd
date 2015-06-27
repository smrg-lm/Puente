// Comandos
// archivo suelto

/*
Hacer:
- fade out distinto en cada buffer (en supra)
- interface con botones
- doWhenBooted / métodos para apagar todo al final.
*/

// setup
// secciones
~setupGeneral.value;

/*
Controles
~gflAmpFactor = 20; // piano interactivo
~ampReactGrain = 5; // electroacústica interactiva (afecta solo antes de empezar)
~ampReactFil = 1; // electroacústica interactiva (afecta solo antes de empezar)
~soundInSynth[0].set(\gain, 1); // fl
~soundInSynth[1].set(\gain, 1); // pno
~soundMixSynth.set(\pnoGain, 1, \flGain, 1); // mix
~allNotesOff.(); // pno midi
*/

// A

~pA.play;
//~pA.stop; // ahora ~pSec.stop en partitura interactiva
//p.stop;

// B

p = ~pB.play;
//p.stop;

// C

p = ~pC.play;
//p.stop;

// D

p = ~pD.play; // calcula antes el material del pno
//p.stop;

// E

~pE.play; // sync con ataque de flauta

// F

~pF.play;
//~pF.stop;
//p.stop;

// G

~pG.play;
//~gflAmpFactor = 20;

// H

//~ampReactGrain = ...; // afectan solo antes de iniciar
//~ampReactFil = ...;
~pH.play;
//~pH.stop;
//p.stop;

// I

~pI.play; // espera casi el fadeout
//p.stop;

// J

~pJ.play;

// K

~pK.play;
//p.stop;

// L

~pL.play;
//~pL.stop;
//p.stop;
