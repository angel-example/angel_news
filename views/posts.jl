<extend src="layout.jl">
    <block name="content">
        <include src="post-item.jl"/>

        <p if=paginator.current.data.isEmpty>
            There are no posts.
        </p>
        <post-item
            for-each=paginator.current.data
            @post=item
            class="post-info" />
        <br>
        <a
            if=paginator.current.nextPage != -1
            href=path + '?page=' + paginator.current.nextPage>
            More
        </a>
    </block>
</extend>