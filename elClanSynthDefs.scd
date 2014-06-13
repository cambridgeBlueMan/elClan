// *************
// buffer player
SynthDef(\buffPlayer, {|out=0, bufnum = 0, loop = 0, amp = 0.3,  pan = 0|
	var sig = Pan2.ar(PlayBuf.ar(1, bufnum, BufRateScale.kr(bufnum), loop: loop, doneAction: 2), pan)*amp;
		Out.ar( out, sig);
}).add; // end synth def


SynthDef(\buffPlayerStereo, {| out = 0, bufnum = 0 |
	Out.ar(out,
		PlayBuf.ar(2, bufnum, BufRateScale.kr(bufnum), doneAction:2)
	)
}).add;