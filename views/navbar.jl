<nav>
    <ul>
        <li class="header"><a href="/">Angel News</a></li>
        <li>new</li>
        <li>show</li>
        <li>submit</li>
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