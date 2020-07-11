#lang pollen

◊h1{Evolved Simplicity}

◊ptime{4/17/20}

◊img[#:src "/images/simp.png" #:style "max-width:100%; height:auto;"]{}

A reoccuring theme that arises is the return to the beginning, a cycle of sorts. Children want to be adults, and then when they become adults, they return to wanting to being children again. This is not to say the middle part is completely baggage, in some ways it's needed to get to the state of what I call "Evolved Simplicity".

◊sub-heading{The Journey}

◊ol{
    ◊li{Start from a place of naivety}
    ◊li{Get entangled with complexity}
    ◊li{Return to simplicty with evolved context}
}

An experience I've had with evolved simplicity is with the web. I've dabbled in web development before and it's very stuck in the intermediate phase of Evolved Simplicy. The SPA phase where everything should be offloaded to the client in javascript because things wil be faster since there will be no more network requests. Well, it turns out the cost of parsing Javascript is prohibitively more expensive. There are times when you want to offload everything to the client, like if you're making games, but for simple web pages like blog posts, the benefits are very neligable if not detriemental. See ◊a[#:href "https://v8.dev/blog/cost-of-javascript-2019"]{The Costs Of Javascript} for more details. 

◊sub-heading{Back to plain html}
We've all been given the advice to keep some form of a wiki, but most of them are written in PHP, with the exception of a slight few. For a while now I've used ◊a[#:href "https://tiddlywiki.com"]{TiddlyWiki} for blogging. It stores everything in one giant index.html file, which makes it very portable because you just drag 1 file to a flash drive and you're done, however this does not scale well because there's no segmentation. Everyone must download every post you have ever written even if they're not going to read them. What I need from a wiki is a version history, fast load times, and a good markup language. Using git solves one of those problems but what about the other two?

◊sub-heading{Pollen and Racket(Lisp)}
I discovered ◊a[#:href "https://docs.racket-lang.org/pollen/"]{Pollen}! A ◊b{programmable markup language}. It's awesome.

◊code[#:class "language-scheme"]{(2^ 4)} expands and renders nicely as ◊(2^ 4) , which is a pain to write in plain html:

◊code[#:class "language-html"]{
    <span>2<sup>4</sup></span>
}

Generating tables turns from this:
◊pre{
    ◊(code #:class "language-html"
    "<table>
 <caption>4 in binary</caption>
 <thead><tr><th>8</th><th>4</th><th>2</th><th>1</th></tr></thead>
 <tbody><tr><td>0</td><td>1</td><td>0</td><td>0</td></tr></tbody>
 </table>
")
}

to this function call:
◊code[#:class "language-scheme"]{(deci->bin-table 4 4 #:caption "4 in binary")}

◊(deci->bin-table 4 4 #:caption "4 in binary")

It automates all the boring stuff with ease! The web should have adopted a LISP. All the problems of web development, e.g templating, css frameworks, frontend frameworks, etc, exist in part because HTML and CSS are not programmable. Rather than have the web split into 3 languages, we could have a unified extensible LISP. Today we suffer the consequences of Netscape culting around Java and rejecting ◊a[#:href "http://speakingjs.com/es5/ch04.html"]{Eichs} idea for a LISP. A lot of people have misgivings about LISP and it's parentheses, but I'd rather LISP than install and deal with ton of frameworks.

P.S: If you MUST use a frontend framework, use ◊a[#:href "https://svelte.dev/"]{Svelte}, because it has significantly less overhead by way of not having to diff everything using a virtual dom like react or vue does. Note that I am cheating a little by using prism.js for syntax highlighting because I don't want to deal with dependencies.

◊h3{Similar posts:}
◊a[#:href "https://terrytao.wordpress.com/career-advice/theres-more-to-mathematics-than-rigour-and-proofs/"]{There’s more to mathematics than rigour and proofs}

◊a[#:href "https://youtu.be/JjDsP5n2kSM"]{Jonathan Blow - How to program independent games - CSUA Speech}

◊a[#:href "https://cbloomrants.blogspot.com/2011/11/11-22-11-mature-programmer.html"]{
    The Mature Programmer
}