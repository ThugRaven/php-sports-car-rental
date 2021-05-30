<!DOCTYPE HTML>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="pl" lang="pl">

    <head>
        <meta charset="utf-8"/>
        <title>Rezerwacja</title>
    </head>

    <body>

        {include file='messages.tpl'}
        <ul>
            <li>{$form->id_car}</li>
            <li>Cena za dzień</li>
        </ul>
        <h1>Podsumowanie rezerwacji</h1>
        <form action="{url action='rent' step="step-1"}" method="post">
            <input type="checkbox" id="id_deposit" name="deposit" {if $form->deposit}checked{/if}/>
            <label for="id_deposit">Brak kaucji</label>

            <input type="hidden" name="id_car" value="{$form->id_car}" />
            <input type="hidden" name="rent_start" value="{$form->rent_start}" />
            <input type="hidden" name="rent_end" value="{$form->rent_end}" />
            <input type="hidden" name="payment_type" value="{$form->payment_type}" />

            <input type="submit" value="Potwierdz" class="primary"/>
        </form>
        Dane użytkownika
        <p>Cena: {$form->total_price}</p>
        <form action="{url action='rent' step="step-2"}" method="post">
            <input type="radio" id="id_money" name="payment_type" value="money" {if $form->payment_type == "money"}checked{/if}/>
            <label for="id_money">Gotówka</label>
            <input type="radio" id="id_card" name="payment_type" value="card" {if $form->payment_type == "card"}checked{/if}/>
            <label for="id_card">Karta kredytowa</label>
            <input type="hidden" name="id_car" value="{$form->id_car}" />
            <input type="hidden" name="rent_start" value="{$form->rent_start}" />
            <input type="hidden" name="rent_end" value="{$form->rent_end}" />
            <input type="hidden" name="deposit" value="{$form->deposit}" />
            <input type="hidden" name="total_price" value="{$form->total_price}" />

            <input type="submit" value="Wynajmij pojazd" class="primary">
        </form>
    </body>

</html>