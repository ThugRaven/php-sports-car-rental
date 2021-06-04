<!DOCTYPE HTML>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="pl" lang="pl">

    <head>
        <meta charset="utf-8"/>
        <title>Dashboard - Samochody - Edycja</title>
    </head>

    <body>

        <form action="{url action='dashboardCarSave' type='car'}" method="post">
            {foreach from = $car key = k item = v}
                {strip}
                    {if $k === 'rentable'}
                        <label for="id_{$k}">{$inputs[$k][0]}: </label>
                        <input type="checkbox" id="id_{$k}" name="{$k}" {if $car['rentable']}checked{/if}/>
                        {continue}
                    {/if}
                    <label for="id_{$k}" class="label">{$inputs[$k][0]}: </label>
                    <input type="text" id="id_{$k}" name="{$k}" value="{$v}" {if $k === 'id_car' || $k === 'id_car_price'}disabled{/if}/><br />
                {/strip}
            {/foreach}

            <input type="hidden" name="id_car" value="{$car['id_car']}" />
            <input type="hidden" name="id_car" value="{$car['id_car_price']}" />
            <br />
            <input type="submit" value="Zapisz" class="primary">
        </form>
        <form action="{url action='dashboardCarSave' type='car_price'}" method="post">
            {foreach from = $car_price key = k item = v}
                {strip}
                    <label for="id_{$k}" class="label">{$inputs[$k][0]}: </label>
                    <input type="text" id="id_{$k}" name="{$k}" value="{$v}" {if $k === 'id_car_price'}disabled{/if}/><br />
                {/strip}
            {/foreach}
            <input type="hidden" name="id_car_price" value="{$car_price['id_car_price']}" />
            <br />
            <input type="submit" value="Zapisz" class="primary">
        </form>

        <a href="{url action='main'}">Wróć na stronę główną</a>

        {include file='messages.tpl'}
    </body>

</html>