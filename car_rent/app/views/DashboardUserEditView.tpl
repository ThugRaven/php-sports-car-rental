{extends file="main.tpl"}

{block name=content}
    <div class="edit__layout">
        <form action="{url action='dashboardUserSave'}" method="post" class="dash__form">
            <h1 class="heading">Edycja użytkownika</h1>
            <ul class="form__list form__list--dash">
                {foreach from = $users key = k item = v}
                    {strip}
                        {if $k === 'role_name'}
                            <li class="form__item form__item--dash">
                                <label for="id_{$k}" class="form__label">{$inputs[$k][0]}: </label>
                                <select name="{$k}" id="id_{$k}" class="input__select">
                                    {foreach $roles as $r}
                                        {strip}
                                            <option value="{$r}" {if $users['role_name'] === $r}selected{/if}>{$r}</option>
                                        {/strip}
                                    {/foreach}
                                </select>
                            </li>
                            {continue}
                        {/if}
                        {if $k === 'verified'}
                            <li class="form__item form__item--dash">
                                <label for="id_{$k}" class="form__label">{$inputs[$k][0]}: </label>
                                <input type="checkbox" id="id_{$k}" name="{$k}" {if $users['verified']}checked{/if}/><br />
                            </li>
                            {continue}
                        {/if}
                        <li class="form__item form__item--dash">
                            <label for="id_{$k}" class="form__label">{$inputs[$k][0]}: </label>
                            <input type="text" id="id_{$k}" name="{$k}" value="{$v}" {if $k === 'id_user' || $k === 'id_user_role'}disabled{/if} class="input__text"/>
                        </li>
                    {/strip}
                {/foreach}
            </ul>

            <input type="hidden" name="id_user" value="{$users['id_user']}" />
            <input type="hidden" name="id_user_role" value="{$users['id_user_role']}" />
            <input type="submit" value="Zapisz" class="button button--rect button--full dash__button">
            <a href="{url action='dashboardUsers'}" class="button button--rect button--empty dash__button">Wróć do listy</a>
        </form>
    </div>

    {include file='messages.tpl'}
{/block}