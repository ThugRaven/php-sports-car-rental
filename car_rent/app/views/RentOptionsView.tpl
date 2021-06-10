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
        Dane użytkownika
        <p>Cena: {$form->total_price}</p>
        <h1>Podsumowanie rezerwacji</h1>
        <form action="{url action='rent'}" method="post">
            <input type="radio" id="id_deposit" name="deposit" value="deposit"{if $form->deposit === 'deposit'}checked{/if}/>
            <label for="id_deposit">Kaucja</label>
            <input type="radio" id="id_no_deposit" name="deposit" value="no_deposit"{if $form->deposit === 'no_deposit'}checked{/if}/>
            <label for="id_no_deposit">Brak kaucji</label><br />
            <input type="radio" id="id_money" name="payment_type" value="money" {if $form->payment_type === 'money'}checked{/if}/>
            <label for="id_money">Gotówka</label>
            <input type="radio" id="id_card" name="payment_type" value="card" {if $form->payment_type === 'card'}checked{/if}/>
            <label for="id_card">Karta kredytowa</label>

            <input type="hidden" name="id_car" value="{$form->id_car}" />
            <input type="hidden" name="rent_start" value="{$form->rent_start}" />
            <input type="hidden" name="rent_end" value="{$form->rent_end}" />

            <input type="submit" value="Potwierdz" class="primary"/>
        </form>

        <a href="{url action='rented'}">Wynajmij pojazd</a>
    </body>

</html>