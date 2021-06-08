<!DOCTYPE HTML>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="pl" lang="pl">

    <head>
        <meta charset="utf-8"/>
        <title>Dashboard - Wynajmy - Edycja</title>
    </head>

    <body>
        <h3>Edycja wynajmu</h3>
        <form action="{url action='dashboardRentSave'}" method="post">
            {foreach from = $rent key = k item = v}
                {strip}
                    {if $k === 'id_rent_status'}
                        <label for="id_{$k}">{$inputs[$k][0]}: </label>
                        <select name="{$k}" id="id_{$k}">
                            {foreach $rent_statuses as $c}
                                {strip}
                                    <option value="{$c['id_rent_status']}" {if $rent['id_rent_status'] === $c['id_rent_status']}selected{/if}>{$c['status']}</option>
                                {/strip}
                            {/foreach}
                        </select><br />
                        {continue}
                    {/if}
                    {if $k === 'deposit'}
                        <label for="id_{$k}">{$inputs[$k][0]}: </label>
                        <input type="checkbox" id="id_{$k}" name="{$k}" {if $rent['deposit']}checked{/if}/><br />
                        {continue}
                    {/if}
                    <label for="id_{$k}" class="label">{$inputs[$k][0]}: </label>
                    <input type="text" id="id_{$k}" name="{$k}" value="{$v}" {if $k === 'id_rent' || $k === 'id_car' || $k === 'id_user'}disabled{/if}/><br />
                {/strip}
            {/foreach}

            <input type="hidden" name="id_rent" value="{$rent['id_rent']}" />
            <br />
            <input type="submit" value="Zapisz" class="primary">
        </form>

        <a href="{url action='main'}">Wróć na stronę główną</a>

        {include file='messages.tpl'}
    </body>

</html>