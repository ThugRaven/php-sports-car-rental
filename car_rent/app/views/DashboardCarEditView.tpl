<!DOCTYPE HTML>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="pl" lang="pl">

    <head>
        <meta charset="utf-8"/>
        <title>Dashboard - Samochody - Edycja</title>
    </head>

    <body>
        <h3>Edycja pojazdu</h3>
        <form action="{url action='dashboardCarSave' type='car'}" method="post">
            {foreach from = $car key = k item = v}
                {strip}
                    {if $k === 'id_car_price'}
                        <label for="id_{$k}">{$inputs[$k][0]}: </label>
                        <select name="{$k}" id="id_{$k}">
                            {foreach $car_prices as $c}
                                {strip}
                                    <option value="{$c}" {if $car_price['id_car_price'] === $c}selected{/if}>{$c}</option>
                                {/strip}
                            {/foreach}
                        </select><br />
                        {continue}
                    {/if}
                    {if $k === 'rentable'}
                        <label for="id_{$k}">{$inputs[$k][0]}: </label>
                        <input type="checkbox" id="id_{$k}" name="{$k}" {if $car['rentable']}checked{/if}/>
                        {continue}
                    {/if}
                    <label for="id_{$k}" class="label">{$inputs[$k][0]}: </label>
                    <input type="text" id="id_{$k}" name="{$k}" value="{$v}" {if $k === 'id_car'}disabled{/if}/><br />
                {/strip}
            {/foreach}

            <input type="hidden" name="id_car" value="{$car['id_car']}" />
            <br />
            <input type="submit" value="Zapisz" class="primary">
        </form>
        <h3>Edycja cen</h3>
        <form action="{url action='dashboardCarSave' type='car_price'}" method="post">
            {foreach from = $car_price key = k item = v}
                {strip}
                    {if $k === 'id_car_price'}
                        <label for="id_{$k}">{$inputs[$k][0]}: </label>
                        <select name="{$k}" id="id_{$k}">
                            {foreach $car_prices as $c}
                                {strip}
                                    <option value="{$c}" {if $car_price['id_car_price'] === $c}selected{/if}>{$c}</option>
                                {/strip}
                            {/foreach}
                        </select><br />
                        {continue}
                    {/if}
                    <label for="id_{$k}" class="label">{$inputs[$k][0]}: </label>
                    <input type="text" id="id_{$k}" name="{$k}" value="{$v}"/><br />
                {/strip}
            {/foreach}
            <br />
            <input type="submit" value="Zapisz" class="primary">
        </form>

        <a href="{url action='main'}">Wróć na stronę główną</a>

        {include file='messages.tpl'}
    </body>

</html>