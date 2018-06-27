<extend src="layout.jl">
    <block name="content">
        <p if=paginator.current.data.isEmpty>
            There are no posts.
        </p>

        <div for-each=paginator.current.data as="post" class="post-info">
            <a href=post.linkTo>
                {{ post.title }}
                <span if=post.isLink class="sub">({{ post.hostname }})</span>
            </a>
            <br>
            <span class="sub">
                {{ post.karma }} points
                by thosakwe
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
        </div>

        <br>
        <a
            if=paginator.current.nextPage != -1
            href=path + '?page=' + paginator.current.nextPage>
            More
        </a>
    </block>
</extend>