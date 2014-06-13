(
~channels = Dictionary.new;
~eventPatterns = Dictionary.new;
~channels["piano"] = MixerChannel("piano", s, 1, 2, level: -3.44.dbamp);
~channels["guitars"] = MixerChannel("guitars", s, 1, 2, level: -6.05.dbamp);
~channels["bongo1"] = MixerChannel("bongo1", s, 1, 2, level:-17.19.dbamp);
~channels["bongo2"] = MixerChannel("bongo2", s, 1, 2, level: -14.94.dbamp);
~channels["kick2"] = MixerChannel("kick2", s, 1, 2, level: -17.8.dbamp);
~channels["kicks"] = MixerChannel("kicks", s, 1, 2, level: -6.07.dbamp);
//~channels["piano"] = MixerChannel("piano", s, 1, 2);
//~channels["piano"] = MixerChannel("piano", s, 1, 2);





b = MixingBoard("Neve", mixers: ~channels);
CmdPeriod({
	~channels.do({|item, i|
		item.free
	})
});
// ************
// piano player
~eventPatterns["piano"] = Pbind(
	\midinote, ~elClanPiano01Notes,
	\dur, ~elClanPiano01Durs,
	\out, ~channels["piano"].inbus.index
);

// *************
// guitar player

// ~eventPatterns["guitars"] = Pbind(
// 	\midinote,  Pseq([~elClanGuitars19Notes,~elClanGuitars15Notes, ~elClanGuitars17Notes, ~elClanGuitars18Notes] , inf),
// 	\dur,   Pseq([~elClanGuitars19Durs, ~elClanGuitars15Durs, ~elClanGuitars17Durs, ~elClanGuitars18Durs] , inf),
// 	\out, ~channels["guitars"].inbus.index
//
// );
// *************************************************************
~elClanGuitars17NotesVariant = Pseq(
	[
		Prand([60,63,67] ,3),
		\rest,
		Prand([65,63,62], 6),
		\rest,	Prand([63,	62,	63], 3),
		// barline
		Prand([60,	63,	67], 3),
		\rest,	Prand([65,63,65] , 3),
		// barline
		Prand([67,	68,67], 3),
		\rest,
		Prand([65,67], 2),
], 2);
~eventPatterns["guitars"] = Pbind(
	\midinote,  ~elClanGuitars17NotesVariant,
	\dur,   ~elClanGuitars17Durs,
		\out, ~channels["guitars"].inbus.index

);

// **********************************
// this is a kind of high bongo/conga
~eventPatterns["bongo1"] = Pbind(
	\instrument, \buffPlayer,
	\bufnum, ~bongo1Notes,
	\dur, ~bongo1Durs,
	\amp, 0.35,
		\out, ~channels["bongo1"].inbus.index

); //.play(myClock);

// *************************
// this is a simple off beat
~eventPatterns["bongo2"] = Pbind(
	\instrument, \buffPlayer,
	\bufnum, ~bongo2Notes.trace,
	\dur, ~bongo2Durs.trace,
	\amp, 0.25,
		\out, ~channels["bongo2"].inbus.index

); //.play(myClock);

// *******************************
// this is a kind of high kick 4's
~eventPatterns["kick2"] = Pbind(
	\instrument, \buffPlayer,
	\bufnum, ~kick2Notes,
	\dur, ~kick2Durs ,
	\amp, 0.4,
		\out, ~channels["kick2"].inbus.index

); //.play(myClock);




// ****************************************
// kick pattern, 2 drums 2 different levels
~eventPatterns["kicks"] = Pbind(
	\instrument, \buffPlayer,
	\bufnum, ~kickNotes,
	\dur, ~kickDurs,
	\amp, Pseq([0.5, 0.5, 0.4], inf),
		\out, ~channels["kicks"].inbus.index

);

Ppar(
~eventPatterns, 1
 ).play(~myClock);


)

