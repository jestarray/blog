#lang pollen 

◊h1{Programming Course Recommendations}

◊ptime{10/06/21}

These are valuable free online courses and resources that will take you to the next level of your programming career.

◊h2{Learning How to Learn}
◊a[#:href "https://www.coursera.org/learn/learning-how-to-learn"]{Learning how to learn} is not really related to programming but more generally teaches you how your brain works and effective proven strategies to help study well.

◊h2{Code by Charles Petzold}
If you ever wanted an introduction to basic eletrical engineering and the development process of how we got to 0 and 1, this book is it.

◊h2{Nand2Tetris}
◊a[#:href "https://www.coursera.org/learn/build-a-computer"]{Nand2Tetris} is a course where you build a 16 bit virtual CPU from nothing but a NAND gate, along with an assembly language, assembler, and a few games. This course was just amazing! You learn how every single 1 and 0 flow through a computer system in an approachable way with hardly any electrical engineer or math pre-reqs. I highly recommend pairing it with ◊a[#:href "https://www.goodreads.com/book/show/44882.Code"]{Code: The Hidden Language of Computer Hardware and Software}

Admittingly I found the first few parts very funky to understand as the videos tended to not put strong emphasis on key points, also there were situations in where the authors would explain the ENTIRE GUI first and then demonstrate it after which lead to double the amount of footage needed. Nonetheless I have very high respect for the authors for putting all this stuff together, so much so that I went and remade the first 25% of it, adding more context from the book Code, and clearing up some confusions I had without spoiling too much of the course.

◊(yt "e16UVGTGkw8" #:headline "My teaching of Nand2Tetris" #:open #true)
Check out the ◊a[#:href "https://www.youtube.com/watch?v=e16UVGTGkw8&list=PLitFP8FdScfEmTxYaxCIpWd_QaZtibHTp&index=1"]{playlist}!

◊h2{How to code UBC}

◊a[#:href "https://www.edx.org/course/how-to-code-simple-data"]{How to code} is what I believe to be ◊strong{the best way to start intro to programming}. I took this course after I had a few years of programming experience already and I wish I had started with this first. How most people learn programming is to hack, copy and tweak things until it works, but the problem with that is they don't know how they got to the solution or how it even works. This course ◊strong{mandates} you write down your explict reasoning process, test cases, and documentation, which really made me wonder why no other intro to programming courses are doing this as it applies common advice that is given like rubber ducky debugging, TDD, breaking down problems into smaller subtasks, thinking like a programmer etc. It is a course based off the book ◊a[#:href "https://htdp.org"]{How to design programs}. The book I cannot really recommend as video was the better format for teaching as it captured in real time the thought process of how programmers think. Currently EDX is paywalling a lot of the content which is leading me to rework the entire course.

◊(yt "SDyfgt_uF64" #:headline "My teaching of HTDP" #:open #true)

◊h2{Programming Languages A B C by Dan Grossman}
◊a[#:href "https://www.coursera.org/instructor/~873260"]{Programming Languages A B C by Dan Grossman} is a course on studying the percise semantics and mechanics of programming languages. If you've been programming for a while, maybe you've read into some OOP and a little of some FP, but don't really know the details of how they contrast, compare and the tradeoffs of both, this course is it as it brings them all together! Admittingly it is very dry and challenging but it's packed full of information from a PL desginer perspective that will get you to look at programming in a different way.

◊h2{Computer Systems A Programmers Perspective}

◊a[#:href "https://www.csapp.cs.cmu.edu/"]{Computer Systems A Programmers Perspective} aka CSAPP, covers the details of floating point, memory management, basics of how your code interacts with the operating system, lots of low level stuff. I am still in process of going through all of it. Unfortunately the global edition of the book is riddled with errors in it's practice problems due to a printing mistake and I've been going through the book writing trying to fix this problem by writing ◊a[#:href "https://jestlearn.com/computer_systems/"]{procedurally generated exercise problems}. I hope to follow up with a youtube series going over this with nand2tetris one day, but ◊a[#:href "https://www.cs.cmu.edu/afs/cs/academic/class/15213-f17/www/schedule.html"]{CMU 15-213 has video lectures freely available in the meantime}


◊h2{Handmade Hero}

◊a[#:href "https://handmadehero.org/"]{Handmade Hero} is a series teaching how to program a video games from scratch, no libraries, everything is written from scratch. It's not as good compared to the courses listed above in terms of "information density/time" since it's quite lengthy, but it's still a great series where you get to see one of the top programmers in the world work naturally and dispell a lot myths of programming. He's also working on StarCode Galaxy which is more education oriented though.

Honorable mentions:
◊a[#:href "https://github.com/getify/You-Dont-Know-JS"]{You don't know JS} if you ever want to learn JS in depth