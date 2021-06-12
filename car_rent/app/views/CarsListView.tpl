<!DOCTYPE HTML>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="pl" lang="pl">

    <head>
        <meta charset="utf-8"/>
        <title>Samochody</title>
        <script type="text/javascript" src="{$conf->app_url}/js/functions.js"></script>
    </head>

    <body>
        {*        <form action="{url action='cars'}" method="post">*}
        <form id="cars_form" onsubmit="ajaxPostForm('cars_form', '{url action='carsList'}', 'table');
                return false;">
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
                <option value="" {if $form->type == ''}selected{/if}>Wszystkie</option>
                <option value="manual" {if $form->type == 'manual'}selected{/if}>Manualna</option>
                <option value="automatic" {if $form->type == 'automatic'}selected{/if}>Automatyczna</option>
            </select>
            <label for="id_drive">Napęd: </label>
            <select name="drive" id="id_drive">
                <option value="" {if $form->drive == ''}selected{/if}>Wszystkie</option>
                <option value="FWD" {if $form->drive == 'FWD'}selected{/if}>Na przednie koła</option>
                <option value="RWD" {if $form->drive == 'RWD'}selected{/if}>Na tylne koła</option>
                <option value="AWD" {if $form->drive == 'AWD'}selected{/if}>Napęd 4x4</option>
            </select>
            <label for="id_order">Sortuj: </label>
            <select name="order" id="id_order">
                {foreach $orders as $o}
                    {strip}
                        <option value="{$o[0]}" {if $form->order == $o[0]}selected{/if}>{$o[1]}</option>
                    {/strip}
                {/foreach}
            </select>
            <label for="id_page_size">Liczba rekordów na stronę: </label>
            <select name="page_size" id="id_page_size">
                <option value="10" {if $form->page_size == '10'}selected{/if}>10</option>
                <option value="25" {if $form->page_size == '25'}selected{/if}>25</option>
                <option value="50" {if $form->page_size == '50'}selected{/if}>50</option>
                <option value="100" {if $form->page_size == '100'}selected{/if}>100</option>
            </select>
            <br />
            <input type="submit" value="Szukaj" class="primary"/>
            <input type="reset" value="Wyczyść" class="primary"/>
        </form>

        {if $numOfRecords > 0}
            <div id='table'>
                {include file="CarsListTable.tpl"}
            </div>
        {/if}

        {include file='messages.tpl'}


    </body>

</html>