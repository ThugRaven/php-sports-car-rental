<!DOCTYPE HTML>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="pl" lang="pl">

    <head>
        <meta charset="utf-8"/>
        <title>Moje konto</title>
    </head>

    <body>

        <ul>
            <li>{$records['login']}</li>
            <li>{$records['email']}</li>
            <li>{$records['role_name']}</li>
            <li>{$records['name']}</li>
            <li>{$records['surname']}</li>
            <li>{$records['phone_number']}</li>
            <li>{$records['rents']}</li>
            <li>{$records['verified']}</li>
            <li>{$records['birth_date']}</li>
        </ul>

        <a href="{url action='main'}">Wróć na stronę główną</a>

        {include file='messages.tpl'}
    </body>

</html>