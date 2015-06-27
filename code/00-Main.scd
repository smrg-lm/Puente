// main

(Document.current.dir ++ "/01-Setup.scd").load;
Server.local.options.outDevice = ServerOptions.devices[3];
s.options.numInputBusChannels = 3;
s.options.numOutputBusChannels = 3;
s.boot;
s.doWhenBooted(~audioSetup); // no bootea

MIDIClient.init;
~midiSetup.(3); // seleccionar el canal de la placa

(Document.current.dir ++ "/02-Secciones.scd").load;

~flautaWav = true;
~wavGain = 0.15; // PROBAR ASê (Subir reactGrain y glfAmpFactor...
~wavBufferA = Buffer.read(s, Document.current.dir ++ "/wav/" ++ "parteA.wav");
~wavBufferC = Buffer.read(s, Document.current.dir ++ "/wav/" ++ "parteC.wav");
~wavBufferE = Buffer.read(s, Document.current.dir ++ "/wav/" ++ "parteE.wav");
~wavBufferG = Buffer.read(s, Document.current.dir ++ "/wav/" ++ "parteG.wav");
~wavBufferI = Buffer.read(s, Document.current.dir ++ "/wav/" ++ "parteI.wav");
~wavBufferJ = Buffer.read(s, Document.current.dir ++ "/wav/" ++ "parteJ.wav");
~wavBufferL = Buffer.read(s, Document.current.dir ++ "/wav/" ++ "parteL.wav");

(Document.current.dir ++ "/03-Partitura.scd").load;
Server.local.meter;
~partituraInteractiva.(Document.current.dir ++ "/png" );


// ver si H no genera clicks por la baja de prevLevel
