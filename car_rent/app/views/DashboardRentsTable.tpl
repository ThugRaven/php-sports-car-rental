{if $numOfRecords > 0}
    {include file="pagination_top.tpl"}

    <table class="table table--dash">
        <thead>
            <tr>
                <th>ID Wynajmu</th>
                <th>ID Samochodu</th>
                <th>ID Użytkownika</th>
                <th>Początek wynajmu</th>
                <th>Koniec wynajmu</th>
                <th>Status</th>
                <th>Dystans</th>
                <th>Kaucja</th>
                <th>Kwota</th>
                <th>Rodzaj płatności</th>
                <th>Czas utworzenia</th>
                <th>Edycja</th>
            </tr>
        </thead>
        <tbody>
            {foreach $records as $r}
                {strip}
                    <tr>
                        <td>{$r['id_rent']}</td>
                        <td><a href="{url action='car' id=$r['id_car'] brand=$r['brand_url'] model=$r['model_url']}" class="link">{$r['id_car']}</a></td>
                        <td>{$r['id_user']}</td>
                        <td>{$r['rent_start']}</td>
                        <td>{$r['rent_end']}</td>
                        {if $r['status'] === 'active'}<td class="td td--positive">Aktywny</td>{else if $r['status'] === 'completed'}<td class="td td--negative">Zakończony</td>{/if}
                        <td>{$r['distance']}&nbsp;km</td>
                        <td>{if $r['deposit'] == '1'}Tak{else if $r['deposit'] == '0'}Nie{/if}</td>
                        <td>{$r['total_price']}&nbsp;zł</td>
                        <td>{if $r['payment_type'] === 'card'}Karta{else if $r['payment_type'] === 'money'}Gotówka{/if}</td>
                        <td>{$r['create_time']}</td>
                        <td><a href="{url action='dashboardRentEdit' id=$r['id_rent']}" class="link">Edytuj</td>
                    </tr>
                {/strip}
            {/foreach}
        </tbody>
    </table>

    {include file="pagination_bottom.tpl"}
{else}
    Brak wynajmów o podanych kryteriach!
{/if}