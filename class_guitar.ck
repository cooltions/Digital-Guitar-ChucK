/*
    Digital Guitar v0.5
    Developed by Dylan Sukha
*/
public class Guitar {
    
    "basic" => string mode; //Mode field.
    
    // Basic Guitar
    SqrOsc i => ADSR e => LPF lp => Gain g1; //Forward sig-chain.
    lp => DelayL dl => Gain g2 => lp; //Feedback sig-chain.
    1 => i.gain;// setting the oscillator's gain:
    1000/Std.mtof(40) => float length; //Pitch
    length::ms => dl.delay;
    0.91 => g2.gain; //"stringiness"
    g1.gain(1);
    lp.Q(0.88);
    e.set(0::ms, 2::ms, 0.0, 0::ms); //Short envelope.
    
    //Twangy Guitar
    Noise imp => OneZero lowpass => Gain dec; //Forward sig-chain.
    lowpass => Delay delay => lowpass; //Feedback sig-chain.
    .9991 => float R; //Radius
    1000/(Std.mtof(40)) => float L; //Pitch
    L::ms => delay.delay;
    Math.pow( R, L ) => delay.gain; //Dissipation factor.
    -0.5 => lowpass.zero; //Placement of the 'zero' transfer function.
    dec.gain(0.9);
    0.5 => float strike;
    strike * 1 => imp.gain; 1::ms => now; 0 => imp.gain;
    
    fun void basic(UGen u) { //Set signal chain to the basic guitar.
        "basic" => mode;
        dec =< u;
        g1 =< u;
        g1 => u;
    }
    
    fun void twang(UGen u) { //Set signal chain to the twangy guitar.
        "twang" => mode;
        0 => imp.gain;
        -0.5 => lowpass.zero;
        g1 =< u;
        dec =< u;
        dec => u;
    }
    fun void over(UGen u) { //Set signal chain to the twangy guitar + zero-shift.
        "over" => mode;
        0 => imp.gain;
        -30 => lowpass.zero;
        g1 =< u;
        dec =< u;
        dec => u;
    }
    
    fun void pluck(int n, int intv) {
        if(mode == "basic") pluck1(n, intv);
        else if(mode == "twang" || mode == "over") pluck2(n, intv);
    }
    
    fun void pluck(int n[], int intv) {
        if(mode == "basic") pluck1(n, intv);
        else if(mode == "twang" || mode == "over") pluck2(n, intv);
    }
    
    fun void pluck1(int n, int intv) {
        Std.mtof(n)*4 => lp.freq;
        (1000/(Std.mtof(n)))::ms => dl.delay;
        e.keyOn();
        (1000/(Std.mtof(n)))::ms => now;
        intv::ms => now;
    }
    
    fun void pluck1(int n[], int intv) {
        for(0 => int i; i<n.cap(); i++) {
            Std.mtof(n[i])*4 => lp.freq;
            (1000/(Std.mtof(n[i])))::ms => dl.delay;
            e.keyOn();
            (1000/(Std.mtof(n[i])))::ms => now;
            intv::ms => now;
        }
    }
    
    fun void pluck2(int n, int intv) {
        Math.pow( R,  (1000/(Std.mtof(n))) ) => delay.gain;
        (1000/(Std.mtof(n)))::ms => delay.delay;
        if(n>0) strike * 1 => imp.gain;
        L::ms => now;
        0 => imp.gain;
        intv::ms => now;
    }
    
    fun void pluck2(int n[], int intv) {
        for(0 => int i; i<n.cap(); i++) {
            Math.pow( R,  (1000/(Std.mtof(n[i]))) ) => delay.gain;
            (1000/(Std.mtof(n[i])))::ms => delay.delay;
            if(n[i]>0) strike * 1 => imp.gain;
            L::ms => now;
            0 => imp.gain;
            intv::ms => now;
        }
    }
    
    fun void hammer(int n, int m, int ho, int h) {
        if(mode == "basic") {
            Std.mtof(n)*4 => lp.freq;
            (1000/(Std.mtof(n)))::ms => dl.delay;
            e.keyOn();
            (1000/(Std.mtof(n)))::ms => now;
            ho::ms => now; //Time to hammer on.
            Std.mtof(m)*4 => lp.freq;
            (1000/(Std.mtof(m)))::ms => dl.delay;
            h::ms => now; //Hold time.
        }
        else if(mode == "twang") {
            Math.pow( R,  (1000/(Std.mtof(n))) ) => delay.gain;
            (1000/(Std.mtof(n)))::ms => delay.delay;
            if(n>0) strike * 1 => imp.gain;
            L::ms => now;
            0 => imp.gain;
            
            ho::ms => now; //Time to hammer on.
            //if(n>0) strike * 1 => imp.gain;
            Math.pow( R,  (1000/(Std.mtof(m))) ) => delay.gain;
            (1000/(Std.mtof(m)))::ms => delay.delay;
            h::ms => now; //Hold time.
        }
    }
}