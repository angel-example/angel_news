<!DOCTYPE html>
<html lang="en">
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title if=title == null>Angel News</title>
        <title if=title != null>{{title}} | Angel News</title>
        <link rel="stylesheet" href="/site.css">
        <link rel="icon" href="/favicon.png">
    </head>
    <body>
        <include src="navbar.jl" />
        <main>
            <block name="content"></block>
        </main>
    </body>
</html>