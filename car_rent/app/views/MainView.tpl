<!DOCTYPE HTML>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="pl" lang="pl">

    <head>
        <meta charset="utf-8"/>
        <title>Car Rent</title>
    </head>

    <body>

        Strona Główna
        {if !empty($user->role)}
            <li>Zalogowano jako {$user->role}</li>
            <li><a href="{url action='logout'}">Wyloguj się</a></li>
            <li><a href="{url action='account' login=$user->login}">Moje konto</a></li>
            {else}
            <li><a href="{url action='login'}">Zaloguj się</a></li>
        {/if}
        <hr />
        <a href="{url action='login'}">Zaloguj się</a>
        <a href="{url action='registration'}">Zarejestruj się</a>
        <a href="{url action='cars'}">Samochody</a>
        {if \core\RoleUtils::inRole('admin')}<a href="{url action='dashboard'}">Dashboard</a>{/if}


        {include file='messages.tpl'}


    </body>

</html>