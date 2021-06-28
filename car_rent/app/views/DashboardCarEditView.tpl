{extends file="main.tpl"}

{block name=content}
    <div class="edit__layout">
        <form action="{url action='dashboardCarSave' type='car'}" method="post" class="dash__form">
            <h1 class="heading">Edycja pojazdu</h1>
            <ul class="form__list form__list--dash">
                {foreach from = $car key = k item = v}
                    {strip}
                        {if $k === 'id_car_price'}
                            <li class="form__item form__item--dash">
                                <label for="id_{$k}" class="form__label">{$inputs[$k][0]}: </label>
                                <select name="{$k}" id="id_{$k}" class="input__select">
                                    {foreach $car_prices as $c}
                                        {strip}
                                            <option value="{$c}" {if $car_price['id_car_price'] === $c}selected{/if}>{$c}</option>
                                        {/strip}
                                    {/foreach}
                                </select>
                            </li>
                            {continue}
                        {/if}
                        {if $k === 'rentable'}
                            <li class="form__item form__item--dash">
                                <label for="id_{$k}" class="form__label">{$inputs[$k][0]}: </label>
                                <input type="checkbox" id="id_{$k}" name="{$k}" {if $car['rentable']}checked{/if}/>
                            </li>
                            {continue}
                        {/if}
                        <li class="form__item form__item--dash">
                            <label for="id_{$k}" class="form__label">{$inputs[$k][0]}: </label>
                            <input type="text" id="id_{$k}" name="{$k}" value="{$v}" {if $k === 'id_car'}disabled{/if} class="input__text"/>
                        </li>
                    {/strip}
                {/foreach}
            </ul>

            <input type="hidden" name="id_car" value="{$car['id_car']}" />
            <input type="submit" value="Zapisz" class="button button--rect button--full dash__button">
        </form>
        <form action="{url action='dashboardCarSave' type='car_price'}" method="post" class="dash__form">
            <h1 class="heading">Edycja cen</h1>
            <ul class="form__list form__list--dash">
                {foreach from = $car_price key = k item = v}
                    {strip}
                        {if $k === 'id_car_price'}
                            <li class="form__item form__item--dash">
                                <label for="id_{$k}" class="form__label">{$inputs[$k][0]}: </label>
                                <select name="{$k}" id="id_{$k}" class="input__select">
                                    {foreach $car_prices as $c}
                                        {strip}
                                            <option value="{$c}" {if $car_price['id_car_price'] === $c}selected{/if}>{$c}</option>
                                        {/strip}
                                    {/foreach}
                                </select>
                            </li>
                            {continue}
                        {/if}
                        <li class="form__item form__item--dash">
                            <label for="id_{$k}" class="form__label">{$inputs[$k][0]}: </label>
                            <input type="text" id="id_{$k}" name="{$k}" value="{$v}" class="input__text"/>
                        </li>
                    {/strip}
                {/foreach}
            </ul>
            <input type="submit" value="Zapisz" class="button button--rect button--full dash__button">
            <a href="{url action='dashboardCars'}" class="button button--rect button--empty dash__button">Wróć do listy</a>
        </form>
    </div>

    {include file='messages.tpl'}
{/block}