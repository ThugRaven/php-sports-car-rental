{extends file="main.tpl"}

{block name=content}
    <div class="form__header">
        <form id="cars-form" onsubmit="ajaxPostForm('cars-form', '{url action='carsList'}', 'cars-table');
                return false;">
            <div class="form__forms">
                <h1>Samochody</h1>
                <ul class="form__list">
                    <li class="form__item">
                        <label for="id_brand" class="form__label">Marka</label>
                        <select name="brand" id="id_brand" class="input__select">
                            <option value="">Wszystkie marki</option>
                            {foreach $brands as $b}
                                {strip}
                                    <option value="{$b}" {if $form->brand == $b}selected{/if}>{$b}</option>
                                {/strip}
                            {/foreach}
                        </select>
                    </li>
                    <li class="form__item">
                        <label for="id_model" class="form__label">Model</label>
                        <input
                            id="id_model"
                            type="text"
                            name="model"
                            value="{$form->model}"
                            class="input__text"
                            />
                    </li>
                    <li class="form__item">
                        <label for="id_transmission_type" class="form__label"
                               >Skrzynia</label
                        >
                        <select
                            name="transmission_type"
                            id="id_transmission_type"
                            class="input__select"
                            >
                            <option value="" {if $form->type == ''}selected{/if}>Wszystkie</option>
                            <option value="manual" {if $form->type == 'manual'}selected{/if}>Manualna</option>
                            <option value="automatic" {if $form->type == 'automatic'}selected{/if}>Automatyczna</option>
                        </select>
                    </li>
                    <li class="form__item">
                        <label for="id_drive" class="form__label">Napęd</label>
                        <select name="drive" id="id_drive" class="input__select">
                            <option value="" {if $form->drive == ''}selected{/if}>Wszystkie</option>
                            <option value="FWD" {if $form->drive == 'FWD'}selected{/if}>Na przednie koła</option>
                            <option value="RWD" {if $form->drive == 'RWD'}selected{/if}>Na tylne koła</option>
                            <option value="AWD" {if $form->drive == 'AWD'}selected{/if}>Napęd 4x4</option>
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
    <div class="cars__grid" id="cars-table">
        {include file="CarsListTable.tpl"}
    </div>
    {include file='messages.tpl'}
{/block}