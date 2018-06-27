<!DOCTYPE html>
<html lang="en">
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
        i {
            color: red;
            display: block;
            margin-bottom: 1em;
        }
    </style>
</head>
<body>
<i if=bad_login>Incorrect username or password.</i>
<i if=bad_signup>Signup error. Maybe that user already exists?</i>
<b>Login</b>
<br>
<br>
<form action="/auth/login" method="post">
    <input type="hidden" name="goto" value=goto>
    <label for="loginUsername">username:</label>
    <input type="text" name="username" id="loginUsername">
    <br><br>
    <label for="loginPassword">password:</label>
    <input type="password" name="password" id="loginPassword">
    <br><br>
    <input type="submit" value="login">
</form>
<br>
<br>
<b>Create Account</b>
<br>
<br>
<form action="/auth/create_account" method="post">
    <input type="hidden" name="goto" value=goto>
    <label for="signupUsername">username:</label>
    <input type="text" name="username" id="signupUsername">
    <br><br>
    <label for="signupPassword">password:</label>
    <input type="password" name="password" id="signupPassword">
    <br><br>
    <input type="submit" value="create account">
</form>
</body>
</html>