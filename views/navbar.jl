<nav>
    <ul>
        <li class="header">
            <img src="/favicon-white.png">
            <a href="/">Angel News</a>
        </li>
        <li>
            <a href="/new">new</a>
        </li>
        <li>
            <a href="/show">show</a>
        </li>
        <li>
            <a href="/ask">ask</a>
        </li>
        <li if=user != null>
            <a href="/submit">submit</a>
        </li>
    </ul>
    <ul if=user == null class="right">
        <li>
            <a href="/login">login</a>
        </li>
    </ul>
    <ul if=user != null class="right">
        <li>{{ user.username }} ({{ user.karma }})</li>
        <li><a href="/auth/logout">logout</a></li>
    </ul>
</nav>