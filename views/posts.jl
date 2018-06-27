<extend src="layout.jl">
    <block name="content">
        <p>There are no posts.</p>

        <a
            if=paginator.canGoForward
            href=path + '?page=' + paginator.current.nextPage>
            More
        </a>
    </block>
</extend>