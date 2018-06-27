<extend src="layout.jl">
    <block name="content">
        <form action="/submit" method="post">
            <label for="title">title</label>
            <input id="title" name="title" type="text" size="50" required>
            <br><br>
            <label for="url">url&nbsp;&nbsp;</label>
            <input id="url" name="link" type="text" size="50">
            <br><br>
            <b style="margin-left: 3em">or</b>
            <br><br>
            <label for="text" style="top: -1.5em; position: relative;">text&nbsp;</label>
            <textarea id="text" name="text" rows="4" cols="49"></textarea>
            <br><br>
            <input style="margin-left: 3em" value="submit" type="submit">
        </form>
        <script>
            document.getElementById('text').value = '';
        </script>
    </block>
</extend>