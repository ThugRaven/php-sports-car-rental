<!DOCTYPE HTML>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="pl" lang="pl">

    <head>
        <meta charset="utf-8"/>
        <title>Samochody</title>
    </head>

    <body>
        <form action="{url action='cars'}" method="post">
            <label for="id_brand">Marka pojazdu: </label>
            <select name="brand" id="id_brand">
                <option value="">Wszystkie marki</option>
                {foreach $brands as $b}
                    {strip}
                        <option value="{$b}" {if $form->brand == $b}selected{/if}>{$b}</option>
                    {/strip}
                {/foreach}
            </select>
            <label for="id_model">Model pojazdu: </label>
            <input id="id_model" type="text" name="model" value="{$form->model}"/>
            <label for="id_transmission_type">Skrzynia biegów: </label>
            <select name="transmission_type" id="id_transmission_type">
                <option value="" {if $form->type == ""}selected{/if}>Wszystkie</option>
                <option value="manual" {if $form->type == "manual"}selected{/if}>Manualna</option>
                <option value="automatic" {if $form->type == "automatic"}selected{/if}>Automatyczna</option>
            </select>
            <label for="id_drive">Napęd: </label>
            <select name="drive" id="id_drive">
                <option value="" {if $form->drive == ""}selected{/if}>Wszystkie</option>
                <option value="FWD" {if $form->drive == "FWD"}selected{/if}>Na przednie koła</option>
                <option value="RWD" {if $form->drive == "RWD"}selected{/if}>Na tylne koła</option>
                <option value="AWD" {if $form->drive == "AWD"}selected{/if}>Napęd 4x4</option>
            </select>
            <label for="id_order">Sortuj: </label>
            <select name="order" id="id_order">
                {foreach $orders as $o}
                    {strip}
                        <option value="{$o[0]}" {if $form->order == $o[0]}selected{/if}>{$o[1]}</option>
                    {/strip}
                {/foreach}
            </select>
            <br />
            <input type="submit" value="Szukaj" class="primary">
            <input type="reset" value="Wyczyść" class="primary">
        </form>

        <div>
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
                                <td>{$r["id_car"]}</td>
                                <td>{$r["brand"]}</td>
                                <td>{$r["model"]}</td>
                                <td>{$r["eng_power"]}</td>
                                <td>{$r["eng_torque"]}</td>
                                <td><a href="{url action='car' id=$r["id_car"] brand=$r["brand_url"] model=$r["model_url"]}">Zarezerwuj</a></td>
                            </tr>
                        {/strip}
                    {/foreach}
                </tbody>
            </table>
        </div>

        {include file='messages.tpl'}


    </body>

</html>