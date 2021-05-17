<!DOCTYPE HTML>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="pl" lang="pl">

    <head>
        <meta charset="utf-8"/>
        <title>Logowanie</title>
    </head>

    <body>

        <form action="{url action='login'}" method="post">
            <label for="id_login" class="label">Login: </label>
            <input id="id_login" type="text" name="login" value="{$form->login}"/>
            <label for="id_pass" class="label">Hasło: </label>
            <input id="id_pass" type="password" name="password" value="{$form->password}" />
            <br />
            <input type="submit" value="Zaloguj" class="primary">
        </form>

        {include file='messages.tpl'}
    </body>

</html>