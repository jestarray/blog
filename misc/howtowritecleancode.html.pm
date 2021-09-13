#lang pollen
◊h1{How to write clean code}

◊ptime{10/06/20}

◊sub-heading{Who cares!?}
No really, this isn't me being cynical but who actually cares? You? The compiler? Coworkers reading and modifying your code? Fellow programmers importing and trying to use your code? The consumer that is running your code?

◊sub-heading{Metrics}

For the compiler, it'd be less work for it to resolve dependencies accross files, so by this metric it'd be best if you put everything in 1 file.

For programmers importing your code as a lib, they want the least amount of friction possible for integration. Sometimes this involves keeping everything in 1 file like the famous ◊a[#:href "https://github.com/nothings/stb"]{stb C libraries}.

The consumer doesn't even see your code and probably does not care so long as it preforms fast, which is not always synonymous with "clean code".

◊sub-heading{When?!}

A more important question is not "how to write clean code" but "when" to write clean code.

When you start out programming, your style is heavily influenced by the resources you consume. In my college years I took a class on Java and I had never used an OOP centric language before. For my end semester project I choose to write a game and looked up some videos on how to write the renderer and basic game loop. The guy was typing getters and setters everywhere and I didn't really know why at the time or what problems would arise if I didn't type them in so I just blindly followed him. It wasn't until my fingers started hurting from typing them everywhere did I consider making everything public! To my surprise, my computer didn't blow up, and the game ran just fine. It wasn't until some more thought and reflecting that I found the reason why people wrap everything in getters and setters, is that they want to "get" data in a different way, e.g a different measurement metric from what is stored, or set data on certain conditions or transformations, e.g lowercasing every username before storing it and sending it to query a database(because it would be annoying to need to capitalize your UserName so tightly specifically in order to login).

For example:
- Radians to degrees and vice versa

◊pre{
    ◊(code #:class "language-javascript"
"
class Player {
    constructor(username, degrees) {
        this.username = username;
//rotation is internally stored in radians(maybe because some rendering engine uses radians, etc) but degrees is more comfortable to take as input
        this.rotation = this.setRotation(degrees);
    }
    setRotation(degrees) {
        this.rotation = degrees * Math.PI / 180; //converts it to radians before storing it
    }
    getRotationInDegrees(){
        return this.rotation * 180 / Math.PI;
    }
}
")
}

So why was this guy writing getters and setters when they didn't do anything?
◊pre{
    ◊(code #:class "language-javascript"
"
class Player {
    constructor(x, y) {
        this.x = x;
        this.y = y;
    }
    getX(){ return this.x }
    getY(){ return this.y }
    setX(x) { this.x = x; }
    setY(y) { this.y = y; }
}
")
}

They just returned the data that you could get by using the ◊i{.} dot operator, or set data using ◊i{=} equals. It's most likely because he learned the style from someone else. Another reason why is pre-architecting so that when the time comes they won't have to type it! But now instead of typing
◊pre{
    ◊(code #:class "language-javascript"
"
let player1 = Player(5, 20);
if(walkingRight){
    //opposed to:
    //player1.x++;
    //you have to type 21 extra characters to increment!
    player1.setX(player1.getX()+=1);
}

When you actually 'get' data in a special way that transforms it, and 'set' it
in a way that needs to transform it, only then does this it make sense
(e.g the degrees vs angle example earlier)

player1.setRotation(player1.getRotationInDegrees() + 90);
")
}


Avoid pre-architecting! Unlike architecture where you have to pre-plan everything because you can't just say "oh nevermind, I don't want this room/wall anymore" without paying a hefty price, re-factoring code is nearly free with Control+F and IDE/compiler warnings. Not to mention by pre-planning could actually be worse because you will now have to shoehorn your code to fit with a specific 'design pattern'.

I used to think programming was a field that was completely figured out, but while we've made tons of progress catagorizing different approaches to problems, the problems you specifically have and the codebase that grows, will often eventually deviate from what is transcribed!

◊sub-heading{A new metric for clean code}

Here are some references from credible sources that challenge conventional notions of what 'clean code' is.

Handmade Hero - (32:00 -> 35:00) ~4 minutes

◊yt{bERy-zhosqY?t=1960}

Transcribed:
◊blockquote{Somebody was saying on the forums a while back that they felt like the code is too messy and again I really want to stress the fact that I dont really want to tell people the way they code is wrong, I feel like that leads to a lot of pendantic arguments that arent particularly constructive, but what I can say is nobody in my mind should be thinking that this code is messy, this code is exactly what it should be. It's code that we're writing to figure out how we want to structure our program and if you're spending time right now thinking about how to make this code "not messy", whatever that means to you, then essentially what you're doing is wasting time. You're spending time that should have been spent on the problem, thinking about the code, and the end state of your program is not to have clean code, it's to have good working code. Cleanliness has nothing to do with those things, if you have the ugliest code in the world that someone would look at and call very messy but it has no bugs and runs great, then it didn't matter, so to the point we care about how clean code is, we only care about that in so far that it has an effect on our end product, and what we're trying to do right now is trying to define the structure of the code, so none of the code will ship in the game or if it does, it got pulled out and changed around a little, and put into its proper place, and so we know it will clean up overtime as we learn what it should be, but prematurely cleaning it is actually worse than wasting time but it may lead us down to wrong paths and end up making us have to to girations to make stuff work together because we segregated in a bad way too early on. If the way you look at code is that you think of it as messy or clean, that is a very bad habit IMO. Instead think about the problem you're trying to solve. When you are done and to your satisfaction solved that problem in however messy a way as you can, then that is the time to start thinking about cleanliness of code, and what we mean by that is, can we find the bugs in it easily, is it easy to understand, is it easy for me to re-use it, in the places where I need to reuse it, etc, and NEVER some set of perscribed set of rules based on what the code looks like, it's only based on what the usage looks like and what the debugging process looks like, and this is what seperates good programmers and bad programmers. - Casey Muratori}

OOP is not the end all be all to software design and is unsustainable in realtime applications:
Scott Meyers - (45:25 -> 49:00) ~4 minutes
◊yt{WDIkqP4JbkE?t=2725}

◊blockquote{The fundamental idea of Object Oriented Programming, "OBJECT ORIETENED PROGRAMMING", we take the data, we take the functions, we bring them together so the programmer can make sense of it and now we say we take the data and the instructions and we pick it a part and parcel it out, because the hardware does not like objects -Scott Meyers}
P.S Don't stop using booleans in structs and take this advice to heart unless you're making a AAA game that needs to milk every ounce of performance to hit 60 fps. SOLID/etc work okay if applied reasonably but even then it prematurely decouples everything... try looking into functional programming!


Catherine West - The failures of Object Oriented Design and applying SOLID principles in video games:
(too many accessors and needless decoupling)
◊yt{aKLntZcp27M}

