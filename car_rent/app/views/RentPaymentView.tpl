<!DOCTYPE HTML>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="pl" lang="pl">

    <head>
        <meta charset="utf-8"/>
        <title>Rezerwacja</title>
    </head>

    <body>

        {include file='messages.tpl'}
        <ul>
            <li>{$form->id_car}</li>
            <li>{$form->total_price}</li>
        </ul>
        <h1>Płatność rezerwacji</h1>

        <form action="{url action='rent' step="step-3"}" method="post">
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