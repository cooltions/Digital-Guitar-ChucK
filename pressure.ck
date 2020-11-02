/* Sample Sequence - Pressure [Muse]
 * Please remember to add 'class_guitar.ck' to the VM first. 
 */

Machine.add(me.dir() + "class_guitar") => int layer1;

Gain g => dac;
g.gain(1.0);
Guitar git;

400 => int b;

while(1) {
    git.basic(g);
    git.pluck(59, b);
    git.pluck(58, b);
    git.pluck(57, b*2);
    git.pluck(55, b);
    git.pluck(52, b);
    git.pluck(52, b*2);
    git.hammer(50,52, b/2, b/2);
    git.hammer(52,50, b/8, b/2);
    git.pluck(47, b/2);
    git.pluck(50, b);
    git.pluck(52, b*2);
    
    git.pluck(47, b);
    git.pluck(46, b);
    git.pluck(45, b*2);
    git.pluck(43, b);
    git.pluck(40, b);
    git.pluck(40, b*2);
    git.hammer(50,52, b/2, b/2);
    git.hammer(52,50, b/8, b/2);
    git.pluck(47, b/2);
    git.pluck(50, b);
    git.pluck(52, b*2);
    
    git.twang(g);
    git.pluck(59, b);
    git.pluck(58, b);
    git.pluck(57, b*2);
    git.pluck(55, b);
    git.pluck(52, b);
    git.pluck(52, b*2);
    git.hammer(50,52, b/2, b/2);
    git.hammer(52,50, b/8, b/2);
    git.pluck(47, b/2);
    git.pluck(50, b);
    git.pluck(52, b*2);
    
    git.pluck(47, b);
    git.pluck(46, b);
    git.pluck(45, b*2);
    git.pluck(43, b);
    git.pluck(40, b);
    git.pluck(40, b*2);
    git.hammer(50,52, b/2, b/2);
    git.hammer(52,50, b/8, b/2);
    git.pluck(47, b/2);
    git.pluck(50, b);
    git.pluck(52, b*2);
}