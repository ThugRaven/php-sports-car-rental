<!DOCTYPE HTML>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="pl" lang="pl">

    <head>
        <meta charset="utf-8"/>
        <title>Dashboard - Wynajmy</title>
    </head>

    <body>

        <a href="{url action='dashboard'}">Dashboard</a>
        <a href="{url action='dashboardStats'}">Statystki</a>
        <a href="{url action='dashboardRents'}">Wynajmy</a>
        <a href="{url action='dashboardCars'}">Samochody</a>
        <a href="{url action='dashboardUsers'}">Użytkownicy</a>

        <form action="{url action='dashboardRents'}" method="post">
            <label for="id_id_car">Pojazd: </label>
            <select name="id_car" id="id_id_car">
                <option value="">Wszystkie pojazdy</option>
                {foreach $cars as $c}
                    {strip}
                        <option value="{$c['id_car']}" {if $form->id_car == $c['id_car']}selected{/if}>{$c['id_car']} - {$c['brand']} {$c['model']}</option>
                    {/strip}
                {/foreach}
            </select>
            <label for="id_id_rent">ID Wynajmu: </label>
            <input id="id_id_rent" type="number" name="id_rent" value="{$form->id_rent}"/>
            <label for="id_id_user">ID Użytkownika: </label>
            <input id="id_id_user" type="number" name="id_user" value="{$form->id_user}"/>
            <label for="id_status">Status: </label>
            <select name="status" id="id_status">
                <option value="" {if $form->status == ''}selected{/if}>Wszystkie</option>
                <option value="active" {if $form->status == 'active'}selected{/if}>Aktywne</option>
                <option value="completed" {if $form->status == 'completed'}selected{/if}>Zakończone</option>
            </select>
            <label for="id_deposit">Kaucja: </label>
            <select name="deposit" id="id_deposit">
                <option value="" {if $form->deposit == ''}selected{/if}>Wszystkie</option>
                <option value="1" {if $form->deposit == '1'}selected{/if}>Tak</option>
                <option value="0" {if $form->deposit == '0'}selected{/if}>Brak</option>
            </select>
            <label for="id_payment_type">Rodzaj płatności: </label>
            <select name="payment_type" id="id_payment_type">
                <option value="" {if $form->payment_type == ''}selected{/if}>Wszystkie</option>
                <option value="card" {if $form->payment_type == 'card'}selected{/if}>Karta</option>
                <option value="money" {if $form->payment_type == 'money'}selected{/if}>Gotówka</option>
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
            <input type="submit" value="Szukaj" class="primary"/>
            <input type="reset" value="Wyczyść" class="primary"/>
        </form>

        <div>
            <table>
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
                    </tr>
                </thead>
                <tbody>
                    {foreach $records as $r}
                        {strip}
                            <tr>
                                <td>{$r['id_rent']}</td>
                                <td>{$r['id_car']}</td>
                                <td>{$r['id_user']}</td>
                                <td>{$r['rent_start']}</td>
                                <td>{$r['rent_end']}</td>
                                <td>{$r['status']}</td>
                                <td>{$r['distance']}</td>
                                <td>{$r['deposit']}</td>
                                <td>{$r['total_price']}</td>
                                <td>{$r['payment_type']}</td>
                                {*                                            <td><a href="{url action='car' id=$r['id_car'] brand=$r['brand_url'] model=$r['model_url']}">Strona pojazdu</a></td>*}
                                <td><a href="{url action='dashboardRentEdit' id=$r['id_rent']}">Edytuj</a></td>
                            </tr>
                        {/strip}
                    {/foreach}
                </tbody>
            </table>
        </div>

        {include file='messages.tpl'}


    </body>

</html>