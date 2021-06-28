{extends file="main.tpl"}

{block name=content}
    <div class="edit__layout">
        <form action="{url action='dashboardRentSave'}" method="post" class="dash__form">
            <h1 class="heading">Edycja wynajmu</h1>
            <ul class="form__list form__list--dash">
                {foreach from = $rent key = k item = v}
                    {strip}
                        {if $k === 'id_rent_status'}
                            <li class="form__item form__item--dash">
                                <label for="id_{$k}" class="form__label">{$inputs[$k][0]}: </label>
                                <select name="{$k}" id="id_{$k}" class="input__select">
                                    {foreach $rent_statuses as $c}
                                        {strip}
                                            <option value="{$c['id_rent_status']}" {if $rent['id_rent_status'] === $c['id_rent_status']}selected{/if}>{$c['status']}</option>
                                        {/strip}
                                    {/foreach}
                                </select>
                            </li>
                            {continue}
                        {/if}
                        {if $k === 'deposit'}
                            <li class="form__item form__item--dash">
                                <label for="id_{$k}" class="form__label">{$inputs[$k][0]}: </label>
                                <input type="checkbox" id="id_{$k}" name="{$k}" {if $rent['deposit']}checked{/if}/>
                            </li>
                            {continue}
                        {/if}
                        <li class="form__item form__item--dash">
                            <label for="id_{$k}" class="form__label">{$inputs[$k][0]}: </label>
                            <input type="text" id="id_{$k}" name="{$k}" value="{$v}" {if $k === 'id_rent' || $k === 'id_car' || $k === 'id_user'}disabled{/if} class="input__text"/>
                        </li>
                    {/strip}
                {/foreach}
            </ul>

            <input type="hidden" name="id_rent" value="{$rent['id_rent']}" />
            <input type="submit" value="Zapisz" class="button button--rect button--full dash__button"/>
            <a href="{url action='dashboardRents'}" class="button button--rect button--empty dash__button">Wróć do listy</a>
        </form>
    </div>

    {include file='messages.tpl'}
{/block}