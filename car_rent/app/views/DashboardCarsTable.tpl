{if $numOfRecords > 0}
    {include file="pagination_top.tpl"}

    <table class="table table--dash">
        <thead>
            <tr>
                <th>ID Samochodu</th>
                <th>Marka</th>
                <th>Model</th>
                <th>Rejestracja</th>
                <th>Przebieg</th>
                <th>Wypożyczalny</th>
                <th>Galeria</th>
                <th>Edycja</th>
                <th>Wypożyczalność</th>
            </tr>
        </thead>
        <tbody>
            {foreach $records as $r}
                {strip}
                    <tr>
                        <td>{$r['id_car']}</td>
                        <td><a href="{url action='car' id=$r['id_car'] brand=$r['brand_url'] model=$r['model_url']}" class="link">{$r['brand']}</a></td>
                        <td><a href="{url action='car' id=$r['id_car'] brand=$r['brand_url'] model=$r['model_url']}" class="link">{$r['model']}</a></td>
                        <td>{$r['license_plate']}</td>
                        <td>{$r['mileage']}&nbsp;km</td>
                        {if $r['rentable'] == '1'}<td class="td td--positive">Tak</td>{else if $r['rentable'] == '0'}<td class="td td--negative">Nie</td>{/if}
                        {if $r['main_page'] > '0'}<td class="td td--positive">{$r['main_page']}</td>{else if $r['main_page'] == '0'}<td class="td td--negative">{$r['main_page']}</td>{/if}
                        <td><a href="{url action='dashboardCarEdit' id=$r['id_car']}" class="link">Edytuj</a></td>
                        <td><a href="{url action='dashboardCarBlock' id=$r['id_car']}" class="link">Zmień</a></td>
                    </tr>
                {/strip}
            {/foreach}
        </tbody>
    </table>

    {include file="pagination_bottom.tpl"}
{else}
    Brak samochodów o podanych kryteriach!
{/if}