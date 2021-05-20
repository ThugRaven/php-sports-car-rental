<!DOCTYPE HTML>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="pl" lang="pl">

    <head>
        <meta charset="utf-8"/>
        <title>Samochód</title>
    </head>

    <body>
        <ul>
            <li>{$records["id_car"]}</li>
            <li>{$records["brand"]}</li>
            <li>{$records["model"]}</li>
            <li>{$records["eng_power"]}</li>
            <li>{$records["eng_torque"]}</li>
        </ul>

        {include file='messages.tpl'}


    </body>

</html>