{extends file="main.tpl"}

{block name=content}
    <div class="form__header">

        <form id="dash-rents-form" onsubmit="ajaxPostForm('dash-rents-form', '{url action='dashboardRentsList'}', 'dash-rents-table');
                return false;">
            <div class="form__forms">
                <h1 class="heading">Dashboard - Wynajmy</h1>
                <ul class="form__list">
                    <li class="form__item">
                        <label for="id_id_car" class="form__label">Pojazd</label>
                        <select name="id_car" id="id_id_car" class="input__select">
                            <option value="">Wszystkie pojazdy</option>
                            {foreach $cars as $c}
                                {strip}
                                    <option value="{$c['id_car']}" {if $form->id_car == $c['id_car']}selected{/if}>{$c['id_car']} - {$c['brand']} {$c['model']}</option>
                                {/strip}
                            {/foreach}
                        </select>
                    </li>
                    <li class="form__item">
                        <label for="id_id_rent" class="form__label">ID Wynajmu</label>
                        <input id="id_id_rent" type="number" name="id_rent" value="{$form->id_rent}" class="input__text"/>
                    </li>
                    <li class="form__item">
                        <label for="id_id_user" class="form__label">ID Użytkownika</label>
                        <input id="id_id_user" type="number" name="id_user" value="{$form->id_user}" class="input__text"/>
                    </li>
                    <li class="form__item">
                        <label for="id_status" class="form__label">Status</label>
                        <select name="status" id="id_status" class="input__select">
                            <option value="" {if $form->status == ''}selected{/if}>Wszystkie</option>
                            <option value="active" {if $form->status == 'active'}selected{/if}>Aktywne</option>
                            <option value="completed" {if $form->status == 'completed'}selected{/if}>Zakończone</option>
                        </select>
                    </li>
                    <li class="form__item">
                        <label for="id_deposit" class="form__label">Kaucja</label>
                        <select name="deposit" id="id_deposit" class="input__select">
                            <option value="" {if $form->deposit == ''}selected{/if}>Wszystkie</option>
                            <option value="1" {if $form->deposit == '1'}selected{/if}>Tak</option>
                            <option value="0" {if $form->deposit == '0'}selected{/if}>Nie</option>
                        </select>

                    </li>
                    <li class="form__item">
                        <label for="id_payment_type" class="form__label">Rodzaj płatności</label>
                        <select name="payment_type" id="id_payment_type" class="input__select">
                            <option value="" {if $form->payment_type == ''}selected{/if}>Wszystkie</option>
                            <option value="card" {if $form->payment_type == 'card'}selected{/if}>Karta</option>
                            <option value="money" {if $form->payment_type == 'money'}selected{/if}>Gotówka</option>
                        </select>
                    </li>
                    <li class="form__item">
                        <label for="id_order" class="form__label">Sortuj</label>
                        <select name="order" id="id_order" class="input__select">
                            {foreach $orders as $o}
                                {strip}
                                    <option value="{$o[0]}" {if $form->order == $o[0]}selected{/if}>{$o[1]}</option>
                                {/strip}
                            {/foreach}
                        </select>
                    </li>
                    <li class="form__item">
                        <label for="id_page_size" class="form__label">Rekordy</label>
                        <select
                            name="page_size"
                            id="id_page_size"
                            class="input__select"
                            >
                            <option value="10" {if $form->page_size == '10'}selected{/if}>10</option>
                            <option value="25" {if $form->page_size == '25'}selected{/if}>25</option>
                            <option value="50" {if $form->page_size == '50'}selected{/if}>50</option>
                            <option value="100" {if $form->page_size == '100'}selected{/if}>100</option>
                        </select>
                    </li>
                </ul>
            </div>

            <div class="form__buttons">
                <input
                    type="submit"
                    value="Szukaj"
                    class="button button--rounded button--form button--submit"
                    />
                <input
                    type="reset"
                    value="Wyczyść"
                    class="button button--rounded button--form button--reset"
                    />
            </div>
        </form>
    </div>
    <div class="cars__grid" id="dash-rents-table">
        {include file="DashboardRentsTable.tpl"}
    </div>
    {include file='messages.tpl'}
{/block}