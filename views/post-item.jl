<element name="post-item">
    <div class="votearrow"></div>
    <a href=post.linkTo>
        {{ post.title }}
        <span if=post.isLink class="sub">({{ post.hostname }})</span>
    </a>
    <br>
    <span class="sub push">
        {{ post.karma }} points
        by <a href="/user/" + post.user.username>{{ post.user.username }}</a>
        <a href="/post/" + post.id>
            {{ post.fuzzyTime }}
        </a>
    </span>
    <span class="sub">
        |
        <a href="/post/" + post.id>
            0 comments
        </a>
    </span>
</element>