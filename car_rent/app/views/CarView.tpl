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

        <form action="{url action='rent'}" method="post">
            <label for="id_rent_start" class="label">Od: </label>
            <input id="id_rent_start" type="datetime-local" step="900" name="rent_start" value="{$form->rent_start}"/><br />
            <label for="id_rent_end" class="label">Do: </label>
            <input id="id_rent_end" type="datetime-local" step="900" name="rent_end" value="{$form->rent_end}" />
            <input type="hidden" name="id_car" value="{$form->id_car}" />
            <br />
            <input type="submit" value="Wynajmij pojazd" class="primary">
        </form>
    </body>

</html>