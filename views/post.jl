<extend src="layout.jl">
    <block name="content">
        <include src="post-item.jl"/>
        <post-item class="post-info"/>
        <br>
        <form method="post" action="/post/" + post.id + "/comment" style="padding-left: 1em;">
            <textarea id="text" name="text" rows="6" cols="60"></textarea>
            <br><br>
            <input type="submit" value="add comment">
        </form>
        <script>
            document.getElementById('text').value = '';
        </script>
    </block>
</extend>