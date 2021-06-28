{if $numOfRecords > 0}
    {include file="pagination_top.tpl"}

    <table class="table table--dash">
        <thead>
            <tr>
                <th>ID Użytkownika</th>
                <th>Login</th>
                <th>Imię</th>
                <th>Nazwisko</th>
                <th>Numer telefonu</th>
                <th>Liczba wypożyczeń</th>
                <th>Zweryfikowany</th>
                <th>Data utworzenia</th>
                <th>Rola</th>
                <th>Edycja</th>
            </tr>
        </thead>
        <tbody>
            {foreach $records as $r}
                {strip}
                    <tr>
                        <td>{$r['id_user']}</td>
                        <td>{$r['login']}</td>
                        <td>{$r['name']}</td>
                        <td>{$r['surname']}</td>
                        <td>{$r['phone_number']}</td>
                        <td>{$r['rents']}</td>
                        {if $r['verified'] == '1'}<td class="td td--positive">Tak</td>{else if $r['verified'] == '0'}<td class="td td--negative">Nie</td>{/if}
                        <td>{$r['create_time']}</td>
                        <td>{$r['role_name']}</td>
                        <td><a href="{url action='dashboardUserEdit' id=$r['id_user']}" class="link">Edytuj</a></td>
                    </tr>
                {/strip}
            {/foreach}
        </tbody>
    </table>

    {include file="pagination_bottom.tpl"}
{else}
    Brak samochodów o podanych kryteriach!
{/if}