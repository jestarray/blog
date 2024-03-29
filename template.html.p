<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://unpkg.com/sanitize.css" rel="stylesheet" />
    <link rel="stylesheet" type="text/css" media="all" href="/styles.css" />
    ◊(define has-code-block? (select 'code doc))
    ◊when/splice[has-code-block?]{
    <script src="/prism_highlight.js"></script>
    <link rel="stylesheet" type="text/css" media="all" href="/prism.css" />
    }
    <title>◊select['h1 doc]</title>
</head>

<body>
    <div class="container">
        <main class="main-wrapper">
            ◊(define prev-page (previous here))
            ◊when/splice[prev-page]{
            <div id="prev">← <a href="/◊|prev-page|"> ◊(select 'h1 prev-page)</a></div>}
            <div id="home"><a href="/index.html">Index</a></div>
            ◊(define next-page (next here))
            ◊when/splice[next-page]{
            <div id="next"><a href="/◊|next-page|">◊(select 'h1 next-page)</a> →</div>}
            <article>
                ◊(->html doc #:splice? #t)
            </article>
        </main>
    </div>
</body>

</html>