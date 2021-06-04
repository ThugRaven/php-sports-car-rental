<!DOCTYPE HTML>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="pl" lang="pl">

    <head>
        <meta charset="utf-8"/>
        <title>Dashboard - Użytkownicy - Edycja</title>
    </head>

    <body>

        <form action="{url action='dashboardUserSave'}" method="post">
            {foreach from = $users key = k item = v}
                {strip}
                    {if $k === 'verified'}
                        <label for="id_{$k}">{$inputs[$k][0]}: </label>
                        <input type="checkbox" id="id_{$k}" name="{$k}" {if $users['verified']}checked{/if}/><br />
                        {continue}
                    {/if}
                    {if $k === 'role_name'}
                        <label for="id_{$k}">{$inputs[$k][0]}: </label>
                        <select name="{$k}" id="id_{$k}">
                            {foreach $roles as $r}
                                {strip}
                                    <option value="{$r}" {if $users['role_name'] === $r}selected{/if}>{$r}</option>
                                {/strip}
                            {/foreach}
                        </select>
                        {continue}
                    {/if}
                    <label for="id_{$k}" class="label">{$inputs[$k][0]}: </label>
                    <input type="text" id="id_{$k}" name="{$k}" value="{$v}" {if $k === 'id_user' || $k === 'id_user_role'}disabled{/if}/><br />
                {/strip}
            {/foreach}

            <input type="hidden" name="id_user" value="{$users['id_user']}" />
            <input type="hidden" name="id_user_role" value="{$users['id_user_role']}" />
            <br />
            <input type="submit" value="Zapisz" class="primary">
        </form>

        <a href="{url action='main'}">Wróć na stronę główną</a>

        {include file='messages.tpl'}
    </body>

</html>