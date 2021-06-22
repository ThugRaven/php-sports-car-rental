{if $numOfRecords > 0}
    <table>
        <thead>
            <tr>
                <th>ID Samochodu</th>
                <th>Marka</th>
                <th>Model</th>
                <th>Moc silnika</th>
                <th>Moment obrotowy</th>
            </tr>
        </thead>
        <tbody>
            {foreach $records as $r}
                {strip}
                    <tr>
                        <td>{$r['id_car']}</td>
                        <td>{$r['brand']}</td>
                        <td>{$r['model']}</td>
                        <td>{$r['eng_power']}</td>
                        <td>{$r['eng_torque']}</td>
                        <td><a href="{url action='car' id=$r['id_car'] brand=$r['brand_url'] model=$r['model_url']}">Zarezerwuj</a></td>
                    </tr>
                {/strip}
            {/foreach}
        </tbody>
    </table>

    <form method="post">
        <div>
            Liczba rekordów {$pageRecords} z {$numOfRecords}
            <br />
            <button onclick="ajaxPostForm('cars_form', '{url action='carsList' p=$pagination->firstPage}', 'table');
                    return false;">|<</button>
            <button onclick="ajaxPostForm('cars_form', '{url action='carsList' p=$pagination->page - 1}', 'table');
                    return false;"><</button>
            Strona {$pagination->page} z {$pagination->lastPage}
            <button onclick="ajaxPostForm('cars_form', '{url action='carsList' p=$pagination->page + 1}', 'table');
                    return false;">></button>
            <button onclick="ajaxPostForm('cars_form', '{url action='carsList' p=$pagination->lastPage}', 'table');
                    return false;">>|</button>
        </div>
    </form>
{/if}